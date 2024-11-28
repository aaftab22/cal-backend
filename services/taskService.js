const sequelize = require('../config/database');

const taskService = {
    createTask: async (taskData) => {
        return sequelize.query(
            'CALL CreateMasterTask(:taskName)', 
            {
                replacements: { taskName: taskData.Task_Name },
                type: sequelize.QueryTypes.RAW,
            }
        );
    },

    getTasks: async () => {
        return sequelize.query('CALL GetAllMasterTasks()', {
            type: sequelize.QueryTypes.SELECT,
        });
    },

    getTaskById: async (task_ID) => {
        return sequelize.query('CALL GetMasterTaskById(:Task_ID)', {
            replacements: { Task_ID: task_ID },
            type: sequelize.QueryTypes.SELECT,
        });
    },

    updateTask: async (taskId, taskData) => {
        return sequelize.query(
            'CALL UpdateMasterTask(:taskId, :taskName)', 
            {
                replacements: {
                    taskId,
                    taskName: taskData.Task_Name,
                },
                type: sequelize.QueryTypes.RAW,
            }
        );
    },

    deleteTask: async (taskId) => {
        return sequelize.query('CALL DeleteMasterTask(:taskId)', {
            replacements: { taskId },
            type: sequelize.QueryTypes.RAW,
        });
    },
};

module.exports = taskService;