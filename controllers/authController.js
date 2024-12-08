const authService = require('../services/authService');
const upload = require('../middlewares/authMiddleware');

const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const phoneRegex = /^\+?[1-9]\d{1,14}$/;

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
                console.error('SignUp Error:', error); 
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

    updateUser: async (req, res) => {
        try {
            const { userData } = req.body;
            const { id } = req.params;
    
            console.log(userData);
            console.log("here");
    
            if (userData.email && !emailRegex.test(userData.email)) {
                return res.status(400).json({ error: "Invalid email format" });
            }
    
            if (userData.phoneNumber && !phoneRegex.test(userData.phoneNumber)) {
                return res.status(400).json({ error: "Invalid phone number format" });
            }
    
            if (userData.emergencyContactPhoneNumber && !phoneRegex.test(userData.emergencyContactPhoneNumber)) {
                return res.status(400).json({ error: "Invalid emergency contact phone number format" });
            }
    
            const updatedUser = await authService.updateUser(id, userData);
    
            res.status(200).json({ message: "User updated successfully" });
    
        } catch (error) {
            res.status(500).json({ error: "There was an error updating this user" });
            console.error(error);
        }
    }

};

module.exports = authController;