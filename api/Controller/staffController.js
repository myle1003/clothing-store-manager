const Staff = require('../Model/Staff');
const Role = require('../Model/Role');
const { Commune } = require('../Model/Commune');
const auth = require('../middleware/auth');
const { District } = require('../Model/District');
const Account = require('../Model/Account');
const jwt = require('jsonwebtoken');
const JWT_KEY = process.env.JWT_KEY;
const JWT_RESET_KEY = process.env.JWT_RESET_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;


//------------ Create ------------//
exports.createStaff = (req, res) => {
    try {
        const fullname = (req.body.fullname);
        const phone = (req.body.phone);
        const gender = (req.body.gender);
        const urlImage = (req.body.urlImage);
        const status = true;
        const email = (req.body.email);
        const password = (req.body.password);
        const id_role = 1;
        const name = fullname;
        Staff.findOne({ phone: phone }).then(staff => {
            if (staff) {
                res.status(400).json({
                    message: 'phone already registered',
                    status: false
                });
            } else {

                const newAccount = new Account({
                    name,
                    email,
                    password,
                    id_role
                });
                const id_account = newAccount.id;
                newAccount.save();
                // bcryptjs.genSalt(10, (err, salt) => {
                //     bcryptjs.hash(newAccount.password, salt, (err, hash) => {
                //         if (err) throw err;
                //         newAccount.password = hash;
                //         newAccount
                //             .save();
                //     });
                // });



                const newStaff = new Staff({
                    fullname,
                    id_account,
                    phone,
                    gender,
                    urlImage,
                    status
                });
                newStaff.save();
                res.status(200).json({
                    message: "success",
                    staff: newStaff,
                    status: true
                });
            }
        })
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

//------------ update ------------//
exports.updateStaff = async(req, res) => {
    try {
        const fullname = (req.body.fullname);
        const phone = (req.body.phone);
        const gender = (req.body.gender);
        var urlImage = (req.body.urlImage);
        var status = (req.body.status);


        var staff = await Staff.findByIdAndUpdate(req.params.id, { fullname: fullname, phone: phone, gender: gender, urlImage: urlImage, status: status });

        staff = await Staff.findById(req.params.id);

        if (!staff) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: 'success',
                staff: staff,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

//------------ get  ------------//
exports.getStaff = async(req, res) => {
    try {
        var staff = await Staff.findById(req.params.id);
        if (!staff) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: 'success',
                staff: staff,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

//------------ get all ------------//
exports.getAllStaff = async(req, res) => {
    try {
        var staff = await Staff.find();
        if (!staff) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: 'success',
                staff: staff,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

//------------ delete user ------------//
exports.deleteStaff = async(req, res) => {
    try {
        const staff = await Staff.findByIdAndDelete(req.params.id);

        if (!staff) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        }
        res.status(200).json({
            message: 'success',
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}