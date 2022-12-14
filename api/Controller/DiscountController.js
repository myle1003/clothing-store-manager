const SlugF = require('../config/slug');
const { Discount } = require('../Model/Discount');



exports.getAll = async(req, res) => {
    const discs = await Discount.find();
    // res.send(discs);
    res.status(200).json({
        message: "success",
        discount: discs,
        status: true
    });
}

exports.getDiscount = async(req, res) => {
    var disc = await Discount.findById(req.params.id).exec();
    // res.send(disc);
    res.status(200).json({
        message: "success",
        discount: disc,
        status: true
    });
}

exports.createDiscount = async(req, res) => {
    // const { error } = validateDisc(req.body);
    // if (error) return res.status(400).send(error.details[0].message);

    const id_product = (req.body.id_product);
    const percent = (req.body.percent);
    const date_create = (req.body.date_create);
    const time = (req.body.time);
    const status = (req.body.status);

    let disc = new Discount({ id_product: id_product, percent: percent, date_create: date_create, time: time, status: status });
    disc = await disc.save();
    // res.send(disc);
    res.status(200).json({
        message: "success",
        discount: disc,
        status: true
    });
}


exports.updateDiscount = async(req, res) => {
    // const { error } = validateDisc(req.body);
    // if (error) return res.status(400).send(error.details[0].message);

    
    const id_product = (req.body.id_product);
    const percent = (req.body.percent);
    const date_create = (req.body.date_create);
    const time = (req.body.time);
    const status = (req.body.status);

    let disc = await Discount.findByIdAndUpdate(req.params.id, { id_product: id_product, percent: percent, date_create: date_create, time: time, status: status });
    disc = await disc.save();
    disc = await Discount.findById(req.params.id).exec();
    if (!disc) return res.status(404).send('Not availble');
    // res.send(disc);
    res.status(200).json({
        message: "success",
        discount: disc,
        status: true
    });
}

exports.deleteDiscount = async(req, res) => {
    const disc = await Discount.findByIdAndDelete(req.params.id);
    if (!disc) return res.status(404).send('Not availble');

    res.send('Success');
}