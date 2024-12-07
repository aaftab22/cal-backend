const path = require("path");
const projectService = require("../services/projectService");
const attachmentService = require("../services/attachmentService");
const taskService = require("../services/taskService");
const upload = require("../middlewares/multerConfig");
const subtaskService = require("../services/subtaskService");
const authService = require("../services/authService");
const fs = require("fs");
const sequelize = require('../config/database');
const dotenv = require('dotenv');

dotenv.config();

const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const {
  S3Client,
  GetObjectCommand,
  PutObjectCommand,
  DeleteObjectCommand,
} = require("@aws-sdk/client-s3");

const BucketName = "caliber-space";
const expiryTime = 3600;


const space = new S3Client({
  endpoint: "https://tor1.digitaloceanspaces.com",
  region: "ca-central-1",
  credentials: {
    accessKeyId: process.env.SPACES_ACCESS_KEY,
    secretAccessKey: process.env.SPACES_ACCESS_SECRET_KEY,
  },
});


const projectController = {
  //Projects Table Functions
  createProject: async (req, res) => {
    try {
      const projectData = JSON.parse(req.body.projectData);
      //PROJECT DETAILS
      const projectDetails = {};
      projectDetails.Project_Description = projectData.Project_Description;
      projectDetails.Address = projectData.Address;
      projectDetails.Post_Code = projectData.Post_Code;
      projectDetails.Contact_Phone = projectData.Contact_Phone;
      projectDetails.Contact_Email = projectData.Contact_Email;
      projectDetails.Created_By = projectData.Created_By;

      const { insertedId } = await projectService.createProject(projectDetails);

      //PROJECT TASKLIST
      const Tasklist = projectData.Tasklist;

      for (let i = 0; i < Tasklist.length; i++) {
        taskData = {};
        taskData.Project_ID = insertedId;
        taskData.Task_ID = Tasklist[i].Task_ID;
        currTask = Tasklist[i];
        await projectService.createProjectTask(taskData);

        //PROJECT SUBTASKLIST
        for (let i = 0; i < currTask.Subtasklist.length; i++) {
          tempSubTask = {};
          tempSubTask.Project_ID = insertedId;
          tempSubTask.Subtask_ID = currTask.Subtasklist[i].Subtask_ID;
          await projectService.createProjectSubtask(tempSubTask);
        }
        //PROJECT EMPLOYEE
        for (let i = 0; i < currTask.Employees.length; i++) {
          // console.log(currTask.Employees[i].Employee_ID);
          tempEmployee = currTask.Employees[i];
          tempEmployee.Project_ID = insertedId;
          tempEmployee.Task_Assigned = currTask.Task_ID;
          // console.log(tempEmployee);
          await projectService.AssignTask(tempEmployee);
        }
      }

      const attachments = req.files || [];
      console.log("Uploaded Attachments:", attachments);

      if (attachments.length > 0) {
        for (const file of attachments) {
          console.log(file)
          try {
            const s3Key = `projects/${insertedId}/${file.originalname}`;
            const uploadParams = {
              Bucket: BucketName,
              Key: s3Key,
              Body: fs.readFileSync(file.path), 
              ContentType: file.mimetype,
              ACL: "public-read", 
            };
            const uploadCommand = new PutObjectCommand(uploadParams);
            const response = await space.send(uploadCommand);
            // console.log("Upload successful:", response);
            const attachmentData = {
              Project_ID: insertedId,
              Attachment_Name: file.originalname,
              Attachment_Type: req.body.Attachment_Type || "Document",
              File_Format: path.extname(file.originalname).substring(1).toUpperCase(),
              File_Path: `https://${BucketName}.s3.amazonaws.com/${s3Key}`, 
            };
      
            console.log("Attachment Data:", attachmentData);
            await attachmentService.createAttachment(attachmentData);
            fs.unlinkSync(file.path);
          } catch (error) {
            console.error("Error uploading file to S3:", error);
          }
        }
      } else {
        console.log("No attachments uploaded.");
      }

      // Respond with success
      res.status(201).json({
        message: "Project created successfully",
        projectId: insertedId,
      });
    } catch (error) {
      console.error("Error in createProject:", error);
      res.status(500).json({
        message: "An error occurred while creating the project",
        error: error.message,
      });
    }
  },

  updateProject: async (req, res) => {
    const transaction = await sequelize.transaction();
    try {
      const projectId = req.params.id;
      const projectData = JSON.parse(req.body.projectData);

      const projectDetails = {
        Project_Description: projectData.Project_Description,
        Address: projectData.Address,
        Post_Code: projectData.Post_Code,
        Contact_Phone: projectData.Contact_Phone,
        Contact_Email: projectData.Contact_Email,
        Created_By: projectData.Created_By,
      };

      await projectService.updateProject(projectId, projectDetails,{ transaction });


      // First deleting the existing content
      const project = await projectService.getProjectTaskById(projectId,{ transaction })
      const projectJson = Object.values(project[0])
      const existingProjectTasks = projectJson.map(item => item.project_task_id);
      for (let i = 0; i<existingProjectTasks.length;i++){
        projectService.deleteProjectTask(existingProjectTasks[i],{ transaction })
      }
      // Recreating it
      const Tasklist = projectData.Tasklist;
      for (let i = 0; i < Tasklist.length; i++) {
        const taskData = {
          Project_ID: projectId,
          Task_ID: Tasklist[i].Task_ID,
        };
        await projectService.createProjectTask(taskData,{ transaction });

        const currTask = Tasklist[i];


        const projectsub = await projectService.getSubtasksByProject(projectId,{ transaction });
        const existingProjectSubTasks = projectsub.map(item => item.project_subtask_id);
        for (let i = 0; i<existingProjectSubTasks.length;i++){
          projectService.deleteProjectSubTask(existingProjectSubTasks[i],{ transaction })
        }


        for (let j = 0; j < (currTask.Subtasklist || []).length; j++) {
          const tempSubTask = {
            Project_ID: projectId,
            Subtask_ID: currTask.Subtasklist[j].Subtask_ID,
          };
          await projectService.createProjectSubtask(tempSubTask,{ transaction });
        }

        let assignedTasks = await projectService.getAssignedTasksByProject(projectId,{ transaction });
        const assignmentIds = assignedTasks.map(item => item.ASSIGNMENT_ID);

        for (let i = 0; i<assignmentIds.length;i++){
          projectService.deleteProjectAssignment(assignmentIds[i],{ transaction })
        }

        for (let j = 0; j < (currTask.Employees || []).length; j++) {
          const employee = currTask.Employees[j];
          const tempEmployee = {
            Employee_ID: employee.Employee_ID,
            Time_Start: employee.Time_Start,
            Time_Finish: employee.Time_Finish,
            Project_ID: projectId,
            Task_Assigned: currTask.Task_ID,
          };
          await projectService.AssignTask(tempEmployee,{ transaction });
        }
      }

      if (req.files && req.files.attachments) {
        for (const file of req.files.attachments) {
          const attachmentData = {
            Project_ID: projectId,
            Attachment_Name: file.originalname,
            Attachment_Type: file.mimetype || "Other",
            File_Format: path.extname(file.originalname).slice(1),
            File_Path: file.path,
          };

          // Save the new attachment to the database
          await attachmentService.createAttachment(attachmentData,{ transaction });
        }
      }
      await transaction.commit();
      res.status(200).json({ message: "Project updated successfully" });
    } catch (error) {
      await transaction.rollback();
      console.error("Error updating project:", error);
      res.status(400).json({ error: error.message });
    }
  },

  getProjects: async (req, res) => {
    try {
      const result = [];
      const projects = await projectService.getProjects();
      const projectData = Object.values(projects[0]);
      for (let i = 0; i < projectData.length; i++) {
        projectID = projectData[i].PROJECT_ID;

        const projectDetails = {
          projectData: {},
        };
        projectDetails.projectData.Project_ID = projectData[i].PROJECT_ID;
        projectDetails.projectData.Project_Description =
          projectData[i].Project_Description;
        projectDetails.projectData.Address = projectData[i].Address;
        projectDetails.projectData.Post_Code = projectData[i].Post_Code;
        projectDetails.projectData.Contact_Phone = projectData[i].Contact_Phone;
        projectDetails.projectData.Contact_Email = projectData[i].Contact_Email;
        projectDetails.projectData.Created_By = projectData[i].Created_By;
        projectDetails.projectData.Status = projectData[i].Status;
        projectDetails.Tasks = [];

        //get tasks
        tasks = await projectService.getProjectTaskById(projectID);
        taskData = Object.values(tasks[0]);
        for (let i = 0; i < taskData.length; i++) {
          let taskStructure = {
            Task_ID: taskData[i].Task_ID,
            Task_Name: "",
            Subtasks: [],
            Employees: [],
          };

          Task_Name = await taskService.getTaskById(taskStructure.Task_ID);
          task_Name_Data = Object.values(Task_Name[0]);
          taskname = task_Name_Data[0].Task_Name;
          taskStructure.Task_Name = taskname;

          subtask = await projectService.getSubtasksByProject(projectID);

          for (let x = 0; x < subtask.length; x++) {
            let currSubtask = subtask[x];

            let tempSubTask = {};
            tempSubTask.Subtask_ID = currSubtask.Subtask_ID;
            let masterSubtask = await subtaskService.GetSubtaskByID(
              tempSubTask.Subtask_ID
            );
            let masterSubtaskData = masterSubtask[0];
            tempSubTask.Subtask_Name = masterSubtaskData.Subtask_Name;
            tempSubTask.Related_Task = masterSubtaskData.Related_Task;

            if (tempSubTask.Related_Task == taskStructure.Task_ID) {
              console.log("MATCHING TASK");
              taskStructure.Subtasks.push(tempSubTask);
            }
          }

          assignedTasks = await projectService.getAssignedTasksByProject(
            projectID
          );
          for (let x = 0; x < assignedTasks.length; x++) {
            employee = await authService.getUserByID(
              assignedTasks[x].Employee_Assigned
            );
            employeeData = Object.values(employee);

            assignedTasks[
              x
            ].Employee_Name = `${employeeData[0].First_Name} ${employeeData[0].Last_Name}`;
            if (assignedTasks[x].Task_Assigned == taskStructure.Task_ID) {
              taskStructure.Employees.push(assignedTasks[x]);
            }
          }
          // console.log(taskStructure);
          projectDetails.Tasks.push(taskStructure);
        }

        timeframe = await projectService.getTimeFrameByProject(projectID);
        projectDetails.Timeframe = timeframe;

        const attachments = await attachmentService.getByProjectId(projectID);
        projectDetails.Attachments = attachments.map((attachment) => ({
          Attachment_ID: attachment.Attachment_ID,
          Attachment_Name: attachment.Attachment_Name,
          Attachment_Type: attachment.Attachment_Type,
          File_Format: attachment.File_Format,
          File_Path: attachment.File_Path,
        }));

        result.push(projectDetails);
      }

      res.status(201).json(result);
    } catch (error) {
      console.error("Error in getProjects:", error);
      res.status(500).json({ error: error.message });
    }
  },

  getProjectById: async (req, res) => {
    try {
      const projectId = req.params.id;
      const project = await projectService.getProjectById(projectId);
      if (project.length === 0) {
        return res.status(404).json({ error: "Project not found" });
      }

      const projectData = Object.values(project[0]);
      const currProjectID = projectData[0].PROJECT_ID;
      const result = {};
      // console.log(projectData[0]);
      result.ProjectData = projectData[0];
      result.Tasks = [];
      const tasks = await projectService.getProjectTaskById(currProjectID);
      const taskData = Object.values(tasks[0]);

      for (let i = 0; i < taskData.length; i++) {
        let taskStructure = {
          Task_ID: taskData[i].Task_ID,
          Task_Name: "",
          Subtasks: [],
          Employees: [],
        };

        Task_Name = await taskService.getTaskById(taskStructure.Task_ID);
        task_Name_Data = Object.values(Task_Name[0]);
        taskname = task_Name_Data[0].Task_Name;
        taskStructure.Task_Name = taskname;

        subtask = await projectService.getSubtasksByProject(currProjectID);

        for (let x = 0; x < subtask.length; x++) {
          let currSubtask = subtask[x];

          let tempSubTask = {};
          tempSubTask.Subtask_ID = currSubtask.Subtask_ID;
          let masterSubtask = await subtaskService.GetSubtaskByID(
            tempSubTask.Subtask_ID
          );
          let masterSubtaskData = masterSubtask[0];
          tempSubTask.Subtask_Name = masterSubtaskData.Subtask_Name;
          tempSubTask.Related_Task = masterSubtaskData.Related_Task;

          if (tempSubTask.Related_Task == taskStructure.Task_ID) {
            console.log("MATCHING TASK");
            taskStructure.Subtasks.push(tempSubTask);
          }
        }

        assignedTasks = await projectService.getAssignedTasksByProject(
          currProjectID
        );
        for (let x = 0; x < assignedTasks.length; x++) {
          employee = await authService.getUserByID(
            assignedTasks[x].Employee_Assigned
          );
          employeeData = Object.values(employee);

          assignedTasks[
            x
          ].Employee_Name = `${employeeData[0].First_Name} ${employeeData[0].Last_Name}`;
          if (assignedTasks[x].Task_Assigned == taskStructure.Task_ID) {
            taskStructure.Employees.push(assignedTasks[x]);
          }
        }

        result.Tasks.push(taskStructure);
        // console.log(result);
      }
      timeframe = await projectService.getTimeFrameByProject(currProjectID);
      result.Timeframe = timeframe;
      const attachments = await attachmentService.getByProjectId(currProjectID);
      if (attachments.length > 0) {
        const signedAttachments = [];
      
        for (const attachment of attachments) {
          try {
            const fileKey = attachment.File_Path.split(`https://${BucketName}.s3.amazonaws.com/`)[1];
      
            if (!fileKey) {
              console.error(`Invalid File_Path for attachment: ${attachment.File_Path}`);
              continue;
            }
      
            const getCommand = new GetObjectCommand({
              Bucket: BucketName,
              Key: fileKey,
            });
      
            const signedUrl = await getSignedUrl(space, getCommand, { expiresIn: expiryTime });
      
            signedAttachments.push({
              ...attachment,
              SignedUrl: signedUrl,
            });
          } catch (error) {
            console.error(`Error generating signed URL for attachment ${attachment.ATTACHMENT_ID}:`, error);
          }
        }
      
        result.Attachments = signedAttachments;
      } else {
        console.log("No attachments found for the project.");
      }

      res.status(201).json(result);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteProject: async (req, res) => {
    try {
      const projectId = req.params.id;
      await projectService.deleteProject(projectId);
      res.status(200).json({ message: "Project deleted successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // SUBTASK FUNCTIONS

  addSubtask: async (req, res) => {
    try {
      const subtaskData = req.body;
      await projectService.addSubtask(subtaskData);
      res.status(200).json({ message: "Project Subtask added successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getSubtasksByProject: async (req, res) => {
    try {
      const projectId = req.params.id;
      const subtask = await projectService.getSubtasksByProject(projectId);
      if (subtask.length === 0) {
        return res
          .status(404)
          .json({ error: "Subtasks not found for this project" });
      }
      res.status(200).json(subtask[0]);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteSubtask: async (req, res) => {
    try {
      const subtaskId = req.params.id;
      await projectService.deleteSubtask(subtaskId);
      res.status(200).json({ message: "Project Subtask deleted successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  //ASSIGN TASK FUNCTIONS

  assignTask: async (req, res) => {
    try {
      const taskData = req.body;
      await projectService.AssignTask(taskData);
      res.status(200).json({ message: "Task assigned successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  //GET USER BY SPECIALTY

  GetUserBySpecialty: async (req, res) => {
    try {
      const taskData = req.params.id;
      taskresponse = await projectService.GetUserBySpecialty(taskData);
      res.status(200).json(Object.values(taskresponse[0]));
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = projectController;

//PROJECT CREATION FORMAT
//FOR ANYTHING REQUIRING PROJECT_ID TO INSERT, GET IT AFTER INSERTING PROJECT DESCRIPTION AND BEFORE INSERTING THE REST OF THE DATA
// [{
//     projectData: {
//         Project_Description: "?",
//         Address: "?",
//         Post_Code: "?",
//         Contact_Phone: "?",
//         Contact_Email: "?",
//         Created_By: "?",
//     },
//     Tasklist: [
//         {
//             Task_ID: "?",
//             Task_Name: "?",
//             Subtasklist: [
//                 {
//                     Subtask_ID: "?",
//                     Project_ID: "?",
//                 },
//                 {
//                     Subtask_ID: "?",
//                     Project_ID: "?",
//                 },
//             ],
//             Employees: [
//                 {
//                     Employee_ID: "?",
//                     Time_Start: "?",
//                     Time_Finish: "?"
//                 },
//                 {
//                     Employee_ID: "?",
//                     Time_Start: "?",
//                     Time_Finish: "?"
//                 },
//             ],
//         },
//         {
//             Task_ID: "?",
//             Task_Name: "?",
//             Subtasklist: [
//                 {
//                     Subtask_ID: "?",
//                     Project_ID: "?",
//                 },

//             ],
//             Employees: [
//                 {
//                     Employee_ID: "?",
//                     Time_Start: "?",
//                     Time_Finish: "?"
//                 },
//             ],
//         },
//     ],
//     Project_Attachments: [
//         {
//             Attachment_Name: "?",
//             File_Type: "?",
//             File_Format: "?",
//             File_Path: "?"
//         },
//         {
//             Attachment_Name: "?",
//             File_Type: "?",
//             File_Format: "?",
//             File_Path: "?"
//         },

//         ],
//     },
// ]

//TEST DATA
// {
//     "projectData": {
//         "Project_Description": "example new test",
//         "Address": "test",
//         "Post_Code": "test",
//         "Contact_Phone": "test",
//         "Contact_Email": "test",
//         "Created_By": "1"
//     },
//     "Tasklist": [
//         {
//             "Task_ID": "1",
//             "Subtasklist": [
//                 {
//                     "Subtask_ID": "1"
//                 },
//                 {
//                     "Subtask_ID": "2"
//                 }
//             ],
//             "Employees": [
//                 {
//                     "Employee_ID": "1",
//                     "Time_Start": "1999-01-01",
//                     "Time_Finish": "2000-01-01"
//                 },
//                 {
//                     "Employee_ID": "2",
//                     "Time_Start": "2000-01-01",
//                     "Time_Finish": "2000-01-01"
//                 }
//             ]
//         },
//         {
//             "Task_ID": "2",
//             "Subtasklist": [
//                 {
//                     "Subtask_ID": "3"
//                 }

//             ],
//             "Employees": [
//                 {
//                     "Employee_ID": "3",
//                     "Time_Start": "2000-01-01",
//                     "Time_Finish": "2002-01-01"
//                 }
//             ]
//         }
//     ]
// }
