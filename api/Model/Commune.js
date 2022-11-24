const mongoose = require('mongoose');
const Joi = require('joi')
const { District } = require('./District');
Joi.objectId = require('joi-objectid')(Joi);
const { Representative } = require('./Representative');
const Schema = mongoose.Schema;
const Commune = mongoose.model('Commune',new mongoose.Schema({
    name: {
        type: String
    },
    id_district:{
        type: Schema.Types.ObjectId,
        ref: District
    }
},{versionKey: false }))
exports.Commune = Commune;