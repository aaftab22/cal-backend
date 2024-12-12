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
