const sequelize = require("../config/database");

const projectService = {
  createProject: async (projectData, transaction) => {
    const result = await sequelize.query(
      "CALL CreateProject(:Project_Description, :Address, :Post_Code, :Contact_Phone, :Contact_Email, :Created_By, :Status)",
      {
        replacements: {
          Project_Description: projectData.Project_Description,
          Address: projectData.Address,
          Post_Code: projectData.Post_Code,
          Contact_Phone: projectData.Contact_Phone,
          Contact_Email: projectData.Contact_Email,
          Created_By: projectData.Created_By,
          Status: projectData.Status || "Not Started",
        },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );

    const insertedId = result[0];
    return insertedId;
  },

  updateProject: async (projectId, projectData, transaction) => {
    if (projectData.Status == undefined) {
      console.log("Here");
      projectData.Status = null;
    }

    console.log(projectData.Status);
    return sequelize.query(
      "CALL UpdateProject(:id, :description, :address, :postCode, :contactPhone, :contactEmail, :p_status)",
      {
        replacements: {
          id: projectId,
          description: projectData.Project_Description,
          address: projectData.Address,
          postCode: projectData.Post_Code,
          contactPhone: projectData.Contact_Phone,
          contactEmail: projectData.Contact_Email,
          p_status: projectData.Status,
          transaction,
        },
        type: sequelize.QueryTypes.RAW,
      }
    );
  },

  getProjects: async () => {
    return sequelize.query("CALL GetAllProjects()", {
      type: sequelize.QueryTypes.SELECT,
    });
  },

  getProjectById: async (projectId, transaction = false) => {
    return sequelize.query("CALL GetProjectById(:id)", {
      replacements: { id: projectId },
      type: sequelize.QueryTypes.SELECT,
      transaction,
    });
  },

  deleteProject: async (projectId, transaction = false) => {
    return sequelize.query("CALL DeleteProject(:id)", {
      replacements: { id: projectId },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  createProjectSubtask: async (subtaskData, transaction = null) => {
    console.log("ascascacascasc", subtaskData);

    return sequelize.query(
      "CALL CreateProjectSubtask(:Project_ID, :Subtask_ID)",
      {
        replacements: {
          Project_ID: subtaskData.Project_ID || subtaskData.projectId,
          Subtask_ID: subtaskData.Subtask_ID || subtaskData.subtaskId,
        },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );
  },

  getSubtasksByProject: async (Project_ID, transaction = false) => {
    return sequelize.query("CALL GetProjectSubtasksByProjectID(:id)", {
      replacements: { id: Project_ID },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  deleteSubtask: async (subtaskId, transaction = false) => {
    return sequelize.query("CALL DeleteProjectSubtask(:id)", {
      replacements: { id: subtaskId },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  AssignTask: async (taskData, transaction = false) => {
    return sequelize.query(
      "CALL AssignTask(:Employee_ID, :Project_ID, :Task_Assigned, :Time_Start, :Time_Finish)",
      {
        replacements: {
          Employee_ID: taskData.Employee_ID,
          Project_ID: taskData.Project_ID,
          Task_Assigned: taskData.Task_Assigned,
          Time_Start: taskData.Time_Start,
          Time_Finish: taskData.Time_Finish,
        },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );
  },

  GetUserBySpecialty: async (taskData, transaction = false) => {
    return sequelize.query("CALL GetUserBySpecialty(:Specialty)", {
      replacements: {
        Specialty: taskData.TASK_ID,
      },
      transaction,
    });
  },

  createProjectTask: async (taskData, transaction = false) => {
    try {
      console.log(taskData.Project_ID, taskData.Task_ID);
      await sequelize.query("CALL CreateProjectTask(:Project_ID, :Task_ID)", {
        replacements: {
          Project_ID: taskData.Project_ID,
          Task_ID: taskData.Task_ID,
          transaction,
        },
        type: sequelize.QueryTypes.RAW,
        transaction,
      });
    } catch (error) {
      console.error("Error creating project task:", error);
    }
  },

  getProjectTaskById: async (taskId, transaction) => {
    return sequelize.query("CALL GetProjectTasksByID(:taskId)", {
      replacements: { taskId },
      type: sequelize.QueryTypes.SELECT,
      transaction,
    });
  },

  deleteSubtaskByTask: async (taskId, projectId, transaction) => {
    console.log(taskId, projectId);
    return sequelize.query(
      "Call DeleteSubtasksForTaskAndProject(:taskId,:projectId)",
      {
        replacements: { taskId, projectId },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );
  },

  deleteProjectTask: async (taskId, transaction) => {
    console.log(transaction);
    return sequelize.query("CALL DeleteProjectTask(:taskId)", {
      replacements: { taskId },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },
  updateProjectTask: async (taskId, taskData, transaction = false) => {
    return sequelize.query("CALL UpdateTask(:taskId, :taskName)", {
      replacements: {
        taskId,
        taskName: taskData.Task_Name,
      },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  deleteProjectTaskPT: async (projectId, taskId, transaction = false) => {
    return sequelize.query("CALL DeleteProjectTaskPT(:projectId,:taskId)", {
      replacements: { projectId, taskId },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  deleteAssignmentByProject: async (projectId, taskId, transaction = false) => {
    return sequelize.query(
      "CALL DeleteAssignmentByProject(:projectId,:taskId)",
      {
        replacements: { projectId, taskId },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );
  },

  deleteProjectSubTask: async (project_subtask_id, transaction = false) => {
    return sequelize.query(
      "CALL DeleteSubtaskProjectAssignment(:project_subtask_id)",
      {
        replacements: { project_subtask_id },
        type: sequelize.QueryTypes.RAW,
        transaction,
      }
    );
  },
  deleteProjectAssignment: async (assignment_id, transaction = false) => {
    return sequelize.query("CALL DeleteProjectAssignment(:assignment_id)", {
      replacements: { assignment_id },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  getAssignedTasksByProject: async (project_ID, transaction = false) => {
    return sequelize.query("CALL GetAssignedTasksByProject(:project_ID)", {
      replacements: { project_ID },
      type: sequelize.QueryTypes.RAW,
      transaction,
    });
  },

  getTimeFrameByProject: async (project_ID, transaction = false) => {
    return sequelize.query("CALL GetTimeFrameByProject(:project_ID)", {
      replacements: { project_ID },
      transaction,
    });
  },
};

module.exports = projectService;
