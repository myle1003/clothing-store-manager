const express = require('express');
const auth = require('../middleware/auth');
const { populate } = require('../Model/Account');
const { Bill } = require('../Model/Bill');
const { Cart } = require('../Model/Cart');
const { Order_history } = require('../Model/Order_history');
const { Product } = require('../Model/Product');
const router = express.Router();

router.get('/all/:page',async function(req,res){
    try{
        const page = req.params.page
        let count = await Order_history.countDocuments();
        if (count !== 0){
            count = parseInt((count-1)/10) + 1
        }
        let orderhistory = await Order_history.find({isCancel:{status: false}}).sort({ 'history.0.date': -1 }).limit(10).skip((page - 1) * 10).select(['id_bill','history']).populate({path: 'id_bill',
        select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method','delivery'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'}, 
        {path:'delivery',select:'name'},{path:'id_info'
        ,select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        res.status(200).send({message:"success",bills:orderhistory,count:count});
    }catch(ex){
        res.status(400).send({message:"error",status:false});
        console.log(ex);
    }
})
router.put('/update/:id',async function(req,res){
    try{
        let orderhistory = await Order_history.findByIdAndUpdate(req.params.id,{
            $push: { history: {id_status: req.body.id_status, date: Date.now()} }
        })
        orderhistory = await Order_history.findById(req.params.id).select(['id_bill','history']).populate({path: 'id_bill',
        select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'}, {path:'delivery',select:'name'},
        {path:'id_info',select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        if(req.body.id_status === "63691ea23f2070927236ba42"){
            orderhistory.id_bill.product.forEach(async product => {
                await Product.findByIdAndUpdate(product.id_product._id,{ $inc: { sold: product.number }})
            });
        }
        res.status(200).send({message:'success',status:true,bill:orderhistory})
    }catch(ex){
        console.log(ex);
        res.status(400).send({message:'error',status:false})
    }
})
router.post('/cancel/:id', async function(req,res){
    try{
        let orderhistory = await Order_history.findByIdAndUpdate(req.params.id,{
            isCancel: {status: true, date: Date.now(),reason: req.body.reason}
        })
        orderhistory.id_bill.product.forEach(async product => {
            await Product.findByIdAndUpdate(product.id_product._id,{ $inc: { sold: (product.number * -1) }})
        });
        res.status(200).send({message:'success',status:true})
    }catch(ex){
        console.log(ex);
        res.status(400).send({message:'error',status:false})
    }
})
router.post('/update-many',async function(req,res){
    try{
        const listID = req.body.listID
        await Order_history.updateMany({
            _id:
                {
                    $in:listID
                }
        },{ $push: { history: {id_status: req.body.id_status, date: Date.now()}}})
        res.status(200).send({message:'success'})
    }catch(ex){
        res.status(400).send({message:'error'})
    }
})
router.get('/type/:status/:delivery/:page',async function(req,res){
    try{
        const page = req.params.page
        const status = req.params.status
        const delivery = req.params.delivery
        let count = await Order_history.countDocuments({isCancel:{status: false},
            history: { $size: status },delivery:delivery});
        if (count !== 0){
            count = parseInt((count-1)/10) + 1
        }
        let orderhistory = await Order_history.find({isCancel:{status: false},
        history: { $size: status },delivery:delivery}).sort({ 'history.0.date': -1 }).
        limit(10).skip((page - 1) * 10).select(['id_bill','history']).populate({path: 'id_bill',
        select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method','delivery'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'}, 
        {path:'delivery',select:'name'},{path:'id_info'
        ,select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        res.status(200).send({message:"success",bills:orderhistory,count:count});
    }catch(ex){
        res.status(400).send({message:"error",status:false});
        console.log(ex);
    }
})
module.exports = router;