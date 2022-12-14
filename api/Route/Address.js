const express = require('express');
const router = express.Router();
const { Commune } = require("../Model/Commune");
const { District } = require('../Model/District');
const { Province } = require('../Model/Province');

router.get('/province', async function(req, res) {
    try {
        const province = await Province.find({})
        return res.send(province);
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
})

router.get('/district/:province', async function(req, res) {
    try {
        console.log(req.params.province);
        const district = await District.find({ id_province: req.params.province })
        return res.send(district);
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
})

router.get('/commune/:district', async function(req, res) {
    try {
        const commune = await Commune.find({ id_district: req.params.district });
        return res.send(commune);
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
})

module.exports = router;