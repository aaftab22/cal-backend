const sequelize = require('../config/database');

const projectService = {
    createProject: async (projectData) => { 
        const result = await sequelize.query(
            'CALL CreateProject(:Project_Description, :Address, :Post_Code, :Contact_Phone, :Contact_Email, :Created_By, :Status)', 
            {
                replacements: { 
                    Project_Description: projectData.Project_Description,
                    Address: projectData.Address,
                    Post_Code: projectData.Post_Code,
                    Contact_Phone: projectData.Contact_Phone,
                    Contact_Email: projectData.Contact_Email,
                    Created_By: projectData.Created_By,
                    Status: projectData.Status || 'Pending'
                },
                type: sequelize.QueryTypes.RAW,
            }
        );

        const insertedId = result[0]; 
        return insertedId;
    },


    updateProject: async (projectId, projectData) => {
        return sequelize.query(
            'CALL UpdateProject(:id, :description, :address, :postCode, :contactPhone, :contactEmail, :status)', 
            {
                replacements: {
                    id: projectId,
                    description: projectData.Project_Description,
                    address: projectData.Address,
                    postCode: projectData.Post_Code,
                    contactPhone: projectData.Contact_Phone,
                    contactEmail: projectData.Contact_Email,
                    status: projectData.Status || 'Pending' // Default to 'Pending'
                },
                type: sequelize.QueryTypes.RAW,
            }
        );
    },

    getProjects: async () => {
        return sequelize.query('CALL GetAllProjects()', {
            type: sequelize.QueryTypes.SELECT,
        });
    },

    getProjectById: async (projectId) => {
        return sequelize.query('CALL GetProjectById(:id)', {
            replacements: { id: projectId },
            type: sequelize.QueryTypes.SELECT,
        });
    },

    deleteProject: async (projectId) => {
        return sequelize.query('CALL DeleteProject(:id)', {
            replacements: { id: projectId },
            type: sequelize.QueryTypes.RAW,
        });
    },

    createProjectSubtask: async (subtaskData) => { 
        return sequelize.query('CALL CreateProjectSubtask(:Project_ID, :Subtask_ID)', { 
            replacements: {
                Project_ID: subtaskData.Project_ID,
                Subtask_ID: subtaskData.Subtask_ID
            },
            type: sequelize.QueryTypes.RAW
        });
    },
    
    getSubtasksByProject: async (Project_ID) => { 
        return sequelize.query('CALL GetProjectSubtasksByProjectID(:id)',{ 
            replacements: { id: Project_ID },
            type: sequelize.QueryTypes.RAW,
        });
    },

    deleteSubtask: async (subtaskId) => { 
        return sequelize.query('CALL DeleteProjectSubtask(:id)',{
            replacements: { id: subtaskId },
            type: sequelize.QueryTypes.RAW,
        });
    },

    AssignTask: async (taskData) => { 
        return sequelize.query('CALL AssignTask(:Employee_ID, :Project_ID, :Task_Assigned, :Time_Start, :Time_Finish)',{ 
            replacements: { 
                Employee_ID: taskData.Employee_ID,
                Project_ID: taskData.Project_ID,
                Task_Assigned: taskData.Task_Assigned, 
                Time_Start: taskData.Time_Start,
                Time_Finish: taskData.Time_Finish
            },
            type: sequelize.QueryTypes.RAW,
        });
    },

    GetUserBySpecialty: async (taskData) => { 
        return sequelize.query('CALL GetUserBySpecialty(:Specialty)',{
            replacements: { 
                Specialty: taskData.TASK_ID,
            }
        })
    },

    createProjectTask: async (taskData) => {
        return sequelize.query(
            'CALL CreateProjectTask(:Project_ID, :Task_ID)', 
            {
                replacements: { 
                    Project_ID: taskData.Project_ID,
                    Task_ID: taskData.Task_ID
                 },
                type: sequelize.QueryTypes.RAW,
            }
        );
    },

    getProjectTaskById: async (taskId) => {
        return sequelize.query('CALL GetProjectTasksByID(:taskId)', {
            replacements: { taskId },
            type: sequelize.QueryTypes.SELECT,
        });
    },

    updateProjectTask: async (taskId, taskData) => {
        return sequelize.query(
            'CALL UpdateTask(:taskId, :taskName)', 
            {
                replacements: {
                    taskId,
                    taskName: taskData.Task_Name,
                },
                type: sequelize.QueryTypes.RAW,
            }
        );
    },

    deleteProjectTask: async (taskId) => {
        return sequelize.query('CALL DeleteProjectTask(:taskId)', {
            replacements: { taskId },
            type: sequelize.QueryTypes.RAW,
        });
    },

    getAssignedTasksByProject: async (project_ID) => { 
        return sequelize.query('CALL GetAssignedTasksByProject(:project_ID)', { 
            replacements: { project_ID },
            type: sequelize.QueryTypes.RAW
        });
    },

    getTimeFrameByProject: async (project_ID) => { 
        return sequelize.query('CALL GetTimeFrameByProject(:project_ID)', { 
            replacements: { project_ID },
        });
    },
    
};

module.exports = projectService;
