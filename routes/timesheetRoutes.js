const express = require('express');
const router = express.Router();
const timesheetController = require('../controllers/timesheetController');

router.post('/filterEmployees',timesheetController.getFilteredTimesheetEmployee)
router.get('/',timesheetController.getAllTimesheetEmployee)
router.post('/filterNames',timesheetController.getFilteredTimesheetProject)
router.get('/filterNames',timesheetController.getAllTimesheetProject)
module.exports = router;