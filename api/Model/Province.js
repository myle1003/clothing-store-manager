const mongoose = require('mongoose');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);
const { Representative } = require('./Representative');
const Schema = mongoose.Schema;
const Province = mongoose.model('Province',new mongoose.Schema({
    name: {
        type: String
    },
    region: {
        type: String
    }
},{versionKey: false }))
exports.Province = Province