const Joi = require('joi');
require('dotenv').config();
var cors = require('cors')

var express = require('express');
var app = express();
app.use(cors())

const productAdmin = require('./Route/ProductAdmin');
const productPublic = require('./Route/ProductPublic');
const user = require('./Route/User');
const auth = require('./Route/Auth');
const staff = require('./Route/Staff');


const mongoose = require('mongoose');
const http = require('http').Server(app);




mongoose.connect('mongodb+srv://pnquang:quang123123a@cluster0.eenmlxn.mongodb.net/?retryWrites=true&w=majority')
    .then(() => console.log('Connected to MongoDB...'))
    .catch(err => console.error('Could not connect to MongoDB...'));
// app.use('/uploads', express.static('uploads'));
app.use(express.json());

app.use('/api/v1/cms/products', productAdmin);
app.use('/api/v1/web/products', productPublic);
app.use('/api/v1/web/users', user);
app.use('/api/v1/web/auth', auth);
app.use('/api/v1/cms/staff', staff);

const port = process.env.PORT || 3002;
http.listen(port, () => console.log('Socket listening on port...' + port));