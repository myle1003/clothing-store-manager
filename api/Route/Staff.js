const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const staffController = require('../Controller/staffController')

//------------ create ------------//
router.post('/', staffController.createStaff);

//------------ update ------------//
router.put('/:id', staffController.updateStaff);

//------------ get ------------//
router.get('/', staffController.getAllStaff);

//------------ get ------------//
router.get('/:id', staffController.getStaff);

//------------ delete ------------//
router.delete('/:id', staffController.deleteStaff);

module.exports = router;