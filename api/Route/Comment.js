const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const commentController = require('../Controller/commentController');

//------------ create ------------//
router.post('/', auth,  commentController.createComment);

//------------ update ------------//
router.put('/:id', auth, commentController.updateComment);

//------------ get ------------//
router.get('/:id_product', commentController.getComment);


module.exports = router;