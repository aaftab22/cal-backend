const path = require("path");
const projectService = require("../services/projectService");
const attachmentService = require("../services/attachmentService");
const taskService = require("../services/taskService");
const upload = require("../middlewares/multerConfig");
const subtaskService = require("../services/subtaskService");
const authService = require("../services/authService");
const fs = require("fs");
  
const projectController = {
  //Projects Table Functions
  createProject: async (req, res) => {
    try {
      console.log("req.body.projectData", req.body.projectData);

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
          console.log(currTask.Employees[i].Employee_ID);
          tempEmployee = currTask.Employees[i];
          tempEmployee.Project_ID = insertedId;
          tempEmployee.Task_Assigned = currTask.Task_ID;
          console.log(tempEmployee);
          await projectService.AssignTask(tempEmployee);
        }
      }

      const attachments = req.files || [];
      console.log("Uploaded Attachments:", attachments);

      if (attachments.length > 0) {
        const projectFolder = path.join(
          __dirname,
          `../uploads/projects/${insertedId}`
        );
        fs.mkdirSync(projectFolder, { recursive: true });

        for (const file of attachments) {
          const newFilePath = path.join(
            projectFolder,
            path.basename(file.path)
          );
          fs.renameSync(file.path, newFilePath);

          const attachmentData = {
            Project_ID: insertedId,
            Attachment_Name: file.originalname,
            Attachment_Type: req.body.Attachment_Type || "Document",
            File_Format: path
              .extname(file.originalname)
              .substring(1)
              .toUpperCase(),
            File_Path: newFilePath,
          };

          console.log("Attachment Data:", attachmentData);
          await attachmentService.createAttachment(attachmentData);
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
    try {
      const projectId = req.params.id;
      const projectData = req.body;

      // Update project details
      const projectDetails = {
        Project_Description: projectData.projectData.Project_Description,
        Address: projectData.projectData.Address,
        Post_Code: projectData.projectData.Post_Code,
        Contact_Phone: projectData.projectData.Contact_Phone,
        Contact_Email: projectData.projectData.Contact_Email,
        Created_By: projectData.projectData.Created_By,
      };

      console.log("Updating project details:", projectDetails);

      await projectService.updateProject(projectId, projectDetails);

      const Tasklist = projectData.Tasklist;
      for (let i = 0; i < Tasklist.length; i++) {
        const taskData = {
          Project_ID: projectId,
          Task_ID: Tasklist[i].Task_ID,
        };
        console.log("Creating/updating task:", taskData);

        await projectService.createProjectTask(taskData);

        const currTask = Tasklist[i];

        for (let j = 0; j < (currTask.Subtasklist || []).length; j++) {
          const tempSubTask = {
            Project_ID: projectId,
            Subtask_ID: currTask.Subtasklist[j].Subtask_ID,
          };
          console.log("Creating/updating subtask:", tempSubTask);
          await projectService.createProjectSubtask(tempSubTask);
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
          console.log("Assigning task to employee:", tempEmployee);
          await projectService.AssignTask(tempEmployee);
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
          console.log("Adding attachment:", attachmentData);

          // Save the new attachment to the database
          await attachmentService.createAttachment(attachmentData);
        }
      }

      res.status(200).json({ message: "Project updated successfully" });
    } catch (error) {
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
        projectDetails.projectData.Project_Description = projectData[i].Project_Description;
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
          console.log(taskStructure);
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
      console.log(projectData[0]);
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
        console.log(result);
      }
      timeframe = await projectService.getTimeFrameByProject(currProjectID);
      result.Timeframe = timeframe;
      const attachments = await attachmentService.getByProjectId(currProjectID);
      result.Attachments = attachments;

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