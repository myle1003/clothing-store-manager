const Joi = require('joi');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
Joi.objectId = require('joi-objectid')(Joi);
const { Commune } = require('./Commune');
const InforSchema = new mongoose.Schema({
    name_shop: {
        type: String,
        required: true,
        // trim: true,
        minlength: 3,
        maxlength: 200,
    },
    address: {
        id_commune: {
            type: Schema.Types.ObjectId,
            ref: Commune
        },
        street: {
            type: String,
        }
    },
    phone: {
        type: String,
    },
    ig: {
        type: String,
    },
    facebook: {
        type: String,
    },
    policy: {
        type: String,
        // default: Date.now(),
    },
    card: [{
        bank: {
            type: String,
            // required:true
        },
        name: {
            type: String,
            // required:true
        },
        number: {
            type: String,
            // required:true
        }
    }]

}, { versionKey: false });

const Infor = mongoose.model('Infor', InforSchema);
module.exports = Infor;