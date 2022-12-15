const User = require('../Model/User');
const Role = require('../Model/Role');
const { Commune } = require('../Model/Commune');
const auth = require('../middleware/auth');
const { District } = require('../Model/District');


//------------ Create ------------//
exports.createUser = (req, res) => {
    try {
        const fullname = (req.body.fullname);
        const id_account = (req.body.id_account);
        const phone = (req.body.phone);
        const gender = (req.body.gender);
        const urlImage = (req.body.urlImage);

        User.findOne({ phone: phone }).then(user => {
            if (user) {
                res.status(400).json({
                    message: 'phone already registered',
                    status: false
                });
            } else {
                const newUser = new User({
                    fullname,
                    id_account,
                    phone,
                    gender,
                    urlImage
                });
                newUser.save();
                res.status(200).json({
                    message: "success",
                    user: newUser,
                    status: true
                });
            }
        })
    } catch (e) {
        res.send(e);
    }
}

//------------ update ------------//
exports.updateUser = async(req, res) => {
    try {
        const fullname = (req.body.fullname);
        const phone = (req.body.phone);
        const gender = (req.body.gender);
        var urlImage = (req.body.urlImage);

        const id_account = req.user.id;
        var user = await User.findOne({ id_account: id_account });
        var id = user.id;

        var user = await User.findByIdAndUpdate(id, { fullname: fullname, phone: phone, gender: gender, urlImage: urlImage });

        user = await User.findOne({ id_account: id_account });

        if (!user) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: 'success',
                user: user,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
    }
}

//------------ get user ------------//
exports.getUser = async(req, res) => {
    try {
        const id_account = req.user.id;
        var user = await User.findOne({ id_account: id_account });
        if (!user) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: 'success',
                user: user,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
    }
}

//------------ delete user ------------//
exports.deleteUser = async(req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id);

        if (!user) {
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
    }
}