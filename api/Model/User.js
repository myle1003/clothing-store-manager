const mongoose = require('mongoose');
const Joi = require('joi');
const Schema = mongoose.Schema;
const Account = require('./Account');
Joi.objectId = require('joi-objectid')(Joi);

//------------ User Schema ------------//
const UserSchema = new mongoose.Schema({
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
        // required: true
    }
}, { versionKey: false });

const User = mongoose.model('User', UserSchema);

module.exports = User;