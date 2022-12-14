const express = require('express');

const router = express.Router({ mergeParams: true });


//------------ Importing Controllers ------------//
const discountController = require('../Controller/DiscountController')


//------------ create ------------//
router.post('/', discountController.createDiscount);

//------------ get all ------------//
router.get('/', discountController.getAll);

//------------ get ------------//
router.get('/:id', discountController.getDiscount);

//------------ update ------------//
router.put('/:id', discountController.updateDiscount);

//------------ delete ------------//
router.delete('/:id', discountController.deleteDiscount);

module.exports = router;