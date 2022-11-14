const Joi = require('joi');
const mongoose = require('mongoose');
const Account = require('./Account');
const Schema = mongoose.Schema;

const { Product } = require('./Product');

const CommentSchema = new mongoose.Schema({
    id_account: {
        type: Schema.Types.ObjectId,
        ref: Account,
        required: true
    },
    id_product: {
        type: Schema.Types.ObjectId,
        ref: Product,
        required: true
    },
    urlImage: {
        type: [String],
        // required: true
    },
    content: {
        type: String,
    },
    star: {
        type: Number,
    }
}, { versionKey: false })

const Comment = mongoose.model('Comment', CommentSchema);
module.exports = Comment;