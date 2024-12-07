// services/attachmentService.js
const sequelize = require('../config/database');
const { createAttachment } = require('../controllers/attachmentController');

const attachmentService = {
    createAttachment: async (attachmentData,transaction) => {
        return sequelize.query('CALL CreateAttachment(:projectID, :attachmentName, :attachmentType, :fileFormat, :filePath)', {
            replacements: {
                projectID: attachmentData.Project_ID,
                attachmentName: attachmentData.Attachment_Name,
                attachmentType: attachmentData.Attachment_Type,
                fileFormat: attachmentData.File_Format,
                filePath: attachmentData.File_Path
            },
            type: sequelize.QueryTypes.RAW,
            transaction
        });
    },

    createServiceCallAttachment: async (attachmentData) => {
        return sequelize.query('CALL CreateServiceCallAttachment(:SERVICE_CALL_ID, :attachmentName, :attachmentType, :fileFormat, :filePath)', {
            replacements: {
                SERVICE_CALL_ID: attachmentData.SERVICE_CALL_ID,
                attachmentName: attachmentData.Attachment_Name,
                attachmentType: attachmentData.Attachment_Type,
                fileFormat: attachmentData.File_Format,
                filePath: attachmentData.File_Path
            },
            type: sequelize.QueryTypes.RAW
        });
    },

    
    getByProjectId: async (projectId) => {
        return sequelize.query('CALL GetAttachmentsByProject(:projectId)', {
            replacements: { projectId },
            type: sequelize.QueryTypes.RAW
        });
    },
    getByServiceCallId: async (serviceCallId) => {
        return sequelize.query('CALL GetAttachmentsByServiceCall(:serviceCallId)', {
            replacements: { serviceCallId },
            type: sequelize.QueryTypes.RAW
        });
    },

    delete: async (attachmentID) => {
        return sequelize.query('CALL DeleteAttachment(:attachmentID)', {
            replacements: { attachmentID },
            type: sequelize.QueryTypes.RAW
        });
    }
};

module.exports = attachmentService;