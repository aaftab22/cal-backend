const Subtask = require('../models/SubtaskModel');
const sequelize = require('../config/database'); 


const subtaskService = {
    create: async (subtaskData) => { 
        return sequelize.query('CALL CreateMasterSubtask(:subtaskName, :subtaskRelation)',{
            replacements: {
                subtaskName: subtaskData.Subtask_Name,
                subtaskRelation: subtaskData.Related_Task
            },
            type: sequelize.QueryTypes.RAW
        });
    },
    delete: async (subtaskData) => { 
        return sequelize.query('CALL DeleteMasterSubtask(:subtaskID)',{
            replacements: {
                subtaskID: subtaskData.Subtask_ID
            },
            type: sequelize.QueryTypes.RAW
        });
    },
    get: async () => { 
        return sequelize.query('CALL GetAllMasterSubtasks()', {
            type: sequelize.QueryTypes.SELECT,
        });
    },
    
    GetSubtaskByTask: async (taskData) => { 
        return sequelize.query('CALL GetSubtaskByTask(:TASK_ID)', {
            replacements: { 
                TASK_ID: taskData.TASK_ID
            },
            type: sequelize.QueryTypes.SELECT,
        });
    },

    GetSubtaskByID: async (subtaskid) => { 
        return sequelize.query('CALL GetSubtaskByID(:id)', { 
            replacements: { 
                id: subtaskid
            },
            type: sequelize.QueryTypes.RAW,
        });
    },
};
module.exports = subtaskService;