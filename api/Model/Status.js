const Joi = require('joi');
const mongoose = require('mongoose');
const Status = mongoose.model('Status', new mongoose.Schema({
    name: {
        type: String,
        require: true,
        unique: true
    }
}, { versionKey: false }));

exports.Status = Status;