const InforAddress = require('../Model/InforAddress');


//------------ Create ------------//
exports.createInforAddress = async(req, res) => {
    try {
        const name = (req.body.name);
        const id_account = req.user.id;
        const phone = (req.body.phone);
        const address = (req.body.address);
        const role = (req.body.role);
        if (role == true) {
            var inforAddress = await InforAddress.findOne({ role: role });
            var id = inforAddress._id;
            inforAddress = await InforAddress.findByIdAndUpdate(id, { role: false });
        }
        const newInforAddress = new InforAddress({
            name,
            id_account,
            address,
            phone,
            role
        });
        newInforAddress.save();

        res.status(200).json({
            message: "success",
            inforAddress: newInforAddress,
            status: true
        });
    } catch (e) {
        res.send(e);
    }
}



//------------ update ------------//
exports.updateInforAddress = async(req, res) => {
    try {
        const name = (req.body.name);
        const phone = (req.body.phone);
        const role = (req.body.role);
        var address = (req.body.address);

        if (role == true) {
            var inforAddress = await InforAddress.findOne({ role: role });
            var id = inforAddress._id;
            inforAddress = await InforAddress.findByIdAndUpdate(id, { role: false });
        }
        const id_account = req.user.id;
        var inforAddress = await InforAddress.findOne({ id_account: id_account });
        var id = inforAddress.id;

        inforAddress = await InforAddress.findByIdAndUpdate(id, { name: name, phone: phone, address: address, role: role });

        inforAddress = await InforAddress.findOne({ id_account: id_account });

        if (!inforAddress) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        } else {
            res.status(200).json({
                message: "success",
                inforAddress: inforAddress,
                status: true
            });
        }
    } catch (e) {
        res.send(e);
    }
}


//------------ get user ------------//
exports.getInforAddresss = async(req, res) => {
    try {
        const id_account = req.user.id;
        var inforAddress = await InforAddress.find({ id_account: id_account }).populate('address.id_province', ['name', 'region']).populate('address.id_district', ['name']).populate('address.id_commune', ['name']);
        if (!inforAddress) {
            res.status(404).json({
                message: 'Not availble',
                status: false
            });
        }
        res.status(200).json({
            message: 'success',
            inforAddress: inforAddress,
            status: true
        });
    } catch (e) {
        res.send(e);
    }
}

//------------ delete user ------------//
exports.deleteInforAddresss = async(req, res) => {
    try {
        const inforAddress = await InforAddress.findByIdAndDelete(req.params.id);

        if (!inforAddress) {
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