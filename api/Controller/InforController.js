const Infor = require('../Model/Infor');
const { Commune } = require('../Model/Commune');
const { District } = require('../Model/District');


exports.getInfor = async function(req, res) {
    try {
        const infor = await Infor.find({});
        var id_commune = infor[0].address.id_commune;
        var district = await Commune.findById(id_commune);
        var id_district = district.id_district;
        var province = await District.findById(id_district);
        address = {
            id_province: province.id_province,
            id_district: id_district,
            id_commune: id_commune,
            street: infor[0].address.street
        }

        var infors = {
            _id: infor[0]._id,
            name_shop: infor[0].name_shop,
            address: address,
            phone: infor[0].phone,
            ig: infor[0].ig,
            facebook: infor[0].facebook,
            policy: infor[0].policy,
            card: infor[0].card
        }
        res.status(200).json({
            message: "success",
            infor: infors,
            status: true
        });
    } catch (e) {
        res.send(e);
    }
}