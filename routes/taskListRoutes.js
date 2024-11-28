const express = require('express');
const router = express.Router();
const taskController = require('../controllers/tasklistController');

router.post('/new', taskController.createTask);
router.get('/get', taskController.getTasks);
router.get('/tasks/:id', taskController.getTaskById);
router.put('/id', taskController.updateTask);
router.delete('/:id', taskController.deleteTask);

module.exports = router;