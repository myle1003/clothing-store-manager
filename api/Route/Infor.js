const express = require('express');
const router = express.Router();

//------------ Importing Controllers ------------//
const inforController = require('../Controller/InforController');


//------------ get ------------//
router.get('/', inforController.getInfor);


module.exports = router;