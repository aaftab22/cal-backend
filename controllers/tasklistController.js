const taskService = require('../services/taskService');

const tasklistController = {
    createTask: async (req, res) => {
        try {
            const taskData = req.body;
            await taskService.createTask(taskData);
            res.status(201).json({ message: 'Task created successfully' });
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    },

    getTasks: async (req, res) => {
        try {
            const tasks = await taskService.getTasks();
            res.status(201).json(Object.values(tasks[0]));
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    },

    getTaskById: async (req, res) => {
        try {
            const taskId = req.params.id;
            const task = await taskService.getTaskById(taskId);
            if (!task) {
                return res.status(404).json({ error: 'Task not found' });
            }
            res.status(200).json(task);
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    },

    updateTask: async (req, res) => {
        try {
            const taskId = req.params.id;
            const taskData = req.body;
            await taskService.updateTask(taskId, taskData);
            res.status(200).json({ message: 'Task updated successfully' });
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    },

    deleteTask: async (req, res) => {
        try {
            const taskId = req.params.id;
            await taskService.deleteTask(taskId);
            res.status(204).send(); // 204 No Content
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    },
};

module.exports = tasklistController;