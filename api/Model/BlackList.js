const mongoose = require('mongoose');
const Joi = require('joi');
const Schema = mongoose.Schema;
const Account = require('./Account');
Joi.objectId = require('joi-objectid')(Joi);

//------------ User Schema ------------//
const BlackListSchema = new mongoose.Schema({
    id_account: {
        type: Schema.Types.ObjectId,
        ref: Account
    }
}, { versionKey: false });

const BlackList = mongoose.model('BlackList', BlackListSchema);

module.exports = BlackList;