const express = require('express');
const router = express.Router();
const upload = require('../middlewares/multerConfig');
const serviceController = require('../controllers/serviceController');


router.post('/', upload.array('serviceAttachments', 20), serviceController.createServiceCall);
router.put('/:id',upload.array('serviceAttachments', 20), serviceController.updateServiceCall);
router.get('/', serviceController.getServiceCalls);
router.get('/:id', serviceController.getServiceCallById);
router.post('/filter',serviceController.getFilteredServiceCalls)

module.exports = router;