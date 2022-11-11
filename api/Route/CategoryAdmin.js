const express = require('express');
const mongoose = require('mongoose');
const {cloudinary} = require('../storage');
const upload = require('../multer');

const router = express.Router();
// const auth = require('../middleware/auth');
const CateAdmin = require('../Controller/CateAdmin');
// const CheckRole = require('../middleware/admin');

// // get list category
// router.get('/',auth,CheckRole('readAny','Category'),CateAdmin.GetListCate);
// //get by Id
// router.get('/detail/:id',auth,CheckRole('readAny','Category'),CateAdmin.GetCateDetail);
// // thêm category
// router.post('/insert',auth,CheckRole('createAny','Category'),CateAdmin.InsertCate)
// // update cate
// router.put('/update/:id',auth,CheckRole('updateAny','Category'),CateAdmin.UpdateCate)
// // Delete cate
// router.delete('/delete/:id',auth,CheckRole('deleteAny','Category'),CateAdmin.deleteCate)

// get list category
router.get('/all',CateAdmin.GetListCate);
//get by Id
router.get('/detail/:slug',CateAdmin.GetCateDetail);
// thêm category
router.post('/insert',CateAdmin.InsertCate)
// update cate
router.put('/update/:slug',CateAdmin.UpdateCate)
// Delete cate
router.delete('/delete/:id',CateAdmin.deleteCate)
module.exports = router;