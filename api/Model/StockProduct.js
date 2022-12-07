const Joi = require('joi');
const objectid = require('joi-objectid');
const mongoose = require('mongoose');
const { Color } = require('./Color');
const { Product } = require('./Product');
const { Size } = require('./Size');
const Schema = mongoose.Schema;
const StockProduct = mongoose.model('StockProduct', new mongoose.Schema({
    id_product:{
        type: Schema.Types.ObjectId,
        ref: Product,
        required: true
    },
    size: {
        type: Schema.Types.ObjectId,
        ref: Size,
        required: true
    },
    color:{
        type: Schema.Types.ObjectId,
        ref: Color,
        required: true
    },
    number:{
        type: Number,
        default:0,
        required: true
    }
},{versionKey: false }));
// function validateStock(representative){
//     const schema = Joi.object({
//         totalPrice: Joi.number.required(),
//         dateReceive: Joi.date().required(),
//         id_product: Joi.objectId().required(),
//         id_supply: Joi.objectId().required()
//     });
//     return schema.validate(representative);
// }
exports.StockProduct = StockProduct;
    // exports.validateStock = validateStock;
