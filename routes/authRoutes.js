const express = require('express');
const authController = require('../controllers/authController');
const router = express.Router();
const upload = require('../middlewares/multerConfig');

router.post('/signup',upload.single('userProfile'), authController.signUp);
router.post('/login', authController.login);
router.patch('/users/:id', authController.updateUser);
router.get('/users/:ID', authController.getUserByID);
router.get('/users/', authController.getAllUsers);

module.exports = router;