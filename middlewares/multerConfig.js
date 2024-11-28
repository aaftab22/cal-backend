const multer = require('multer');
const path = require('path');
const fs = require('fs');

const tempStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        const tempFolder = path.join(__dirname, '../uploads/temp');
        fs.mkdirSync(tempFolder, { recursive: true });
        cb(null, tempFolder);
    },
    filename: (req, file, cb) => {
        const timestamp = Date.now();
        cb(null, `${timestamp}-${file.originalname}`);
    }
});

const fileFilter = (req, file, cb) => {
    const allowedTypes = ['.jpeg', '.jpg', '.png', '.pdf', '.doc', '.docx'];
    const extension = path.extname(file.originalname).toLowerCase();
    if (allowedTypes.includes(extension)) {
        cb(null, true);
    } else {
        cb(new Error('Invalid file type. Only images and documents are allowed.'));
    }
};

const upload = multer({
    storage: tempStorage,
    limits: { fileSize: 10 * 1024 * 1024 },
    fileFilter: fileFilter,
});

module.exports = upload;

// const multer = require('multer');
// const path = require('path');
// const fs = require('fs');

// const storage = multer.diskStorage({
//     destination: (req, file, cb) => {
//         console.log('/////////////////////////////////////')
//         console.log(req.body)
//         console.log('/////////////////////////////////////')
//         if (req.body.projectData !== null && req.body.serviceData == null) {
//             const projectAddress = req.body.projectData.Address || 'default';
//             const projectFolder = path.join(__dirname, `../uploads/projects/${projectAddress}`);
//             fs.mkdirSync(projectFolder, { recursive: true });
//             cb(null, projectFolder);
//         }else if (req.body.projectData == null && req.body.serviceData !== null) { 
//             const serviceAddress = req.body.serviceData.Address || 'default';
//             const serviceFolder = path.join(__dirname, `../uploads/servicecalls/${serviceAddress}`);
//             fs.mkdirSync(serviceFolder, { recursive: true });
//             cb(null, serviceFolder);
//         }
        

        
//     },
//     filename: (req, file, cb) => {
//         const timestamp = Date.now();
//         const originalName = file.originalname;
//         const extension = path.extname(originalName);
//         cb(null, `${timestamp}-${originalName}`);
//     }
// });

// const fileFilter = (req, file, cb) => {
//     const allowedTypes = ['.jpeg', '.jpg', '.png', '.pdf', '.doc', '.docx'];
//     const extension = path.extname(file.originalname).toLowerCase();

//     if (allowedTypes.includes(extension)) {
//         cb(null, true);
//     } else {
//         cb(new Error('Invalid file type. Only images and documents are allowed.'));
//     }
// };

// const upload = multer({
//     storage: storage,
//     limits: { fileSize: 10 * 1024 * 1024 },
//     fileFilter: fileFilter,
// });

// module.exports = upload;