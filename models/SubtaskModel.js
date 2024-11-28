const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Subtask = sequelize.define('Subtask', {
    Subtask_Name: {
        type: DataTypes.STRING,
        allowNull: true,
        unique: true,
    },
    Related_Task: {
        type: DataTypes.INTEGER,
        allowNull: true,
    }
})
module.exports = Subtask;