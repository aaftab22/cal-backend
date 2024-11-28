// routes/projectRoutes.js
const express = require('express');
const projectController = require('../controllers/projectController');
const router = express.Router();
const upload = require('../middlewares/multerConfig');

// Routes for project operations
router.post('/create', upload.array('projectAttachments', 20), projectController.createProject);
router.put('/:id', projectController.updateProject);
router.get('/', projectController.getProjects);
router.get('/:id', projectController.getProjectById);
router.delete('/:id', projectController.deleteProject);
router.get('/subtask/:id', projectController.getSubtasksByProject);
router.delete('/subtask/:id', projectController.deleteSubtask);
router.get('/getuserbytask/:id', projectController.GetUserBySpecialty);


module.exports = router;
