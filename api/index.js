const Joi = require('joi');
require('dotenv').config();
var cors = require('cors')

var express = require('express');
var app = express();
// let corsOptions = {
//   origin : ['http://localhost:3000','http://127.0.0.1:4040','http://localhost:3002'],
// }
app.use(cors())

// app.use(function(req, res, next) {
//   res.header("Access-Control-Allow-Origin", "*");
//   res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//   next();
// });
const mongoose = require('mongoose');
// echo redis errors to the console
const http = require('http').Server(app);
// const cateAdmin = require('./Route/CategoryAdmin');
const productAdmin = require('./Route/ProductAdmin');
const categoryAdmin = require('./Route/CategoryAdmin');
const representAdmin = require('./Route/Representative');
const stockAdmin = require('./Route/StockAdmin');
const supplyAdmin = require('./Route/SupplyAdmin');
const productPublic = require('./Route/ProductPublic');
const address = require('./Route/Address');
const user = require('./Route/User');
const auth = require('./Route/Auth');
const cart = require('./Route/Cart');
const comment = require('./Route/Comment');
const bill = require('./Route/Bill');
const rate = require('./Route/Rate');
const infor = require('./Route/Infor');
const delivery = require('./Route/Delivery');

mongoose.connect('mongodb+srv://pnquang:quang123123a@cluster0.eenmlxn.mongodb.net/?retryWrites=true&w=majority')
    .then(() => console.log('Connected to MongoDB...'))
    .catch(err => console.error('Could not connect to MongoDB...'));
// app.use('/uploads', express.static('uploads'));
app.use(express.json());
// app.use('/api/v1/cms/categories',cateAdmin);
app.use('/api/v1/cms/products', productAdmin);
app.use('/api/v1/cms/categories', categoryAdmin);
app.use('/api/v1/cms/stock', stockAdmin);
app.use('/api/v1/cms/supplies', supplyAdmin);
app.use('/api/v1/cms/deliveries', delivery);
app.use('/api/v1/cms/representatives', representAdmin);
app.use('/api/v1/web/products', productPublic);
app.use('/api/v1/web/address', address);
app.use('/api/v1/web/users', user);
app.use('/api/v1/web/auth', auth);
app.use('/api/v1/web/cart', cart);
app.use('/api/v1/web/comment', comment);
app.use('/api/v1/web/rate', rate);
app.use('/api/v1/web/bill', bill);
app.use('/api/v1/web/infor', infor);

const port = process.env.PORT || 3002;
http.listen(port, () => console.log('Socket listening on port...' + port));