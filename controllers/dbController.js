const taskService = require('../services/taskService');
const subtaskService = require('../services/subtaskService');
const projectService = require('../services/projectService');
const authController = require('./authController');
const authService = require('../services/authService');


const dbController = { 
    GetProjectTaskCategories: async (req,res) => { 
        try { 
            //first get all task categories
            const result = []
            const tasks = await taskService.getTasks();
            const resulttasks = Object.values(tasks[0])
            console.log(resulttasks)
            for (const task of resulttasks) { 
                const taskData = task
                let ObjStructure = 
                    {
                        Task_ID: taskData.TASK_ID,
                        Task_Name: taskData.Task_Name,
                        Subtasks: [],
                        Employees: [],
                    }
                
                const subtasks = await subtaskService.GetSubtaskByTask(taskData);
                if (subtasks[0] !== undefined) {
                    tempsubtasks = Object.values(subtasks[0]);
                    console.log(tempsubtasks);
                    ObjStructure.Subtasks = tempsubtasks
                };

                const employees = await projectService.GetUserBySpecialty(taskData);
                if (employees[0] !== undefined){
                    tempemployees = Object.values(employees);
                    console.log(tempemployees)
                    for (let i = 0; i < tempemployees.length; i++) { 
                        currtempemployee = tempemployees[i]
                        console.log(currtempemployee)
                        let employee = await authService.getUserByID(currtempemployee.User_ID)
                        console.log(employee)
                        tempemployees[i].Employee_Name = `${employee[0].First_Name} ${employee[0].Last_Name}`
                    }

                    console.log(tempemployees)
                    ObjStructure.Employees = tempemployees
                };

                result.push(ObjStructure);
            }
            res.status(200).json(result);
            console.log(result)
        }catch (error) {
            console.error('SignUp Error:', error); // Log the error for debugging
            res.status(400).json({ error: error.message });
        }
    },
};

module.exports = dbController;

// http://localhost:3001/api/taskcategories/get
// // FORMAT: 
// // [    
// //     {
// //         Task_ID: ? , 
// //         Task_Name: ? , 
// //         Subtasks: [
// //         { 
// //             SUBTASK_ID: ?, 
// //             Subtask_Name: ?,
// //         }, { 
// //             SUBTASK_ID: ?, 
// //             Subtask_Name: ?,
// //         }, { 
// //             SUBTASK_ID: ?, 
// //             Subtask_Name: ?,
// //         }],

// //         Employees: [
// //         {
// //             ID: ?
// //         },{ 
// //             ID: ?,
// //         },{ 
// //             ID: ?,
// //         },{ 
// //             ID: ?,
// //         }]
// //     },

// //     {
// //         Task_ID: ? , 
// //         Task_Name: ? , 

// //         Subtasks: [{ 
// //             SUBTASK_ID: ?, 
// //             Subtask_Name: ?,
// //         }]
         
// //         Employees: [{ 
// //             ID: ?,
// //         }]
// //     },

// // ]

