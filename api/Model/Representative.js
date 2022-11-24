const Joi = require('joi');
const joiObjectid = require('joi-objectid');
const mongoose = require('mongoose')
const Schema = mongoose.Schema;
const Representative = mongoose.model('Representative', new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 50
    },
    phone: {
        type: String,
        required: true,
        minlength: 9,
        maxlength: 11
    },
    possition: {
        type: String,
        required:true,
        minlength:3,
        maxlength:50
    },
    image : {
        type: String
    }
},{versionKey: false }));
function validateReprentative(representative){
    const schema = Joi.object({
        name: Joi.string().minlength(5).maxlength(50).required(),
        phone: Joi.string().minlength(9).maxlength(11).required(),
        possition: Joi.string().minlength(3).maxlength(50).required()
    })
    return schema.validate(representative);
}
exports.Representative = Representative;
exports.validateReprentative = validateReprentative;
