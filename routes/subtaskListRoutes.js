const express = require('express');
const subtaskListController = require('../controllers/subtasklistController');
const router = express.Router();

router.post('/new', subtaskListController.create);
router.post('/delete', subtaskListController.delete);
router.post('/get', subtaskListController.get);


module.exports = router;