const express = require('express');
const { populate, exists } = require('../Model/Account');
const { Product } = require('../Model/Product');
const { Representative } = require('../Model/Representative');
const { Supply } = require('../Model/Supply');

const router = express.Router();
router.post('/insert', async function(req, res) {
    try {
        console.log(req.body)
        let representative = new Representative(req.body.representative);
        representative = await representative.save();
        // let supply = new Supply({name:req.body.name,phone:req.body.phone,street:req.body.street,id_commune:req.body.id_commune,id_representative:req.body.id_representative});
        let supply = new Supply({
            id_representative: representative._id,
            id_commune: req.body.supply.id_commune,
            name: req.body.supply.name,
            phone: req.body.supply.phone,
            street: req.body.supply.street,
            image: req.body.supply.image
        });
        supply = await supply.save();
        res.status(200).send(supply);
    } catch (e) {
        logger.info(e);
        logger.error(e);
        res.status(400).send({messsage:'error'});
    }
})
router.delete('/delete/:id', async function(req, res) {
    try {
        let supply = await Supply.findById(req.params.id);
        if (supply.listProduct.length > 0) {
            res.send({ message: 'Supply has products, cant be delete' })
        } else {
            let representative = await Representative.findByIdAndDelete(supply.id_representative);
            supply = await supply.delete();
            res.status(200).send({ message: 'Delete successful' })
        }
    } catch (e) {
        logger.info(e);
        logger.error(e);
        res.status(400).send({messsage:'error'});
    }
})
router.get('/all/:page',async function(req,res){
    try{
        const page = req.params.page;
        const supplies = await Supply.find({}).limit(10).skip((page - 1) * 10).sort({'_id':-1}).populate('id_representative',['name','phone','possition','image'])
        .populate('listProduct','name').populate({path: 'id_commune', select: 'name',
        populate : {path:'id_district',select:'name', populate:{path:'id_province',select:'name'}}} )
        let count = await Supply.countDocuments();
        count = parseInt((count-1)/10) +1
        return res.status(200).send({supplies: supplies, count: count});
    }
    catch(e){
        res.status(400).send({messsage:'error'});

    }
})
router.get('/detail/:id', async function(req, res) {
    try {
        const supply = await Supply.findById(req.params.id).populate({
            path: 'id_commune',
            select: 'name',
            populate: { path: 'id_district', select: 'name', populate: { path: 'id_province', select: 'name' } }
        })
        return res.status(200).send({ supply: supply });
    } catch (e) {
        res.status(400).send({messsage:'error'});
    }
})
router.get('/representative/:id', async function(req, res) {
    try {
        const representative = await Representative.findById(req.params.id);
        return res.status(200).send({ representative: representative });
    } catch (e) {
        logger.info(e);
        logger.error(e);
        res.status(400).send({messsage:'error'});
    }
})
router.put('/update/:id', async function(req, res) {
    try {
        let supply = await Supply.findByIdAndUpdate(req.params.id, {
            id_commune: req.body.supply.id_commune,
            name: req.body.supply.name,
            phone: req.body.supply.phone,
            street: req.body.supply.street,
            image: req.body.supply.image
        }, { new: true });
        let representative = await Representative.findByIdAndUpdate(supply.id_representative, { phone: req.body.representative.phone, name: req.body.representative.name, possition: req.body.representative.possition });
        // let supply = new Supply({name:req.body.name,phone:req.body.phone,street:req.body.street,id_commune:req.body.id_commune,id_representative:req.body.id_representative});
        res.status(200).send(supply);
    } catch (e) {
        logger.error(e);
        logger.info(e);
        res.status(400).send(e);
    }
})
router.get('/product/:id',async function(req,res){
    try{
        let supply = await Supply.findById(req.params.id).select(['listProduct','name'])
        .populate({path:'listProduct',select:['name','id_cate'],
        populate:{path:'id_cate',select:'name'}})
        let newProduct = await Product.find({status:'Chưa tồn tại'})
        .select(['name','id_cate']).populate('id_cate','name')
        let result = [...newProduct,...supply.listProduct]
        res.status(200).send({product:result,name:supply.name}) 
    }
    catch(ex){
        console.log(ex)
         res.status(400).send({message:'error'})
    }
})
module.exports = router;