const mongoose = require('mongoose');
const Joi = require('joi');
const Schema = mongoose.Schema;
const Account = require('./Account');
Joi.objectId = require('joi-objectid')(Joi);

//------------ User Schema ------------//
const StaffSchema = new mongoose.Schema({
    fullname: {
        type: String
    },
    id_account: {
        type: Schema.Types.ObjectId,
        ref: Account
    },
    phone: {
        type: String,
    },
    gender: {
        type: Boolean,
        default: false
    },
    urlImage: {
        type: String,
    },
    status: {
        type: Boolean,
    }
}, { versionKey: false });

const Staff = mongoose.model('Staff', StaffSchema);

module.exports = Staff;