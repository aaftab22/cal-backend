//routes to GET data from DB 
const express = require('express');
const router = express.Router();
const dbcontroller = require ('../controllers/dbController');

router.get('/get', dbcontroller.GetProjectTaskCategories);

module.exports = router;