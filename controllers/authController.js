const authService = require('../services/authService');
const fs = require("fs");
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const phoneRegex = /^\+?[1-9]\d{1,14}$/;
const dotenv = require("dotenv");

dotenv.config();

const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const {
  S3Client,
  GetObjectCommand,
  PutObjectCommand,
  DeleteObjectCommand,
} = require("@aws-sdk/client-s3");

const BucketName = "caliber-space";
const expiryTime = 3600;

const space = new S3Client({
  endpoint: "https://tor1.digitaloceanspaces.com",
  region: "ca-central-1",
  credentials: {
    accessKeyId: process.env.SPACES_ACCESS_KEY,
    secretAccessKey: process.env.SPACES_ACCESS_SECRET_KEY,
  },
});

const authController = {
    signUp: async (req, res) => {
        try {
            const userData = JSON.parse(req.body.userData);
            if (req.file) {
                userData.Picture_File_Name = userData.Email;

    
                const s3Key = `profiles/${userData.Email}`;
                const uploadParams = {
                    Bucket: BucketName,
                    Key: s3Key,
                    Body: fs.readFileSync(req.file.path), 
                    ContentType: req.file.mimetype,    
                    ACL: "public-read",
                };
                const uploadCommand = new PutObjectCommand(uploadParams);

                await space.send(uploadCommand);
                userData.Picture_File_Path= `https://${BucketName}.s3.amazonaws.com/${s3Key}`
            }


            await authService.signUp(userData);
            res.status(201).json({ message: 'User created successfully' });
    
        } catch (error) {
            console.error('SignUp Error:', error);
            res.status(400).json({ error: error.message });
        }
    },

    login: async (req, res) => {
        try {
            const { Email, Password } = req.body; 
            const result = await authService.login(Email, Password);
            res.status(200).json(result);
        } catch (error) {
            console.error('Login Error:', error); 
            res.status(401).json({ error: error.message });
        }
    }, 

    getUserByID: async (req, res) => { 
        try { 
            const ID = req.params.ID;
            const user = await authService.getUserByID(ID);
            const userData = Object.values(user)[0]; 
    
            if (!userData) {
                return res.status(404).json({ error: "User not found" });
            }
    
            // Check if Picture_File_Path starts with "https"
            if (userData.Picture_File_Path && userData.Picture_File_Path.startsWith('https://')) {
                const fileKey = userData.Picture_File_Path.split(`https://${BucketName}.s3.amazonaws.com/`)[1];
                if (!fileKey) {
                    console.error(`Invalid File_Path for attachment: ${userData.Picture_File_Path}`);
                    return res.status(400).json({ error: "Invalid file path" });
                }
    
                const getCommand = new GetObjectCommand({
                    Bucket: BucketName,
                    Key: fileKey,
                });
    
                const signedUrl = await getSignedUrl(space, getCommand, {
                    expiresIn: expiryTime,
                });
    
                userData.Signed_Picture_Url = signedUrl;
            }
    
            res.status(200).json(userData);
        } catch (error) {
            console.error('Login Error:', error); 
            res.status(500).json({ error: error.message });
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