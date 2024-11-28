const sequelize = require('../config/database');

const serviceCallService = { 
    createServiceCall: async (serviceData) => { 
        const result = await sequelize.query(
            'CALL CreateServiceCall(:Service_Call_Description, :Address, :Post_Code, :Contact_Phone, :Contact_Email, :Site_Status, :Created_By, :Status)', {
                replacements: { 
                    Service_Call_Description: serviceData.Service_Call_Description,
                    Address: serviceData.Address,
                    Post_Code: serviceData.Post_Code,
                    Contact_Phone: serviceData.Contact_Phone,
                    Contact_Email: serviceData.Contact_Email,
                    Site_Status: serviceData.Site_Status, 
                    Created_By: serviceData.Created_By,
                    Status: serviceData.Status
                },
                type: sequelize.QueryTypes.RAW,
            }
        );
    
        const insertedId = result[0];
        return insertedId;
    },

    getLatestServiceCall: async()=>{
        
    },

    updateServiceCall: async (servicecallId, serviceCallData) => { 
        return sequelize.query (
            'CALL UpdateServiceCall(:id, :description, :address, :postCode, :contactPhone, :contactEmail, :sitestatus, :timestart, :timefinish, :status)', { 
                replacements: { 
                    id: servicecallId,
                    description: serviceCallData.Service_Call_Description,
                    address: serviceCallData.Address,
                    postCode: serviceCallData.Post_Code,
                    contactPhone: serviceCallData.Contact_Phone,
                    contactEmail: serviceCallData.Contact_Email,
                    sitestatus: serviceCallData.Site_Status, 
                    status: serviceCallData.Status || 'Pending'
                }, 
                type: sequelize.QueryTypes.RAW,
            }
        )
    },

    getServiceCalls: async () => { 
        return sequelize.query('CALL GetAllServiceCalls()', {
            type: sequelize.QueryTypes.SELECT,
        });
    },

    getServiceCallById: async (service_Id) => { 
        return sequelize.query('CALL GetServiceCallById(:service_Id)', {
            replacements: { service_Id:service_Id },
            type: sequelize.QueryTypes.SELECT,
        });
    },

    deleteServiceCall: async (service_Id)=> { 
        return sequelize.query('CALL DeleteServiceCall(:service_Id)', {
            replacements: { service_Id:service_Id },
            type: sequelize.QueryTypes.RAW,
        });
    },

    createServiceSubtask: async (serviceId,subtaskId) => { 
        return sequelize.query('CALL CreateServiceCallSubtask(:Service_Call_ID, :Subtask_ID)', { 
            replacements: {
                Service_Call_ID: serviceId,
                Subtask_ID: subtaskId
            },
            type: sequelize.QueryTypes.RAW
        });
    },

    getSubtasksByServiceCall: async (Service_Call_ID) => { 
        return sequelize.query('CALL GetSubtasksByServiceCallID(:id)',{ 
            replacements: { id: Service_Call_ID },
            type: sequelize.QueryTypes.RAW,
        });
    },

    getEmployeesByServiceCall: async (Service_Call_ID) => { 
        return sequelize.query('CALL GetEmployeesForService(:id)',{ 
            replacements: { id: Service_Call_ID },
            type: sequelize.QueryTypes.RAW,
        });
    },

    deleteSubtask: async (subtaskId) => { 
        return sequelize.query('CALL DeleteServiceCallSubtask(:id)',{
            replacements: { id: subtaskId },
            type: sequelize.QueryTypes.RAW,
        });
    },

    createServiceCallTask: async (taskData,empData) => { 
        return sequelize.query(
            'CALL CreateServiceCallTaskAssignment(:Service_Call_ID, :Task_ID, :Employee_Assigned, :Time_Start, :Time_Finish)', { 
                replacements: { 
                    Service_Call_ID: taskData.Service_Call_ID, 
                    Task_ID: taskData.Task_ID,
                    Employee_Assigned: empData.Employee_Assigned,
                    Time_Start: empData.Time_Start,
                    Time_Finish: empData.Time_Finish
                },
                type: sequelize.QueryTypes.RAW,
            },
        );
    },

    getServiceTaskById: async (Task_Id) => {
        console.log(Task_Id)
        return sequelize.query('CALL GetServiceTasksByID(:taskId)', {
            replacements: {taskId: Task_Id },
            type: sequelize.QueryTypes.SELECT,
        });
    },


    deleteServiceTask: async(Task_Id) => { 
        return sequelize.query(
            'CALL DeleteServiceCallTask(:taskId)', { 
                replacements: {taskId: Task_Id }, 
                type:sequelize.QueryTypes.RAW
            });
    },
    
    GetAssignedTasksByServiceCall: async(ServiceID) => { 
        return sequelize.query('CALL GetAssignedTasksByServiceCall(:Service_ID)', { 
            replacements: {Service_ID: ServiceID },
            type: sequelize.QueryTypes.RAW
        });
    },
    getFilteredServiceCalls: async (params) => {
        const { employeeAssigned, tasks, address, siteStatus,timeStart,timeFinish } = params;
    
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
        console.log("Employee"+employeeString)
        const tasksString = tasks ? tasks.join(',') : null;

        return sequelize.query(
            'CALL GetFilteredServiceCalls(:Employee_Assigned, :Tasks, :Address, :Site_Status,:StartDate,:EndDate)',
            { 
                replacements: { 
                    Employee_Assigned: employeeString, 
                    Tasks: tasksString,
                    Address:address, 
                    Site_Status:siteStatus,
                    StartDate:formattedStart,
                    EndDate:formattedEnd
                },
                type: sequelize.QueryTypes.RAW
            }
        );

}
}
module.exports = serviceCallService;