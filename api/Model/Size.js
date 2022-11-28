const Joi = require('joi');
const mongoose = require('mongoose');
const Size = mongoose.model('Size',new mongoose.Schema({
    name:{
        type: String,
        require: true,
        unique: true
    },
    description:{
        type: String,
        require: true
    }
},{versionKey: false }));

exports.Size = Size;
