const sequelize = require('../config/database');


const timesheetService = {
    getFilteredServiceTimesheets:async(services,timeStart,timeFinish)=>{
        let formattedStart = null
        let formattedEnd= null
        if(timeStart){
            const date = new Date(timeStart);
    
            formattedStart = date.toISOString().slice(0, 19).replace("T", " ");
        }
        if(timeFinish){
            const date = new Date(timeFinish);
    
            formattedEnd = date.toISOString().slice(0, 19).replace("T", " ");
        }
        const serviceString = services ? services.join(',') : null;

        return sequelize.query(
            'CALL GetEmployeeServiceCallHours(:_Service_Call_IDs, :_Start_Time, :_End_Time)',
            { 
                replacements: { 
                    _Service_Call_IDs: serviceString, 
                    _Start_Time: formattedStart,
                    _End_Time: formattedEnd, 
                },
                type: sequelize.QueryTypes.RAW
            }
        );
    },
    getFilteredProjectTimesheets:async(projects,timeStart,timeFinish)=>{
        let formattedStart = null
        let formattedEnd= null
        if(timeStart){
            const date = new Date(timeStart);
    
            formattedStart = date.toISOString().slice(0, 19).replace("T", " ");
        }
        if(timeFinish){
            const date = new Date(timeFinish);
    
            formattedEnd = date.toISOString().slice(0, 19).replace("T", " ");
        }
        const projectString = projects ? projects.join(',') : null;

        return sequelize.query(
            'CALL GetEmployeeProjectHours(:_Project_IDs, :_Start_Time, :_End_Time)',
            { 
                replacements: { 
                    _Project_IDs: projectString, 
                    _Start_Time: formattedStart,
                    _End_Time: formattedEnd, 
                },
                type: sequelize.QueryTypes.RAW
            }
        );
    },

 getFilteredEmployeeServiceTimesheets:async(employeeAssigned,timeStart,timeFinish)=>{
    let formattedStart = null
    let formattedEnd= null
    if(timeStart){
        const date = new Date(timeStart);

        formattedStart = date.toISOString().slice(0, 19).replace("T", " ");
    }
    if(timeFinish){
        const date = new Date(timeFinish);

        formattedEnd = date.toISOString().slice(0, 19).replace("T", " ");
    }
    const employeeString = employeeAssigned ? employeeAssigned.join(',') : null;

    return sequelize.query(
        'CALL GetServiceTimetableEmployee(:_Employee_Assigned, :_Start_Time, :_End_Time)',
        { 
            replacements: { 
                _Employee_Assigned: employeeString, 
                _Start_Time: formattedStart,
                _End_Time: formattedEnd, 
            },
            type: sequelize.QueryTypes.RAW
        }
    );
},
getFilteredEmployeeProjectTimesheets:async(employeeAssigned,timeStart,timeFinish)=>{
    let formattedStart = null
    let formattedEnd= null
    if(timeStart){
        const date = new Date(timeStart);

        formattedStart = date.toISOString().slice(0, 19).replace("T", " ");
    }
    if(timeFinish){
        const date = new Date(timeFinish);

        formattedEnd = date.toISOString().slice(0, 19).replace("T", " ");
    }
    const employeeString = employeeAssigned ? employeeAssigned.join(',') : null;

    return sequelize.query(
        'CALL GetProjectTimetableEmployee(:_Employee_Assigned, :_Start_Time, :_End_Time)',
        { 
            replacements: { 
                _Employee_Assigned: employeeString, 
                _Start_Time: formattedStart,
                _End_Time: formattedEnd, 
            },
            type: sequelize.QueryTypes.RAW
        }
    );
}
}

module.exports = timesheetService