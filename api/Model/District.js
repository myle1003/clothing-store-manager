const mongoose = require('mongoose');
const Joi = require('joi');
const { Province } = require('./Province');
Joi.objectId = require('joi-objectid')(Joi);
const Schema = mongoose.Schema;
const District = mongoose.model('District',new mongoose.Schema({
    name: {
        type: String
    },
    id_province: {
        type: Schema.Types.ObjectId,
        ref: Province
    }
},{versionKey: false }))
exports.District = District