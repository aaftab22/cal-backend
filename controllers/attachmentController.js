const attachmentService = require('../services/attachmentService');
const path = require('path');


const attachmentController = {
    createAttachment: async (req, res) => {
        try {
            const { projectID, attachmentType } = req.body;

            // Validate the attachmentType
            const validAttachmentTypes = ['Document', 'Video', 'Image', 'Other'];
            if (!validAttachmentTypes.includes(attachmentType)) {
                return res.status(400).json({ message: `Invalid attachmentType. Allowed types are: ${validAttachmentTypes.join(', ')}` });
            }

            if (!req.file) {
                return res.status(400).json({ message: 'No file uploaded' });
            }

            const attachmentData = {
                Project_ID: projectID,
                Attachment_Name: req.file.originalname,
                Attachment_Type: attachmentType,
                File_Format: path.extname(req.file.originalname),
                File_Path: req.file.path // Full file path
            };

            await attachmentService.create(attachmentData);
            return res.status(201).json({ message: 'Attachment uploaded successfully' });
        } catch (error) {
            return res.status(500).json({ message: error.message });
        }
    },


    // Fetch all attachments by project ID
    getAttachmentsByProjectId: async (req, res) => {
        try {
            const projectId = req.params.projectId;
            const attachments = await attachmentService.getByProjectId(projectId);
            return res.status(200).json(attachments);
        } catch (error) {
            return res.status(500).json({ message: error.message });
        }
    },

    // Delete an attachment by ID
    deleteAttachment: async (req, res) => {
        try {
            const attachmentId = req.params.attachmentId;
            await attachmentService.delete(attachmentId);
            return res.status(200).json({ message: 'Attachment deleted successfully' });
        } catch (error) {
            return res.status(500).json({ message: error.message });
        }
    }
};

module.exports = attachmentController;