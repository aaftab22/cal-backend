const authService = require('../services/authService');
const upload = require('../middlewares/authMiddleware');


const authController = {
    signUp: async (req, res) => {
        upload(req, res, async (err) => {
            if (err) {
                return res.status(400).json({ error: err.message });
            }
            try {
                const userData = req.body;
                userData.Picture_File_Name = req.file ? req.file.filename : null;
                userData.Picture_File_Path = req.file ? req.file.path : null;
                await authService.signUp(userData);
                res.status(201).json({ message: 'User created successfully' });
            } catch (error) {
                console.error('SignUp Error:', error); // Log the error for debugging
                res.status(400).json({ error: error.message });
            }
        });
    },

    login: async (req, res) => {
        try {
            // Change email and password to match your incoming payload
            const { Email, Password } = req.body; 
            const result = await authService.login(Email, Password);
            res.status(200).json(result);
        } catch (error) {
            console.error('Login Error:', error); // Log the error for debugging
            res.status(401).json({ error: error.message });
        }
    }, 

    getUserByID: async (req, res) => { 
        try { 
            const ID = req.params.ID
            const user = await authService.getUserByID(ID);
            const userData = Object.values(user)
            res.status(200).json(userData);
        }catch (error) {
            console.error('Login Error:', error); // Log the error for debugging
            res.status(401).json({ error: error.message });
        }
    },

    getAllUsers: async (req, res) => { 
        try { 
            const users = await authService.getAllUsers(); 
            const userData = Object.values(users[0])
            res.status(200).json(userData);
        }catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

};

module.exports = authController;