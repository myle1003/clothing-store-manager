const mongoose = require('mongoose');
const Joi = require('joi');
const Schema = mongoose.Schema;
const Account = require('./Account');
const { Commune } = require('./Commune');
const { Province } = require('./Province');
const { District } = require('./District');
Joi.objectId = require('joi-objectid')(Joi);

//------------ User Schema ------------//
const InforAddressSchema = new mongoose.Schema({
    name: {
        type: String
    },
    phone: {
        type: String
    },
    role: {
        type: Boolean
    },
    id_account: {
        type: Schema.Types.ObjectId,
        ref: Account
    },
    address: {
        id_province: {
            type: Schema.Types.ObjectId,
            ref: Province
        },
        id_district: {
            type: Schema.Types.ObjectId,
            ref: District
        },
        id_commune: {
            type: Schema.Types.ObjectId,
            ref: Commune
        },
        street: {
            type: String,
        }
    }
}, { versionKey: false });

const InforAddress = mongoose.model('InforAddress', InforAddressSchema);

module.exports = InforAddress;