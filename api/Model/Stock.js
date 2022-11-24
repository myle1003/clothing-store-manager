const Joi = require('joi');
const objectid = require('joi-objectid');
const mongoose = require('mongoose');
const { Color } = require('./Color');
const { Product } = require('./Product');
const { Size } = require('./Size');
const { Supply } = require('./Supply');
const Schema = mongoose.Schema;
const Stock = mongoose.model('Stock', new mongoose.Schema({
    receive: [{
            id_product:{
                type: Schema.Types.ObjectId,
                ref: Product,
                unique: true,
                required: true
            },
            receive:[
                {
                    size:{
                        type: Schema.Types.ObjectId,
                        ref: Size,
                        required:true
                    },
                    color:{
                        type: String,
                        ref: Color,
                        required: true
                    },
                    number:{
                        type: Number,
                        required: true
                    }
                }
            ],
            price: {
                type: Number,
                required: true
            }
    }
    ],
    remain: [{
        id_product:{
            type: Schema.Types.ObjectId,
            ref: Product,
            unique: true,
            required: true
        },
        receive:[
            {
                size:{
                    type: Schema.Types.ObjectId,
                    ref: Size,
                    required:true
                },
                color:{
                    type: String,
                    ref: Color,
                    required: true
                },
                number:{
                    type: Number,
                    required: true
                }
            }
        ]
    }
    ],
    id_supply:{
        type: Schema.Types.ObjectId,
        ref: Supply,
        required: true
    },
    dateReceive: {
        type: Date,
        required:true
    },
    totalPrice:{
        type: Number,
    },
    status:{
        type: Boolean,
        required: true
    }
},{versionKey: false }));
function validateStock(representative){
    const schema = Joi.object({
        totalPrice: Joi.number.required(),
        dateReceive: Joi.date().required(),
        id_product: Joi.objectId().required(),
        id_supply: Joi.objectId().required()
    });
    return schema.validate(representative);
}
exports.Stock = Stock;
exports.validateStock = validateStock;
