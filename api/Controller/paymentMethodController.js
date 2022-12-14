const { Payment_method } = require("../Model/Payment_method");

exports.getPaymentMethod = async function(req, res) {
    try {
        const payment = await Payment_method.find({});
        res.status(200).json({
            message: "success",
            payment_method: payment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.createPaymentMethod = async function(req, res) {
    try {
        const name = (req.body.name);
        const card = (req.body.card);

        var newPayment = new Payment_method({
            name: name,
            card: card
        });
        newPayment = await newPayment.save();

        res.status(200).json({
            message: "success",
            payment: newPayment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.deletePaymentMethod = async function(req, res) {
    try {
        const payment = await Payment_method.findByIdAndRemove(req.params.id);
        if (!payment) return res.status(404).send({ message: 'Not availble' });
        res.send({ message: 'Success' });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.editPaymentMethod = async function(req, res) {
    try {
        const name = (req.body.name);
        const card = (req.body.card);

        var payment = await Payment_method.findByIdAndUpdate(req.params.id, {
            name: name,
            card: card
        });

        payment = await Payment_method.findById(req.params.id);
        res.status(200).json({
            message: "success",
            payment: payment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}