const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const inforAddressController = require('../Controller/inforAddressController')

//------------ create ------------//
router.post('/', auth, inforAddressController.createInforAddress);

//------------ update ------------//
router.put('/:id', auth, inforAddressController.updateInforAddress);

//------------ get ------------//
router.get('/', auth, inforAddressController.getInforAddresss);

//------------ get ------------//
router.delete('/:id', auth, inforAddressController.deleteInforAddresss);

module.exports = router;