const Joi = require('joi');
require('dotenv').config();
var cors = require('cors')

var express = require('express');
var app = express();
app.use(cors())

const productAdmin = require('./Route/ProductAdmin');
const productPublic = require('./Route/ProductPublic');
const categoryAdmin = require('./Route/CategoryAdmin');
const comment = require('./Route/Comment');
const rate = require('./Route/Rate');
const user = require('./Route/User');
const auth = require('./Route/Auth');
const staff = require('./Route/Staff');
const blacklist = require('./Route/BlackList');
const supplyAdmin = require('./Route/SupplyAdmin');
const address = require('./Route/Address');
const cart = require('./Route/Cart');
const bill = require('./Route/Bill');
const infor = require('./Route/Infor');
const delivery = require('./Route/Delivery');
const inforAddress = require('./Route/InforAddress');
const paymentMethod = require('./Route/PaymentMethod');
const upload = require('./Route/Upload');

const mongoose = require('mongoose');
const http = require('http').Server(app);




mongoose.connect('mongodb+srv://pnquang:quang123123a@cluster0.eenmlxn.mongodb.net/?retryWrites=true&w=majority')
    .then(() => console.log('Connected to MongoDB...'))
    .catch(err => console.error('Could not connect to MongoDB...'));
// app.use('/uploads', express.static('uploads'));
app.use(express.json());

app.use('/api/v1/cms/products', productAdmin);
app.use('/api/v1/web/products', productPublic);
app.use('/api/v1/cms/categories', categoryAdmin);
app.use('/api/v1/web/comment', comment);
app.use('/api/v1/web/rate', rate);
app.use('/api/v1/web/users', user);
app.use('/api/v1/web/auth', auth);
app.use('/api/v1/cms/staff', staff);
app.use('/api/v1/cms/blacklist', blacklist);
app.use('/api/v1/cms/supplies', supplyAdmin);
app.use('/api/v1/cms/deliveries', delivery);
app.use('/api/v1/web/address', address);
app.use('/api/v1/web/cart', cart);
app.use('/api/v1/web/bill', bill);
app.use('/api/v1/web/infor', infor);
app.use('/api/v1/web/inforaddress', inforAddress);
app.use('/api/v1/web', upload);
app.use('/api/v1/web/paymentmethod', paymentMethod);


const port = process.env.PORT || 3002;
http.listen(port, () => console.log('Socket listening on port...' + port));