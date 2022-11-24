const Joi = require('joi');
const mongoose = require('mongoose');
const Color = mongoose.model('Color',new mongoose.Schema({
    name:{
        type: String,
        require: true,
        unique: true
    }
},{versionKey: false }));

exports.Color = Color;
