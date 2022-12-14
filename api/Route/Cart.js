const express = require('express');
const auth = require('../middleware/auth');
const { Cart } = require('../Model/Cart');
const {logger} = require('../logger/logger');

const router = express.Router();
router.get('/', auth, async function(req, res) {
    try {
        let cart = await Cart.findOne({ id_account: req.user.id }).populate('product.id_product', ['name', 'price', 'urlImage', 'discount'])
            .populate('product.color', ['name']).populate('product.size', ['name'])
        let price = 0;
        for (let i = 0; i < cart.product.length; i++) {

            price = price + (cart.product[i].id_product.price * (1 - cart.product[i].id_product.discount / 100)) * cart.product[i].number;

        }
        res.status(200).send({ cart: cart, price: price });
    } catch (e) {
        logger.info(e);
        logger.error(e);
        res.status(200).send({message:'error'})
    }
})

router.post('/insert', auth, async function(req, res) {
    try {
        let cart = await Cart.findOne({ id_account: req.user.id })
        const listPD = cart.product;
        let pd = listPD.filter(listPD => listPD.id_product.toString() === req.body.id_product &
            listPD.size.toString() === req.body.size & listPD.color.toString() === req.body.color);
        if (pd.length == 0) {
            cart.product.push({
                id_product: req.body.id_product,
                color: req.body.color,
                size: req.body.size,
                number: req.body.number
            });
            await cart.save();
        } else {
            let cartupdate = await Cart.updateOne({
                "id_account": req.user.id,
                "product": {
                    "$elemMatch": {
                        "id_product": req.body.id_product,
                        "size": req.body.size,
                        "color": req.body.color
                    }
                }
            }, {
                '$inc': {
                    'product.$.number': req.body.number,
                }
            })
        }
        // const cartAfter = await Cart.findOne({id_user:req.user.id}).populate('product.id_product',['name','price']).populate('product.color',['name']).populate('product.size',['name'])
        res.status(200).send({ message: 'Success' });
    } catch (e) {
        logger.info(e);
        logger.error(e);
        console.log(e)
        res.send(e);
    }
})

router.put('/update', auth, async function(req, res) {
    try {
        let cartupdate = await Cart.updateOne({ "id_account": req.user.id, "product": { "$elemMatch": { "_id": req.body.id } } }, {
            '$set': {
                'product.$.number': req.body.number,
            }
        })
        const cartAfter = await Cart.findOne({ id_account: req.user.id }).populate('product.id_product', ['name', 'price', 'urlImage', 'discount']).populate('product.color', ['name']).populate('product.size', ['name', 'description'])
        let price = 0;
        for (let i = 0; i < cartAfter.product.length; i++) {
            price = price + (cartAfter.product[i].id_product.price * (1 - cartAfter.product[i].id_product.discount / 100)) * cartAfter.product[i].number;
        }
        res.status(200).send({ cart: cartAfter, price: price });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
})
router.delete('/delete/:id', auth, async function(req, res) {
    console.log(req.params.id);
    try {
        let cart = await Cart.updateOne({ "id_account": req.user.id }, {
            $pull: {
                product: { _id: req.params.id },
            }
        })
        const cartAfter = await Cart.findOne({ id_account: req.user.id }).populate('product.id_product', ['name', 'price', 'urlImage', 'discount']).populate('product.color', ['name']).populate('product.size', ['name', 'description'])
        let price = 0;
        for (let i = 0; i < cartAfter.product.length; i++) {
            price = price + (cartAfter.product[i].id_product.price * (1 - cartAfter.product[i].id_product.discount / 100)) * cartAfter.product[i].number;

        }
        res.status(200).send({ cart: cartAfter, price: price });
    } catch (ex) {
        console.log(ex);
    }
})
module.exports = router;