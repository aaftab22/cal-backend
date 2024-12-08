const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Task = sequelize.define('Task', {
    TASK_ID: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    Task_Name: {
        type: DataTypes.STRING(64),
        allowNull: false,
        unique: true  // Ensure Task_Name is unique
    }
}, {
    tableName: 'tasklist',
    timestamps: false
});

module.exports = Task;