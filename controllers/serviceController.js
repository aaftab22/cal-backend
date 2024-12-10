const serviceCallService = require("../services/serviceCallService");
const attachmentService = require("../services/attachmentService");
const upload = require("../middlewares/multerConfig");
const taskService = require("../services/taskService");
const subtaskService = require("../services/subtaskService");
const path = require("path");
const fs = require("fs");

const serviceController = {
  createServiceCall: async (req, res) => {
    try {
      // serviceData is store with or without attachment
      const serviceData = req.body.serviceData
        ? req.body.serviceData
        : JSON.parse(req.body.serviceDataJson).serviceData;

      const serviceDetails = {};
      serviceDetails.Service_Call_Description =
        serviceData.serviceCallDescription;
      serviceDetails.Address = serviceData.address;
      serviceDetails.Post_Code = serviceData.postCode;
      serviceDetails.Contact_Phone = serviceData.contactPhone;
      serviceDetails.Contact_Email = serviceData.contactEmail;
      serviceDetails.Created_By = serviceData.createdBy;
      serviceDetails.Site_Status = serviceData.siteStatus;
      serviceDetails.Status = serviceData.status;
      serviceDetails.Contact_First_Name = serviceData.Contact_Last_Name;
      serviceDetails.Contact_Last_Name = serviceData.Contact_Last_Name;

      let id = await serviceCallService.createServiceCall(serviceDetails);

      const task = serviceData.task;
      const taskData = {};
      taskData.Service_Call_ID = id["insertedId"];
      taskData.Task_ID = task.taskId;

      await Promise.all(
        task.employeesAssigned.map(async (employee) => {
          const empData = {
            Employee_Assigned: employee.employeeId,
            Time_Start: employee.timeStart,
            Time_Finish: employee.timeFinish,
          };
          return serviceCallService.createServiceCallTask(
            id["insertedId"],
            taskData.Task_ID,
            empData
          );
        })
      );

      await Promise.all(
        serviceData.task.subtasks.map(async (subtask) => {
          return serviceCallService.createServiceSubtask(
            id["insertedId"],
            subtask.subtaskId
          );
        })
      );

      const attachments = req.files || [];

      if (attachments.length > 0) {
        const serviceCallFolder = path.join(
          __dirname,
          `../uploads/servicecalls/${id["insertedId"]}`
        );
        fs.mkdirSync(serviceCallFolder, { recursive: true });

        for (const file of attachments) {
          const newFilePath = path.join(
            serviceCallFolder,
            path.basename(file.path)
          );
          fs.renameSync(file.path, newFilePath);

          const attachmentData = {
            SERVICE_CALL_ID: id["insertedId"],
            Attachment_Name: file.originalname,
            Attachment_Type: req.body.Attachment_Type || "Document",
            File_Format: path
              .extname(file.originalname)
              .substring(1)
              .toUpperCase(),
            File_Path: newFilePath,
          };

          await attachmentService.createServiceCallAttachment(attachmentData);
        }
      } else {
        console.log("No attachments uploaded.");
      }

      res.status(201).json({
        message: "Service call created successfully",
        serviceCallId: id["insertedId"],
      });
    } catch (error) {
      console.error("Error in createServiceCall:", error);
      res.status(500).json({
        message: "An error occurred while creating the service call",
      });
    }
  },

  updateServiceCall: async (req, res) => {
    try {
      const SERVICE_CALL_ID = req.params.id;
      const serviceData = req.body.serviceData
        ? req.body.serviceData
        : JSON.parse(req.body.serviceDataJson).serviceData;
      const serviceDetails = {};
      serviceDetails.Service_Call_Description =
        serviceData.serviceCallDescription;
      serviceDetails.Address = serviceData.address;
      serviceDetails.Post_Code = serviceData.postCode;
      serviceDetails.Contact_Phone = serviceData.contactPhone;
      serviceDetails.Contact_Email = serviceData.contactEmail;
      serviceDetails.Created_By = serviceData.createdBy;
      serviceDetails.Site_Status = serviceData.siteStatus;
      serviceDetails.Status = serviceData.status;
      serviceDetails.Contact_First_Name = serviceData.Contact_First_Name;
      serviceDetails.Contact_Last_Name = serviceData.Contact_Last_Name;

      const service = await serviceCallService.getServiceTaskById(
        SERVICE_CALL_ID
      );
      const serviceObj = Object.values(service[0]);
      await serviceCallService.updateServiceCall(
        SERVICE_CALL_ID,
        serviceDetails
      );
      // Replaces the task if the task in update is different from the one in the db
      if (serviceObj[0].Task_ID !== serviceData.task.taskId) {
        serviceCallService.UpdateTaskIdForServiceCall(
          SERVICE_CALL_ID,
          serviceData.task.taskId
        );
      }

      const subtasks = await serviceCallService.getSubtasksByServiceCall(
        SERVICE_CALL_ID
      );
      const existingSubtaskIds = subtasks.map((item) => item.Subtask_ID);

      // Filtering the new subtasks (that are on the request but not on db) and old ones (that are on db but not request) to know what to remove and what not
      const newSubtasks = serviceData.task.subtasks
        .filter(
          (item2) => !existingSubtaskIds.includes(parseInt(item2.subtaskId))
        )
        .map((item) => parseInt(item.subtaskId));

      const removedSubtasks = subtasks
        .filter(
          (item) =>
            !serviceData.task.subtasks.some(
              (newItem) => newItem.subtaskId === item.Subtask_ID.toString()
            )
        )
        .map((item) => item.SERVICE_SUBTASK_ID);

      for (let i = 0; i < removedSubtasks.length; i++) {
        await serviceCallService.deleteSubtask(removedSubtasks[i]);
      }
      for (let i = 0; i < newSubtasks.length; i++) {
        await serviceCallService.createServiceSubtask(
          SERVICE_CALL_ID,
          newSubtasks[i]
        );
      }

      const employees = await serviceCallService.getEmployeesByServiceCall(
        SERVICE_CALL_ID
      );

      for (let i = 0; i < (employees || []).length; i++) {
        await serviceCallService.deleteServiceTask(
          employees[i].SERVICE_TASK_ID
        );
      }
      for (
        let j = 0;
        j < (serviceData.task.employeesAssigned || []).length;
        j++
      ) {
        const employee = serviceData.task.employeesAssigned[j];
        const tempEmployee = {
          Employee_ID: employee.employeeId,
          Time_Start: employee.timeStart,
          Time_Finish: employee.timeFinish,
          SERVICE_CALL_ID: SERVICE_CALL_ID,
          Task_Assigned: serviceData.task.taskId,
        };
        console.log("a");
        await serviceCallService.createServiceCallTask(
          SERVICE_CALL_ID,
          serviceData.task.taskId,
          tempEmployee
        );
        console.log("b");
      }

      if (req.files && req.files.attachments) {
        for (const file of req.files.attachments) {
          const attachmentData = {
            SERVICE_CALL_ID: SERVICE_CALL_ID,
            Attachment_Name: file.originalname,
            Attachment_Type: file.mimetype || "Other",
            File_Format: path.extname(file.originalname).slice(1),
            File_Path: file.path,
          };
          await attachmentService.createAttachment(attachmentData);
        }
      }

      res.status(200).json({ error: "Service Call updated successfully" });
    } catch (error) {
      console.error("Error updating Service Call:", error);
      res.status(400).json({ error: error.message });
    }
  },

  getServiceCalls: async (req, res) => {
    try {
      const result = [];
      const servicecalls = await serviceCallService.getServiceCalls();
      const serviceData = Object.values(servicecalls[0]);

      for (let i = 0; i < serviceData.length; i++) {
        const serviceDetails = {
          serviceData: {},
        };
        serviceDetails.serviceData.serviceCallId =
          serviceData[i].SERVICE_CALL_ID;
        serviceDetails.serviceData.serviceCallDescription =
          serviceData[i].Service_Call_Description;
        serviceDetails.serviceData.address = serviceData[i].Address;
        serviceDetails.serviceData.postCode = serviceData[i].Post_Code;
        serviceDetails.serviceData.contactPhone = serviceData[i].Contact_Phone;
        serviceDetails.serviceData.contactEmail = serviceData[i].Contact_Email;
        serviceDetails.serviceData.createdBy = serviceData[i].Created_By;
        serviceDetails.serviceData.siteStatus = serviceData[i].Site_Status;
        serviceDetails.serviceData.status = serviceData[i].Status;
        (serviceDetails.serviceData.Contact_First_Name =
          serviceData[i].Contact_First_Name),
          (serviceDetails.serviceData.Contact_Last_Name =
            serviceData[i].Contact_Last_Name);

        const employees = await serviceCallService.getEmployeesByServiceCall(
          serviceData[i].SERVICE_CALL_ID
        );
        let employeeArray = [];
        employees.forEach((employee) => {
          const name = employee.First_Name + " " + employee.Last_Name;
          employeeArray.push({
            employeeId: employee.Employee_Assigned,
            employeeName: name,
            timeStart: employee.Time_Start,
            timeFinish: employee.Time_Finish,
          });
        });

        // Each Service will only have 1 task, no need for a for loop after we get it
        const task = await serviceCallService.getServiceTaskById(
          serviceData[i].SERVICE_CALL_ID
        );

        taskData = Object.values(task[0]);

        if (taskData.length == 0) {
          continue;
        }

        let taskStructure = {
          taskId: taskData[0].Task_ID,
          taskName: "",
          employeesAssigned: employeeArray,
          subtasks: [],
        };

        const Task_Name = await taskService.getTaskById(taskStructure.taskId);
        taskStructure.taskName = Object.values(Task_Name[0])[0].Task_Name;

        subtasks = await serviceCallService.getSubtasksByServiceCall(
          serviceData[i].SERVICE_CALL_ID
        );

        for (let j = 0; j < subtasks.length; j++) {
          const subtaskRelation = await subtaskService.GetSubtaskByID(
            subtasks[j].Subtask_ID
          );
          const subtaskStructure = {
            serviceSubtaskId: subtasks[j].SERVICE_SUBTASK_ID,
            subtaskId: subtaskRelation[0].SUBTASK_ID,
            subtaskName: subtaskRelation[0].Subtask_Name,
          };

          if (subtaskRelation[0].Related_Task == taskStructure.taskId) {
            taskStructure.subtasks.push(subtaskStructure);
          }
        }
        serviceDetails.task = taskStructure;

        const attachments = await attachmentService.getByServiceCallId(
          serviceData[i].SERVICE_CALL_ID
        );

        if (attachments.length > 0) {
          serviceDetails.attachments = attachments.map((attachment) => ({
            attachmentId: attachment.Attachment_ID,
            attachmentName: attachment.Attachment_Name,
            attachmentType: attachment.Attachment_Type,
            fileFormat: attachment.File_Format,
            filePath: attachment.File_Path,
          }));
        }

        result.push(serviceDetails);
      }

      res.status(200).json(result);
    } catch (error) {
      console.error(error);
      res
        .status(500)
        .json({ error: "An error occured while getting the service calls" });
    }
  },

  getServiceCallById: async (req, res) => {
    try {
      const serviceId = req.params.id;
      const servicecall = await serviceCallService.getServiceCallById(
        serviceId
      );
      const item = servicecall[0];

      if (Object.values(servicecall[0]).length === 0) {
        return res.status(404).json({ error: "Service Call not found" });
      }

      const serviceData = {
        serviceCallId: serviceId,
        serviceCallDescription: item[0].Service_Call_Description,
        address: item[0].Address,
        postCode: item[0].Post_Code,
        contactPhone: item[0].Contact_Phone,
        contactEmail: item[0].Contact_Email,
        siteStatus: item[0].Site_Status,
        createdAt: item[0].Created_At,
        createdBy: item[0].Created_By,
        updatedAt: item[0].Updated_At,
        status: item[0].Status,
        Contact_First_Name: item[0].Contact_First_Name,
        Contact_Last_Name: item[0].Contact_Last_Name,
      };

      const employees = await serviceCallService.getEmployeesByServiceCall(
        serviceId
      );
      employeesAssigned = employees.map((employee) => ({
        employeeId: employee.Employee_Assigned,
        employeeName: `${employee.First_Name} ${employee.Last_Name}`,
        timeStart: employee.Time_Start,
        timeFinish: employee.Time_Finish,
      }));

      const task = await serviceCallService.getServiceTaskById(
        serviceData.serviceCallId
      );
      const taskData = task[0];
      const taskDetails = await taskService.getTaskById(taskData[0].Task_ID);
      serviceData.task = {
        taskName: taskDetails[0][0].Task_Name,
        taskId: taskData[0].Task_ID,
        employeesAssigned: employeesAssigned,
        subtasks: [],
      };

      const subtasks = await serviceCallService.getSubtasksByServiceCall(
        serviceId
      );

      for (const subtask of subtasks) {
        const subtaskName = await subtaskService.GetSubtaskByID(
          subtask.Subtask_ID
        );
        serviceData.task.subtasks.push({
          serviceSubtaskId: subtask.SERVICE_SUBTASK_ID,
          subtaskId: subtask.Subtask_ID,
          subtaskName: subtaskName[0].Subtask_Name,
        });
      }

      const attachments = await attachmentService.getByServiceCallId(serviceId);

      serviceData.attachments = attachments.map((attachment) => ({
        attachmentId: attachment.Attachment_ID,
        attachmentName: attachment.Attachment_Name,
        attachmentType: attachment.Attachment_Type,
        fileFormat: attachment.File_Format,
        filePath: attachment.File_Path,
      }));

      res.status(200).json(serviceData);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error has occurred getting this service" });
      console.error(error.message);
    }
  },

  getFilteredServiceCalls: async (req, res) => {
    const {
      employeeAssigned = null,
      tasks = null,
      address = null,
      siteStatus = null,
      timeStart = null,
      timeFinish = null,
    } = req.body;

    let serviceData = await serviceCallService.getFilteredServiceCalls({
      employeeAssigned,
      tasks,
      address,
      siteStatus,
      timeStart,
      timeFinish,
    });
    if (serviceData.length === 0) {
      return res.status(404).json({ error: "Service Call not found" });
    }
    const services = [];
    for (let i = 0; i < serviceData.length; i++) {
      const serviceDetails = {
        serviceData: {},
      };
      serviceDetails.serviceData.serviceCallId = serviceData[i].Service_Call_ID;
      serviceDetails.serviceData.serviceCallDescription =
        serviceData[i].Service_Call_Description;
      serviceDetails.serviceData.address = serviceData[i].Address;
      serviceDetails.serviceData.postCode = serviceData[i].Post_Code;
      serviceDetails.serviceData.contactPhone = serviceData[i].Contact_Phone;
      serviceDetails.serviceData.contactEmail = serviceData[i].Contact_Email;
      serviceDetails.serviceData.createdBy = serviceData[i].Created_By;
      serviceDetails.serviceData.siteStatus = serviceData[i].Site_Status;
      serviceDetails.serviceData.status = serviceData[i].Status;
      services.push(serviceDetails);

      const employees = await serviceCallService.getEmployeesByServiceCall(
        serviceData[i].Service_Call_ID
      );
      let employeesAssigned = employees.map((employee) => ({
        employeeId: employee.Employee_Assigned,
        employeeName: `${employee.First_Name} ${employee.Last_Name}`,
        timeStart: employee.Time_Start,
        timeFinish: employee.Time_Finish,
      }));

      const task = await serviceCallService.getServiceTaskById(
        serviceData[i].Service_Call_ID
      );
      const taskData = task[0];
      const taskDetails = await taskService.getTaskById(taskData[0].Task_ID);
      serviceDetails.task = {
        taskName: taskDetails[0][0].Task_Name,
        taskId: taskData[0].Task_ID,
        employeesAssigned: employeesAssigned,
        subtasks: [],
      };

      const subtasks = await serviceCallService.getSubtasksByServiceCall(
        serviceData[i].Service_Call_ID
      );

      for (const subtask of subtasks) {
        const subtaskName = await subtaskService.GetSubtaskByID(
          subtask.Subtask_ID
        );
        serviceDetails.task.subtasks.push({
          serviceSubtaskId: subtask.SERVICE_SUBTASK_ID,
          subtaskId: subtask.Subtask_ID,
          subtaskName: subtaskName[0].Subtask_Name,
        });
      }
      const attachments = await attachmentService.getByServiceCallId(
        serviceData[i].Service_Call_ID
      );
      if (attachments.length > 0) {
        serviceDetails.attachments = attachments.map((attachment) => ({
          attachmentId: attachment.Attachment_ID,
          attachmentName: attachment.Attachment_Name,
          attachmentType: attachment.Attachment_Type,
          fileFormat: attachment.File_Format,
          filePath: attachment.File_Path,
        }));
      }
    }
    res.status(200).json(services);
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

module.exports = serviceController;
