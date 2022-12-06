const express = require('express');
const router = express.Router();
const {logger} = require('../logger/logger');

router.get('/', async function(req, res) {
    logger.info('1.test infor');
    logger.error('1.test error');
    return res.send("success");
})


module.exports = router;