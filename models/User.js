const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const User = sequelize.define('User', {
    Email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    Password: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    First_Name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    Last_Name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    Phone_Number: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    Address: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Birth_Date: {
        type: DataTypes.DATE,
        allowNull: true,
    },
    Job_Title: {
        type: DataTypes.ENUM('Admin', 'Employee'),
        allowNull: false,
    },
    Emergency_Contact_First_Name: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Emergency_Contact_Last_Name: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Emergency_Contact_Phone_Number: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Emergency_Contact_Relation: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Picture_File_Name: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    Picture_File_Path: {
        type: DataTypes.STRING,
        allowNull: true,
    }
}, {
    ableName: 'users', 
    timestamps: false
});

module.exports = User;
