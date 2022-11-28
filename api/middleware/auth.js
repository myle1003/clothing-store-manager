const jwt = require('jsonwebtoken');
require('dotenv').config();

// const config = require('config');
async function auth(req, res, next) {
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
            next();
        } catch (ex) {
            res.status(400).json({
                message: 'Invalid token',
                status: false
            });
        }
    }
}
module.exports = auth;