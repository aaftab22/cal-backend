const timesheetService = require('../services/timesheetService');

const mapServiceProjects = (serviceTimeSheetRes, projectTimeSheetRes) => {
    const serviceTimeSheet = serviceTimeSheetRes.map((serviceTimeSheet) => {
        return {
            id: serviceTimeSheet.Service_Call_ID,
            name: serviceTimeSheet.Address,
            status: serviceTimeSheet.Status,
            date: serviceTimeSheet.Earliest_Shift_Start,
            hours: serviceTimeSheet.total_hours
        };
    });
    const projectTimeSheet = projectTimeSheetRes.map((projectTimeSheet) => {
        return {
            id: projectTimeSheet.Project_ID,
            name: projectTimeSheet.Address,
            status: projectTimeSheet.Status,
            date: projectTimeSheet.Earliest_Shift_Start,
            hours: projectTimeSheet.total_hours
        };
    });

    return { serviceTimeSheet, projectTimeSheet };
}

const mapServiceProjectsType = (serviceTimeSheetRes, projectTimeSheetRes) => {
    const serviceTimeSheet = serviceTimeSheetRes.map((serviceTimeSheet) => {
        return {
            id:serviceTimeSheet.ID,
            firstName: serviceTimeSheet.first_name,
            lastName: serviceTimeSheet.last_name,
            hours: serviceTimeSheet.Total_Hours_Worked,
            date: serviceTimeSheet.Earliest_Shift_Start,
            status: serviceTimeSheet.status
        };
    });
    const projectTimeSheet = projectTimeSheetRes.map((projectTimeSheet) => {
        return {
            id: projectTimeSheet.ID,
            firstName: projectTimeSheet.first_name,  
            lastName: projectTimeSheet.last_name,   
            hours: projectTimeSheet.Total_Hours_Worked,  
            date: projectTimeSheet.Earliest_Shift_Start,  
            status: projectTimeSheet.status          
        };
    });

    return { serviceTimeSheet, projectTimeSheet };
}

const timesheetController = {
    getAllTimesheetEmployee: async (req, res) => {
        const serviceTimeSheetRes = await timesheetService.getFilteredEmployeeServiceTimesheets(null, null, null);
        const projectTimeSheetRes = await timesheetService.getFilteredEmployeeProjectTimesheets(null, null, null);
        const { serviceTimeSheet, projectTimeSheet } = mapServiceProjects(serviceTimeSheetRes, projectTimeSheetRes);
        res.send({
            serviceCalls: serviceTimeSheet,
            projects: projectTimeSheet,
        });
    },

    getFilteredTimesheetEmployee: async (req, res) => {
        let { employeeAssigned, timeStart = null, timeFinish = null } = req.body;

        if (employeeAssigned.length === 0) {
            employeeAssigned = null;
        }

        const serviceTimeSheetRes = await timesheetService.getFilteredEmployeeServiceTimesheets(employeeAssigned, timeStart, timeFinish);
        const projectTimeSheetRes = await timesheetService.getFilteredEmployeeProjectTimesheets(employeeAssigned, timeStart, timeFinish);
        const { serviceTimeSheet, projectTimeSheet } = mapServiceProjects(serviceTimeSheetRes, projectTimeSheetRes);
        res.send({
            serviceCalls: serviceTimeSheet,
            projects: projectTimeSheet,
        });
    },

    getAllTimesheetProject: async (req, res) => {
        const serviceTimeSheetRes = await timesheetService.getFilteredServiceTimesheets(null, null, null);
        const projectTimeSheetRes = await timesheetService.getFilteredProjectTimesheets(null, null, null);
        // console.log(serviceTimeSheetRes, projectTimeSheetRes);
        const { serviceTimeSheet, projectTimeSheet } = mapServiceProjectsType(serviceTimeSheetRes, projectTimeSheetRes);
        res.send({
            serviceCalls: serviceTimeSheet,
            projects: projectTimeSheet,
        });
    },

    getFilteredTimesheetProject: async (req, res) => {
        let { projects, serviceCalls, timeStart = null, timeFinish = null } = req.body;

        const serviceTimeSheetRes = await timesheetService.getFilteredServiceTimesheets(serviceCalls, timeStart, timeFinish);
        const projectTimeSheetRes = await timesheetService.getFilteredProjectTimesheets(projects, timeStart, timeFinish);
        // console.log(serviceTimeSheetRes, projectTimeSheetRes);
        const { serviceTimeSheet, projectTimeSheet } = mapServiceProjectsType(serviceTimeSheetRes, projectTimeSheetRes);
        res.send({
            serviceCalls: serviceTimeSheet,
            projects: projectTimeSheet,
        });
    },
};

module.exports = timesheetController;
