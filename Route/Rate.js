const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const rateController = require('../Controller/rateController');

//------------ get ------------//
router.get('/:id_product', rateController.getRate);


module.exports = router;