const Joi = require('joi');
const mongoose = require('mongoose');
const Account = require('./Account');
const { Color } = require('./Color');
const { Commune } = require('./Commune');
const Delivery = require('./Delivery');
const InforAddress = require('./InforAddress');
const { Payment_method } = require('./Payment_method');
const { Product } = require('./Product');
const { Size } = require('./Size');
const Schema = mongoose.Schema;

const Bill = mongoose.model('Bill', new mongoose.Schema({
    id_account: {
        type: Schema.Types.ObjectId,
        ref: Account,
        required: true
    },
    product: [{
        id_product: {
            type: Schema.Types.ObjectId,
            ref: Product
            // required: true
        },
        size: {
            type: Schema.Types.ObjectId,
            ref: Size
            // required: true
        },
        color: {
            type: Schema.Types.ObjectId,
            ref: Color
            // required: true
        },
        number: {
            type: Number,
            // required:true
        },
        price:{
            type:Number
        }
    }],
    payment_method: {
        type: Schema.Types.ObjectId,
        ref: Payment_method
    },
    delivery:{
        type: Schema.Types.ObjectId,
        ref: Delivery,
        required:true
    },
    weight: {
        type: Number,
        default: 0
    },
    totalPrice: {
        type: Number,
        default: 0
    },
    productPrice:{
        type: Number,
        default:0
    },
    shipPrice:{
        type: Number,
        default:0
    },
    createAt: {
        type: Date,
    },
    id_info: {
        type: Schema.Types.ObjectId,
        ref: InforAddress
    }
}, { versionKey: false }));
// function validateCart(Cart){
//     const schema = Joi.object({
//         name: Joi.string().min(2).max(100).required()
//     });
//     return schema.validate(Cart)
// }
exports.Bill = Bill;
// exports.validateCart = validateCart;