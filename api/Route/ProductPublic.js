const express = require('express');
const { upload } = require('../Config/multer');
const SlugF = require('../Config/slug');
const { Product } = require('../Model/Product');
const cloudinary = require('../Config/storage');
const { Category } = require('../Model/Category');
const { Stock } = require('../Model/Stock');
const { Discount } = require('../Model/Discount');
const Rate = require('../Model/Rate');
const Comment = require('../Model/Comment');
const { StockProduct } = require('../Model/StockProduct');
const router = express.Router();
// router.get('/all/:page',async function(req,res){
//     const page = 1
//     if(!req.params.page){
//         page = req.params.page;
//     }
//     const products = await Product.find().limit(16).skip((page-1)*16)
//     res.status(200).send(products)
// })

router.get('/list/:slug/:page', async function(req, res) {
    let page = 1;
    let count = 0
    page = req.params.page
    let products = null;
    if (req.params.slug.localeCompare('all') == 0) {
        products = await Product.find({ status: "Đang bán" })
        .sort({ '_id': -1 }).limit(16).skip((page - 1) * 16).populate('size', ['name', 'description'])
        .populate('color', ['name']);
        count = await Product.countDocuments({ status: "Đang bán" });
    } else {
        const cate = await Category.findOne({ slug: req.params.slug });
        products = await Product.find({ id_cate: cate._id, status: "Đang bán" })
        .sort({ '_id': -1 }).limit(16).skip((page - 1) * 16).populate('size', ['name', 'description'])
        .populate('color', ['name']);
        count = await Product.countDocuments({ id_cate: cate._id, status: "Đang bán" });
    }
    if (count !== 0) {
        count = parseInt((count - 1) / 16) + 1;
    }
    res.status(200).send({ products: products, count: count })
})
router.get('/count/:slug', async function(req, res) {
    const sl = req.params.slug;
    let pages = 0
    let count = 0
    try {
        if (sl.localeCompare('all') == 0) {
            count = await Product.countDocuments();
        } else {
            const cate = await Category.findOne({ slug: sl });
            count = await Product.countDocuments({ id_cate: cate._id });
        }
        if (count !== 0) {
            pages = parseInt((count - 1) / 16) + 1

        }
    } catch (e) {
        logger.info(e);
        logger.error(e);
        res.send(e);
    }
})

router.post('/search/:slug/:page/:sort', async function(req, res) {
    const search = req.body.search;
    const sl = req.params.slug;
    let page = req.params.page
    let products = undefined;
    let sortType = { _id: -1 }
    if (req.params.sort == 2) { sortType = { _id: 1 } }
    if (req.params.sort == 3) { sortType = { price: -1 } }
    if (req.params.sort == 4) { sortType = { price: 1 } }
    if (req.params.sort == 5) { sortType = { name: -1 } }
    if (req.params.sort == 6) { sortType = { name: 1 } }
    let count = 0;
    try {
        if (sl.localeCompare('all') == 0) {
            console.log('11')
            products = await Product.find({ "status": "Đang bán", "name": { "$regex": search, "$options": "i" } })
            .sort(sortType).limit(16).skip((page - 1) * 16)
            .populate('size', ['name', 'description']).populate('color', ['name']);
            count = await Product.countDocuments({
                "status": "Đang bán",
                "name": {
                    "$regex": search,
                    "$options": "i"
                }
            })
        } else {
            const cate = await Category.findOne({ slug: sl });
            products = await Product.find({
                    "status": "Đang bán",
                    "id_cate": cate._id,
                    "name": { "$regex": search, "$options": "i" }
                }).sort(sortType)
                .limit(16).skip((page - 1) * 16).populate('size', ['name', 'description'])
                .populate('size', ['name', 'description']).populate('color', ['name']);
            count = await Product.countDocuments({
                "status": "Đang bán",
                "id_cate": cate._id,
                "name": {
                    "$regex": search,
                    "$options": "i"
                }
            })
        }
        if (count !== 0) count = parseInt((count - 1) / 16) + 1
        return res.status(400).send({ products: products, count: count }, )
    } catch (ex) {
        return res.status(400).send({ message: "error", status: "false" });
    }
})

router.get('/detail/:slug', async function(req, res) {
        let product = undefined;
        let rs = undefined;
        try {
            product = await Product.findOne({ slug: req.params.slug })
            .populate('size', ['name', 'description']).populate('color', ['name'])
            if (!product) return res.status(404).send('Sản phẩm không tồn tại');
            const rs = await StockProduct.find({id_product:product._id}).select(['size','color','number'])
            const rate = await Rate.findOne({ id_product: product._id })
            console.log(rate);

            const comment = await Comment.find({ id_product: product._id }).populate('id_account', ['name'])
            return res.status(200).send({ product: product, rate: rate, comment: comment, number: rs });
        } catch (err) {
            return res.status(400).send({message: 'error'})
        }
    })
    router.get('/wish-list/:page', async function(req,res){
        let products = undefined;
        const page = req.params.page
        try{
            const products = await Rate.find({rate : { $gte: 4 }}).sort({rate:1}).
            limit(16).skip((page-1)*16).populate({path:'id_product',select: ['name','price','urlImage',
            'status','slug','sold','description', 'discount','size','color']})
            .populate('id_product.size',['name']).populate('id_product.color',['name']);
            res.status(200).send({message:'success',products:products})
        }catch(err){
            res.status(400).send({message:'error'})
            console.log(err)
        }
})
router.get('/search/:slug/:search/:page', async function(req, res) {
    const page = req.params.page;
    const slug = req.params.slug;
    const search = req.params.search;
    let count = 0
    try {
        let products = undefined;
        if (slug.localeCompare('all') == 0) {
            products = await Product.find({ name: { $regex: '.*' + search + '.*', $options: 'i' }, status:"Đang bán" }).limit(16).skip((page - 1) * 16)
            count = await Product.countDocuments({ name: { $regex: '.*' + search + '.*', $options: 'i' } })
        } else {
            console.log(search);
            const cate = await Category.findOne({ slug: req.params.slug })
            products = await Product.find({ id_cate: cate._id, name: { $regex: '.*' + search + '.*', $options: 'i' },status:"Đang bán" }).limit(16).skip((page - 1) * 16)
        }
        if(count > 0){ count = parseInt(count -1)/16 + 1}
        res.status(200).send({products: products,count:1})
    } catch (ex) {
        res.status(400).send({ message: 'error' })
    }
})
// router.get('/number/:idproduct',async function(req,res){
//     try{
//         const stock = (await Stock.findOne({receive: {$elemMatch: {id_product: req.params.idproduct}}})).receive;
//         const rs = stock.filter(stock => stock.id_product == req.params.idproduct)[0].receive;
//         // const nb = rs.filter(rs => rs.size == '635000d3c91b810653035906' & rs.color == '63500315c91b810653035912')[0].number;
//         res.send({number: rs});
//     }catch(err){


//     }
// })
module.exports = router;