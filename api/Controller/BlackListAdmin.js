const auth = require('../middleware/auth');
const Account = require('../Model/Account');
const BlackList = require('../Model/BlackList');
const {logger} = require('../logger/logger');


//------------ Create ------------//
exports.createBlackList = async(req, res) => {
    try {
        const email = (req.body.id_account);
        var account = await Account.findOne({email:email} );
        console.log(account);

        
        var blackList = await BlackList.findOne({id_account:account.id} );
        if(blackList){
            res.status(200).json({
                message: "Email exist in black list",
                blackList: blackList ,
                status: false
            });
        } else {

            var newBlackList = new BlackList({
                id_account: account.id
            });
            newBlackList = await newBlackList.save();
            res.status(200).json({
                message: "success",
                blackList: newBlackList,
                status: true
            });
        }

        
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.getBlackList = async function(req, res) {
    try {
        const blackList = await BlackList.find().populate('id_account', ['name','email'])
        res.status(200).json({
            message: "success",
            blackList: blackList,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.checkBlackList = async function(req, res) {
    try {
        const id_account = req.user.id;
        const blackList = await BlackList.findOne({ id_account: id_account })
        if(!blackList){
            res.status(200).json({
                message: "Use",
                status: true
            });
        } else {
            res.status(200).json({
                message: "Unuse",
                status: true
            });
        }
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.deleteBalckList = async function(req, res) {
    try {
        const blackList = await BlackList.findByIdAndRemove(req.params.id);
        if (!blackList) return res.status(404).send({ message: 'Not availble' });
        res.send({ message: 'Success' });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}