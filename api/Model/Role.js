const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const RoleSchema = new mongoose.Schema({
    name:{
        type: String,
        require: true,
        default: 'Customer'
    }
});
const Role = mongoose.model('Role',RoleSchema)
function validateRole(role){
    const schema = Joi.object({
        name: Joi.string().min(1).max(50).required(),
    });
    return schema.validate(role);
}
exports.Role = Role;
exports.validateRole = validateRole;