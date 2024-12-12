const User = require('../models/User');
const sequelize = require('../config/database');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const authService = {
    signUp: async (userData) => {
        // console.log(userData)
        const hashedPassword = await bcrypt.hash(userData.Password, 10);
        return sequelize.query('CALL CreateUser(:email, :password, :firstName, :lastName, :phoneNumber, :address, :birthDate, :jobTitle, :emergencyContactFirstName, :emergencyContactLastName, :emergencyContactPhoneNumber, :emergencyContactRelation, :pictureFileName, :pictureFilePath)', {
            replacements: {
                email: userData.Email,
                password: hashedPassword,
                firstName: userData.First_Name,
                lastName: userData.Last_Name,
                phoneNumber: userData.Phone_Number,
                address: userData.Address,
                birthDate: userData.Birth_Date,
                jobTitle: userData.Job_Title,
                emergencyContactFirstName: userData.Emergency_Contact_First_Name,
                emergencyContactLastName: userData.Emergency_Contact_Last_Name,
                emergencyContactPhoneNumber: userData.Emergency_Contact_Phone_Number,
                emergencyContactRelation: userData.Emergency_Contact_Relation,
                pictureFileName: userData.Picture_File_Name || 'Default_PFP',
                pictureFilePath: userData.Picture_File_Path || 'Default_PFP_Path'
            },
            type: sequelize.QueryTypes.RAW
        });
    },
    login: async (email, password) => {
        const user = await User.findOne({ where: { Email: email } });
        if (!user) {
            throw new Error('User not found');
        }
        const isPasswordValid = await bcrypt.compare(password, user.Password);
        if (!isPasswordValid) {
            throw new Error('Invalid password');
        }
        const token = jwt.sign({ id: user.id }, 'your_jwt_secret', { expiresIn: '1h' });
        return { token, user };
    },
    
    getUserByID: async (ID) => { 
        return sequelize.query('CALL GetUserById(:ID)',{
            replacements: {
                ID: ID
            }, 
            type: sequelize.QueryTypes.RAW,
        });
    },

    getAllUsers: async () => { 
        return sequelize.query('CALL GetAllUsers()',{
            type: sequelize.QueryTypes.SELECT,
        });
    },
    
    updateUser: async (Id,updatedUser) => {
        try {

            let hashedPassword = null
            if(updatedUser.password){
                hashedPassword = await bcrypt.hash(updatedUser.password, 10);
            }
            console.log(hashedPassword)
            return await sequelize.query(
                'CALL UpdateEmployee(:ID,:email, :password, :firstName, :lastName, :phoneNumber, :address, :birthDate, :jobTitle, :emergencyContactFirstName, :emergencyContactLastName, :emergencyContactPhoneNumber, :emergencyContactRelation)',
                {
                    replacements: {
                        ID:Id,
                        email: updatedUser.email || null,
                        password: hashedPassword || null,
                        firstName: updatedUser.firstName || null,
                        lastName: updatedUser.lastName || null,
                        phoneNumber: updatedUser.phoneNumber || null,
                        address: updatedUser.address || null,
                        birthDate: updatedUser.birthday || null,
                        jobTitle: updatedUser.jobTitle || null,
                        emergencyContactFirstName: updatedUser.emergencyFirstName || null,
                        emergencyContactLastName: updatedUser.emergencyLastName || null,
                        emergencyContactPhoneNumber: updatedUser.emergencyPhoneNumber || null,
                        emergencyContactRelation: updatedUser.emergencyRelationship || null
                    },
                    type: sequelize.QueryTypes.RAW
                }
            );
        } catch (error) {
            console.error('Error executing UpdateEmployee procedure:', error);
            throw error;
        }
    }
};
module.exports = authService;