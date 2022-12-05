const express = require('express');
const auth = require('../middleware/auth');
const { populate } = require('../Model/Account');
const { Bill } = require('../Model/Bill');
const { Cart } = require('../Model/Cart');
const { Order_history } = require('../Model/Order_history');
const { Stock } = require('../Model/Stock');
const router = express.Router();
async function UpdateStock(product) {


    let stock = await Stock.find({ 'remain.id_product': product.id_product }).sort({ 'dateReceive': -1 })
    stock[0].remain.forEach(function(remain) {
        if (remain.id_product == (product.id_product).toString()) {
            remain.receive.forEach(function(properties) {
                if (properties.size == (product.size).toString() & properties.color == (product.color).toString()) {
                    properties.number = properties.number - product.number;
                }
            })
        }
    });
    await stock[0].save();
}
router.post('/insert', auth, async function(req, res) {
    try {
        let totalPrice = req.body.shipPrice + req.body.productPrice
        let bill = new Bill({
            id_account: req.user.id,
            product: req.body.product,
            shipPrice: req.body.shipPrice,
            productPrice: req.body.shipPrice,
            totalPrice: totalPrice,
            createAt: Date.now(),
            id_info: req.body.id_info,
            id_delivery: req.body.delivery,
            payment_method: req.body.payment_method
        })
        await bill.save();
        bill.product.forEach(async function(product) {
            await UpdateStock(product);
        })
        await Cart.findOneAndUpdate({ id_account: req.user.id }, { $set: { product: [] } }, );
        let orderhistory = new Order_history({ id_bill: bill._id, history: [{ id_status: "63691e673f2070927236ba3f", date: Date.now() }] });
        orderhistory = await orderhistory.save();
        res.status(200).send({ message: "success", status: true });
    } catch (ex) {
        res.status(400).send({ message: "error", status: false });
        console.log(ex);
    }
})

router.get('/all',auth,async function(req,res){
    try{
        let orderhistory = await Order_history.find({}).populate({path: 'id_bill',
        match: { id_account: req.user.id}, select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'},{path:'id_info'
        ,select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        res.status(200).send({message:"success",bills:orderhistory});
    }catch(ex){
        res.status(400).send({message:"error",status:false});
        console.log(ex);
    }
})
router.get('/type/:type',auth,async function(req,res){
    try{
        let orderhistory = await Order_history.find({history:{ $size: req.params.type }}).populate({path: 'id_bill',
        match: { id_account: req.user.id}, select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'},{path:'id_info'
        ,select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        res.status(200).send({message:"success",bill:orderhistory});
    }catch(ex){
        res.status(400).send({message:"error",status:false});
    }
})
router.get('/detail/:id',auth,async function(req,res){
    try{
        let orderhistory = await Order_history.findById(req.params.id).populate({path: 'id_bill',
        match: { id_account: req.user.id}, select: ['id_info','product','totalPrice','createAt','productPrice','shipPrice','payment_method'],
        populate: [{path:'product.id_product',select:['name','urlImage']},
        {path:'product.size',select:'name'},{path:'product.color',select:'name'},{path:'payment_method',select:'name'},{path:'id_info'
        ,select:['name','phone','address'],populate:[{path:'address.id_province',select:'name'},
        {path:'address.id_district',select:'name'}, {path:'address.id_commune',select:'name'}]}]}).
        populate('history.id_status',['name'])
        res.status(200).send({message:"success",bill:orderhistory});
    }catch(ex){
        res.status(400).send({message:"error",status:false});
    }
})
// router.post('/test',async function(req,res){
//     try{
//         let stock = await Stock.find({'remain.id_product':req.body.id_product}).sort({'dateReceive':-1})
//         console.log(stock[0].remain);
//         stock[0].remain.forEach(function(remain){
//             if(remain.id_product == req.body.id_product){
//                 remain.receive.forEach(function(properties){
//                     if(properties.size == req.body.size & properties.color == req.body.color){
//                         properties.number = properties.number - 1;
//                     }
//                 })
//             }
//         });
//         await stock[0].save();
//         res.send(stock);
//     }catch(ex){
//         console.log(ex);
//     }
// })
module.exports = router;

