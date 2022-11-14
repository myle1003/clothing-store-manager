const Joi = require('joi');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const { Product } = require('./Product');

const RateSchema = new mongoose.Schema({
    id_product: {
        type: Schema.Types.ObjectId,
        ref: Product,
        required: true
    },
    rate: {
        type: Number,
        default:0
    },
    sum: {
        type: Number,
        default:0
    },
    amount: {
        type: Number,
        default:0
    }
}, { versionKey: false })

const Rate = mongoose.model('Rate', RateSchema);
module.exports = Rate;