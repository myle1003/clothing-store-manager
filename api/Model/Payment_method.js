const Joi = require('joi');
const mongoose = require('mongoose');
const Payment_method = mongoose.model('Payment_method', new mongoose.Schema({
    name: {
        type: String,
        require: true,
        minlength: 2,
        maxlength: 100,
        unique: true
    },
    card: [{
        bank: {
            type: String,
        },
        name: {
            type: String,
        },
        number: {
            type: String,
        }
    }]
}, { versionKey: false }));

exports.Payment_method = Payment_method;