const mongoose = require('mongoose');
const { Commune } = require('./Commune');
const Joi = require('joi')
Joi.objectId = require('joi-objectid')(Joi);
const { Representative } = require('./Representative');
const { Product } = require('./Product');
const Schema = mongoose.Schema;
const Supply = mongoose.model('Supply',new mongoose.Schema({
    name: {
        type: String,
        minlength: 5,
        maxlength: 100,
        required: true
    },
    phone: {
        type: String,
        minlength: 9,
        maxlength: 11,
        required:true
    },
    street: {
        type: String,
        minlength:5,
        maxlength:100,
        required: true
    },
    id_commune:{
        type: Schema.Types.ObjectId,
        ref: Commune,
        required: true
    },
    id_representative:{
        type: Schema.Types.ObjectId,
        ref: Representative,
        required: true
    },
    listProduct:[{
        type: Schema.Types.ObjectId,
        ref: Product,
        // default: []
    }],
    image:{
        type: String,
        required:true
    }
},{versionKey: false }));
function validateSupply(supply){
    const schema = Joi.object({
        name: Joi.string().minlength(5).maxlength(50).required(),
        phone: Joi.string().minlength(9).maxlength(11).required(),
        street: Joi.string().minlength(5).maxlength(100).required(),
        id_commune: Joi.objectId().required(),
        id_representative: Joi.objectId().required()
    })
    return schema.validate(representative);
}
exports.Supply = Supply;
exports.validateSupply = validateSupply;
