const subtaskService = require ('../services/subtaskService');

const subtasklistController = { 
    create: async (req, res) => { 
        try { 
            const subtaskData = req.body;
            await subtaskService.create(subtaskData);
            res.status(201).json({ message: 'Subtask created successfully' });

        } catch (error) { 
            console.error('Create Subtask Error:', error); // Log the error for debugging
            res.status(400).json({ error: error.message });
        }
    },

    delete: async (req, res) => { 
        try { 
            const subtaskData = req.body;
            await subtaskService.delete(subtaskData);
            res.status(200).json({ message: 'Subtask deleted successfully' });

        } catch (error) { 
            console.error('Delete Subtask Error:', error);
            res.status(400).json({ error: error.message });
        }
    },

    get: async (req, res) => {
        try {
            const subtasks = await subtaskService.get();
            res.status(200).json(subtasks);
        } catch (error) {
            console.error('Get Subtasks Error:', error); 
            res.status(500).json({ error: error.message });
        }
    }, 

    getsubtasksbytask: async (req,res) => { 
        try { 
            const subtasks = await subtaskService.GetSubtaskByTask(taskData);
            res.status(200).json(subtasks); 
        } catch(error) { 
            console.error('Get Subtasks Error:', error); 
            res.status(500).json({ error: error.message });
        }
    }, 
};

module.exports = subtasklistController;

//to create: http://localhost:3001/api/subtasklist/new

// { 
//     "Subtask_Name":"Test",
//     "Related_Task":"1"
// }

//to delete: http://localhost:3001/api/subtasklist/delete

// { 
//     "Subtask_ID":"1"
// }