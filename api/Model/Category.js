const Joi = require('joi');
const mongoose = require('mongoose');
const Category = mongoose.model('Category',new mongoose.Schema({
    name:{
        type: String,
        require: true,
        minlength: 2,
        maxlength: 100,
        unique: true
    },
    slug:{
        type: String,
        require: true
    }
},{ versionKey: false }));
function validateCate(category){
    const schema = Joi.object({
        name: Joi.string().min(2).max(100).required()
    });
    return schema.validate(category)
}
exports.Category = Category;
exports.validateCate = validateCate;
