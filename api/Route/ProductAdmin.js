const express = require('express');
const { upload } = require('../Config/multer');
const SlugF = require('../Config/slug');
const { Product, validateNewProduct, validateUpdateProduct } = require('../Model/Product');
const cloudinary = require('../Config/storage');
const { Category } = require('../Model/Category');
const auth = require('../middleware/auth');
const { Discount } = require('../Model/Discount');
var schedule = require('node-schedule');
const Rate = require('../Model/Rate');
const { Size } = require('../Model/Size');
const { Color } = require('../Model/Color');

const router = express.Router();

router.post('/insert', async function(req, res) {
    try {
        const { error } = validateNewProduct(req.body);
        if (!error) return res.status(400).send(error.details[0].message)
        const cate = await Category.findById(req.body.id_cate)
        if (!cate) {
            return res.status(404).send('Danh mục không tồn tại')
        }
        const sl = await SlugF(req.body.name, 1)
        let product = new Product({ name: req.body.name, id_cate: req.body.id_cate, slug: sl, price: 0 })
        product = await product.save();
        product.populate('id_cate', ['name']);
        let rate = new Rate({ id_product: product._id })
        rate = await rate.save();
        res.status(200).send({message:'success'});

    } catch (err) {
        res.status(400).send({message:'error'})
    }

})
router.put('/update/:id', async function(req, res) {
    try {
        const { error } = validateUpdateProduct(req.body);
        if (!error) return res.status(400).send(error.details[0].message)
        const cate = await Category.findById(req.body.id_cate)
        if (!cate) {
            return res.status(404).send('Danh mục không tồn tại')
        }
        const sl = await SlugF(req.body.name, 1)
        let product = await Product.findByIdAndUpdate(req.params.id, { name: req.body.name, slug: sl, 
            id_cate: req.body.id_cate, description: req.body.description, urlImage: req.body.urlImage, 
            weight: 0.2, price: req.body.price}, 
            { new: true });
        if (!product) return res.status(404).send('Sản phẩm không tồn tại')
        return res.send(product);
    } catch (err) {
        console.log(err);
    }
})
router.post('/sell-product/:id',async function(req,res){
    try {
        let product = await Product.findByIdAndUpdate(req.params.id, {description: req.body.description, urlImage: req.body.urlImage, 
            sellDay: Date.now(), weight: 0.2, price: req.body.price, status: "Đang bán" }, 
            { new: true });
        if (!product) return res.status(404).send('Sản phẩm không tồn tại')
        return res.send(product);
    } catch (err) {
        console.log(err);
    }
})
router.get('/detail/:id', async function(req, res) {
    try {
        const product = await Product.findById(req.params.id).populate('id_cate', ['name'])
        if (!product) return res.status(404).send('Sản phẩm không tồn tại')
        return res.status(200).send(product)
    } catch (err) {
        return res.status(404).send('Sản phẩm không tồn tại');
    }
})

router.delete('/delete/:id', async function(req, res) {
    try {
        const product = await Product.findById(req.params.id);
        if (!product) {
            return res.status(404).send('Sản phẩm không tồn tại');
        }
        if (product.status.localeCompare('Chưa tồn tại') == 0) {
            console.log('1')
            await product.remove();
            return res.status(200).send('Success');
        } else {
            console.log('2')
            product.status = "Ngừng bán"
            await product.save();
            return res.status(200).send('Success')
        }
    } catch (err) {
        return res.status(400).send('Error');
    }
})

router.get('/:slug/:search/:page', async function(req, res) {
    const page = req.params.page;
    const slug = req.params.slug;
    const search = req.params.search;
    let count = 0
    try {
        let products = undefined;
        if (slug.localeCompare('all') == 0) {
            products = await Product.find({ name: { $regex: '.*' + search + '.*', $options: 'i' } }).limit(16).skip((page - 1) * 16)
            count = await Product.countDocuments({ name: { $regex: '.*' + search + '.*', $options: 'i' } })
        } else {
            console.log(search);
            const cate = await Category.findOne({ slug: req.params.slug })
            products = await Product.find({ id_cate: cate._id, name: { $regex: '.*' + search + '.*', $options: 'i' } }).limit(16).skip((page - 1) * 16)
        }
        if(count > 0){ count = parseInt(count -1)/6 + 1}
        res.status(200).send({product: products,count:1})
    } catch (ex) {
        res.status(400).send({ message: 'error' })
    }
})
router.get('/:slug/:page', async function(req, res) {
    const page = req.params.page;
    const slug = req.params.slug;
    let count = 0;
    try {
        let products = undefined;
        if (slug.localeCompare('all') == 0) {
            products = await Product.find().limit(10).skip((page - 1) * 10).select({
                name: 1,
                status: 1,
                sold: 1,
                id_cate: 1,
                price: 1
            }).populate('id_cate', ['name']).sort({ '_id': -1 });
            count = await Product.countDocuments();
        } else {
            const cate = await Category.findOne({ slug: req.params.slug })
            products = await Product.find({ id_cate: cate._id }).limit(10).skip((page - 1) * 10).sort({ '_id': -1 });
            count = await Product.countDocuments({ id_cate: cate._id });
        }
        count = parseInt((count - 1) / 10) + 1
        res.send({ products: products, count: count })

    } catch (ex) {
        res.status(400).send({ message: 'error' })
    }
})
// router.get('/:slug/:page', async function(req, res) {
//     const page = req.params.page;
//     const slug = req.params.slug;
//     try {
//         let products = undefined;
//         if (slug.localeCompare('all') == 0) {
//             products = await Product.find().limit(16).skip((page - 1) * 16).populate('id_cate', ['name']).sort({ '_id': -1 });
//         } else {
//             const cate = await Category.findOne({ slug: req.params.slug })
//             products = await Product.find({ id_cate: cate._id }).limit(16).skip((page - 1) * 16).sort({ '_id': -1 })
//         }
//         res.send(products)
//     } catch (ex) {
//         res.status(404).send('Not availble')
//     }
// })

router.post('/discount', async function(req, res) {
        try {
            let dc = new Discount({ percent: req.body.percent, id_product: req.body.id_product, time: req.body.time });
            dc = await dc.save();
            dc.id_product.map(async function(element) {
                console.log(element);
                return await Product.findByIdAndUpdate(element, { discount: req.body.percent })
            })
            res.status(200).send(dc);
        } catch (e) {
            res.status(400).json({
                message: 'Something went wrong!',
                token: "",
                status: false
            });
        }
    })
    // router.get('/discount/:id',async function(req,res){
    //         const dc = Discount.findOne({id_product: {"$in": req.params.id}})
    //         console.log(dc.percent);
    // })
router.get('/properties',async function getAllSize(req,res){
    try{
        const size = await Size.find({})
        const color = await Color.find({})
        res.status(200).send({size:size,color:color})
    }catch(ex){
        res.status(400).send({message:'error'})
    }
})

module.exports = router;