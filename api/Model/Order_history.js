const mongoose = require('mongoose');
const Joi = require('joi');
const { Bill } = require('./Bill');
const { Status } = require('./Status');
const Delivery = require('./Delivery');
const Account = require('./Account');
Joi.objectId = require('joi-objectid')(Joi);
const Schema = mongoose.Schema;
const Order_history = mongoose.model('Order_history',new mongoose.Schema({
    id_bill: {
        type: Schema.Types.ObjectId,
        ref: Bill
    },
    history: [
        {
            id_status: {
                type: Schema.Types.ObjectId,
                ref: Status,
            },
            date:{
                type: Date
            }
        }
    ],
    isCancel: {
        status: {
            type: Boolean,
            default: false
        },
        date:{
            type : Date
        },
        reason:{
            type:String,
        }
    },
    id_account:{
        type: Schema.Types.ObjectId,
        ref: Account
    },
    delivery:{
        type: Schema.Types.ObjectId,
        ref:Delivery
    }
},{versionKey: false }))
exports.Order_history = Order_history;