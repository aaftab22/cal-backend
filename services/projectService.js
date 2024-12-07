const sequelize = require('../config/database');

const projectService = {
    createProject: async (projectData,transaction=false) => { 
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
                transaction
            }
        );

        const insertedId = result[0]; 
        return insertedId;
    },


    updateProject: async (projectId, projectData,transaction=false) => {
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
                transaction
            }
        );
    },

    getProjects: async () => {
        return sequelize.query('CALL GetAllProjects()', {
            type: sequelize.QueryTypes.SELECT,
        });
    },

    getProjectById: async (projectId,transaction=false) => {
        return sequelize.query('CALL GetProjectById(:id)', {
            replacements: { id: projectId },
            type: sequelize.QueryTypes.SELECT,
            transaction
        });
    },

    deleteProject: async (projectId,transaction=false) => {
        return sequelize.query('CALL DeleteProject(:id)', {
            replacements: { id: projectId },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    createProjectSubtask: async (subtaskData,transaction=null) => { 
        return sequelize.query('CALL CreateProjectSubtask(:Project_ID, :Subtask_ID)', { 
            replacements: {
                Project_ID: subtaskData.Project_ID,
                Subtask_ID: subtaskData.Subtask_ID,
            },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },
    
    getSubtasksByProject: async (Project_ID,transaction=false) => { 
        return sequelize.query('CALL GetProjectSubtasksByProjectID(:id)',{ 
            replacements: { id: Project_ID },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    deleteSubtask: async (subtaskId,transaction=false) => { 
        return sequelize.query('CALL DeleteProjectSubtask(:id)',{
            replacements: { id: subtaskId },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    AssignTask: async (taskData,transaction=false) => { 
        return sequelize.query('CALL AssignTask(:Employee_ID, :Project_ID, :Task_Assigned, :Time_Start, :Time_Finish)',{ 
            replacements: { 
                Employee_ID: taskData.Employee_ID,
                Project_ID: taskData.Project_ID,
                Task_Assigned: taskData.Task_Assigned, 
                Time_Start: taskData.Time_Start,
                Time_Finish: taskData.Time_Finish,
            },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    GetUserBySpecialty: async (taskData,transaction=false) => { 
        return sequelize.query('CALL GetUserBySpecialty(:Specialty)',{
            replacements: { 
                Specialty: taskData.TASK_ID,
            },
            transaction
        })
    },

    createProjectTask: async (taskData,transaction=false) => {
        try {
            // console.log(taskData.Project_ID, taskData.Task_ID);
            await sequelize.query(
                'CALL CreateProjectTask(:Project_ID, :Task_ID)', 
                {
                    replacements: { 
                        Project_ID: taskData.Project_ID,
                        Task_ID: taskData.Task_ID,
                        transaction
                     },
                    type: sequelize.QueryTypes.RAW,
                    transaction
                }
            );
        } catch (error) {
            console.error("Error creating project task:", error);
        }
    },

    getProjectTaskById: async (taskId,transaction=false) => {
        return sequelize.query('CALL GetProjectTasksByID(:taskId)', {
            replacements: { taskId },
            type: sequelize.QueryTypes.SELECT,
            transaction
        });
    },

    updateProjectTask: async (taskId, taskData,transaction=false) => {
        return sequelize.query(
            'CALL UpdateTask(:taskId, :taskName)', 
            {
                replacements: {
                    taskId,
                    taskName: taskData.Task_Name,
                },
                type: sequelize.QueryTypes.RAW,
                transaction
            }
        );
    },

    deleteProjectTask: async (taskId,transaction=false) => {
        return sequelize.query('CALL DeleteProjectTask(:taskId)', {
            replacements: { taskId },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },
    deleteProjectTaskPT: async (projectId,taskId,transaction=false) => {
        return sequelize.query('CALL DeleteProjectTaskPT(:projectId,:taskId)', {
            replacements: { projectId,taskId },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },
    deleteProjectSubTask: async (project_subtask_id,transaction=false) => {
        return sequelize.query('CALL DeleteSubtaskProjectAssignment(:project_subtask_id)', {
            replacements: { project_subtask_id },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },    
    deleteProjectAssignment: async (assignment_id,transaction=false) => {
        return sequelize.query('CALL DeleteProjectAssignment(:assignment_id)', {
            replacements: { assignment_id },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    getAssignedTasksByProject: async (project_ID,transaction=false) => { 
        return sequelize.query('CALL GetAssignedTasksByProject(:project_ID)', { 
            replacements: { project_ID },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    getTimeFrameByProject: async (project_ID,transaction=false) => { 
        return sequelize.query('CALL GetTimeFrameByProject(:project_ID)', { 
            replacements: { project_ID },
            transaction
        });
    },
    
};

module.exports = projectService;
