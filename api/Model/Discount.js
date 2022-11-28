const Joi = require('joi');
const mongoose = require('mongoose');
const { Product } = require('./Product');
const Schema = mongoose.Schema;

const Discount = mongoose.model('Discount',new mongoose.Schema({
    percent:{
        type: Number,
        require: true,
        minlength: 1,
        maxlength: 100,
        unique: true
    },
    date_create:{
        type: Date,
        default: Date.now()
    },
    status:{
        type: Boolean,
        default: true
    },
    time:{
        type: Number,
        require: true
    },
    id_product: [{
        type: Schema.Types.ObjectId,
        ref: Product,
    }
    ]
},{ versionKey: false }));
// function validateDiscount(discount){
//     const schema = Joi.object({
//         name: Joi.string().min(2).max(100).required()
//     });
//     return schema.validate(category)
// }
exports.Discount = Discount;
// exports.validateCate = validateCate;
