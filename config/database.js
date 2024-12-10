const { Sequelize } = require("sequelize");
const dotenv = require('dotenv');

dotenv.config();

const sequelize = new Sequelize({
    port: process.env.DB_PORT,
    host: process.env.DB_HOST,
    username: process.env.DB_USER, 
    password: process.env.DB_PASS,
    database: process.env.MYSQL_DB,
    connectionLimit: 10,
    dialect: 'mysql'
});

module.exports = sequelize;
