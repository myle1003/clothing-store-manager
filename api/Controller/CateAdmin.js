const express = require('express');
// const {Category,validateCate} = require('../model/Category');
const mongoose = require('mongoose');
const SlugF = require('../Config/slug');
const { Category, validateCate } = require('../Model/Category');
const { Product } = require('../Model/Product');
// const auth = require('../middleware/auth');

exports.GetListCate = async function GetlistCate(req,res){
    const categories = await Category.find().sort('name');
    res.send(categories);
}
exports.GetCateDetail = async function GetCateDetail(req,res){
    const category = await Category.findOne({slug:req.params.slug});
    if(!category) return res.status(404).send({message: 'Not availble'});
    res.send(category);
}
exports.InsertCate = async function InsertCate(req,res){
    const sl = await SlugF(req.body.name);
    const {error} = validateCate(req.body);
    if(error) return res.status(400).send(error.details[0].message);
    let cate = new Category({name: req.body.name,slug:sl});
    cate =  await cate.save();
    res.send(cate);
}
exports.UpdateCate = async function UpdateCate(req,res){
    const {error} = validateCate(req.body);
    if(error) return res.status(400).send(error.details[0].message);
    const sl = await SlugF(req.body.name)
    const cate = await Category.findOneAndUpdate({slug:req.params.slug},{name:req.body.name,slug:sl},{new:true});
    if(!cate) return res.status(400).send({message: 'Not availble'});
    res.send(cate);
}
exports.deleteCate = async function DeleteCate(req,res){
    const product = await Product.find({id_cate:req.params.id});
    if(product.length != 0){
        return res.send({message:'The category has products, cant be delete'})
    }
    const cate = await Category.findByIdAndRemove(req.params.id);
    if(!cate) return res.status(404).send({message: 'Not availble'});
    res.send({message: 'Success'});
}