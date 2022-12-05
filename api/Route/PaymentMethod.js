const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const paymentMethod = require('../Controller/paymentMethodController');

//------------ create ------------//
router.post('/', paymentMethod.createPaymentMethod);

//------------ update ------------//
router.put('/:id', paymentMethod.editPaymentMethod);

//------------ get ------------//
router.get('/', paymentMethod.getPaymentMethod);

//------------ delete ------------//
router.delete('/:id', paymentMethod.deletePaymentMethod);


module.exports = router;