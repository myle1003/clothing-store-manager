const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);
const { join } = require('lodash');
const {Category} = require('./Category');
const mongoose = require('mongoose');
const { Size } = require('./Size');
const { Color } = require('./Color');
const Schema = mongoose.Schema;
const Product = mongoose.model('Product', new mongoose.Schema({
    name:{
        type: String,
        required:true,
        // trim: true,
        minlength:3,
        maxlength: 200,
    },
    sellDay:{
        type: Date,
        // default: Date.now(),
    },
    weight:{
        type: Number,
        // required : true
    },
    price:{
        type: Number,
        // required : true
    },
    status:{
        type: String,
        default: 'Chưa tồn tại'
    },
    slug:{
        type: String, 
        required: true
    },
    urlImage:{
        type: [String],
        // required: true
    },
    sold:{
        type: Number,
        default: 0
    },
    id_cate:{
        type: Schema.Types.ObjectId,
        ref: Category,
        required: true
    },
    description:{
        type: String
    },
    discount:{
        type: Number,
        default:0
    },
    size: [{
        type: Schema.Types.ObjectId,
        ref: Size,
        default: []
    }],
    color: [{
        type: Schema.Types.ObjectId,
        ref: Color,
        default: []
    }],

},{versionKey: false }));
function validateNewProduct(product){
    const schema = Joi.object({
        name: Joi.string().min(10).max(100).required(),
        cateID: Joi.objectId().required(),
        // price: Joi.number().min(0).required(),
        // weight: Joi.number().min(0).required(),
        // urlImage: Joi.array().required(),
        // availble: Joi.array().required()
        // image: Joi.required()
    })
    return schema.validate(product);
}
function validateUpdateProduct(product){
    const schema = Joi.object({
        name: Joi.string().min(10).max(100).required(),
        cateID: Joi.objectId().required(),
        price: Joi.number().min(0).required(),
        weight: Joi.number().min(0).required(),
        urlImage: Joi.array().required(),
    })
    return schema.validate(product);
}
exports.Product = Product;
exports.validateUpdateProduct = validateUpdateProduct;
exports.validateNewProduct = validateNewProduct;