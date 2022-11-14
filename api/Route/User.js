const express = require('express');
const auth = require('../middleware/auth');
const router = express.Router();

//------------ Importing Controllers ------------//
const userController = require('../Controller/userController')

//------------ create ------------//
router.post('/', userController.createUser);

//------------ update ------------//
router.put('/', auth, userController.updateUser);

//------------ get ------------//
router.get('/', auth, userController.getUser);

//------------ get ------------//
router.delete('/:id', userController.deleteUser);

module.exports = router;