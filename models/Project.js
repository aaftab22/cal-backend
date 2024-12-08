const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Project = sequelize.define('Project', {
    PROJECT_ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    Project_Description: {
        type: DataTypes.STRING(256),
        allowNull: false,
    },
    Address: {
        type: DataTypes.STRING(256),
    },
    Post_Code: {
        type: DataTypes.STRING(10),
    },
    Contact_Phone: {
        type: DataTypes.STRING(16),
    },
    Contact_Email: {
        type: DataTypes.STRING(64),
    },
    Created_By: {
        type: DataTypes.INTEGER,
        references: {
            model: 'USERS',
            key: 'ID',
        }
    }
}, {
    tableName: 'projects',
    timestamps: true,
    createdAt: 'Created_At',
    updatedAt: 'Updated_At'
});

module.exports = Project;
