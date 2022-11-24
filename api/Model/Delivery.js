const Joi = require('joi');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const DeliverySchema = new mongoose.Schema({
    name: {
        type: String,
        // required: true
    },
    note: {
        type: String,
        // required: true
    },
    price: {
        type: Number,
    },
    status: {
        type: Boolean,
    }
}, { versionKey: false })

const Delivery = mongoose.model('Delivery', DeliverySchema);
module.exports = Delivery;