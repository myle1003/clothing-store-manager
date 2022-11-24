const Joi = require('joi');
const mongoose = require('mongoose');
const Area = mongoose.model('Area', new mongoose.Schema({
    name: {
        type: String,
        require: true,
        unique: true
    }
}, { versionKey: false }));

exports.Area = Area;