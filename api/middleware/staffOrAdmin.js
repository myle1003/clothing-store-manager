const jwt = require('jsonwebtoken');
const Account = require('../Model/Account');
require('dotenv').config();

async function staffOrAdmin(req, res, next) {
    const token = req.header('token');
    if (!token) {
        res.status(401).json({
            message: 'Access denied. No token provided',
            status: false
        });
    } else {
        try {
            const decoded = jwt.verify(token, process.env.PRIVATE_KEY);
            req.user = decoded;
            console.log(req.user);
            const id_account = req.user.id;
            var account = await Account.findOne({ _id: id_account });
            if ((account.id_role == 1) || (account.id_role == 0)) {
                next();
            } else {
                res.status(400).json({
                    message: 'Account cannot access this page',
                    status: false
                });
            }
        } catch (ex) {
            res.status(400).json({
                message: 'Invalid token',
                status: false
            });
        }
    }
}
module.exports = staffOrAdmin;