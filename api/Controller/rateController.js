const Rate = require('../Model/Rate');
const auth = require('../middleware/auth');
const {logger} = require('../logger/logger');
// const { District } = require('../Model/District');


exports.getRate = async function(req, res) {
    try {
        const rates = await Rate.findOne({ id_product: req.params.id_product });
        const rate = {
            _id: rates._id,
            id_product: rates.id_product,
            rate: rates.rate
        }
        res.status(200).json({
            message: "success",
            comment: rate,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}