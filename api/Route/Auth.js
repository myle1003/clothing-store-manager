const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');

//------------ Importing Controllers ------------//
const authController = require('../Controller/authController')

//------------ Reset Password Route ------------//
router.get('/reset/:id', (req, res) => {
    res.render('reset', { id: req.params.id })
});


//------------ Register POST Handle ------------//
router.post('/register', authController.registerHandle);

//------------ Email ACTIVATE Handle ------------//
router.get('/activate/:token', authController.activateHandle);


//------------ Forgot Password Handle ------------//
router.post('/forgot', authController.forgotPassword);

//------------ Reset Password Handle ------------//
router.post('/reset', auth, authController.resetPassword);

//------------ Login POST Handle ------------//
router.post('/login', authController.login);

//------------ Logout GET Handle ------------//
router.get('/logout', authController.logoutHandle);

module.exports = router;