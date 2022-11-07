// const multer = require('multer');
// const storage = multer.diskStorage({
//     destination: function(req, file, cb) {
//       cb(null, './uploads/');
//     },
//     filename: function(req, file, cb) {
//       cb(null, Date.now() + file.originalname);
//     }
// });
  
// const fileFilter = (req, file, cb) => {
//     // reject a file
//     if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
//       cb(null, true);
//     } else {
//       cb({message:'wrong format'}, false);
//     }
// };
// exports.upload = multer({
//     storage: storage,
//     limits: {
//       fileSize: 1024 * 1024 *25
//     },
//     fileFilter: fileFilter
// });
const express = require("express");
const cloudinary = require("cloudinary").v2;
const { CloudinaryStorage } = require("multer-storage-cloudinary");
const multer = require("multer");

const app = express();

cloudinary.config({
  cloud_name:"dw4h0fvg5",
  api_key: "643416143133947",
  api_secret:"h7eMQ8P4nnRLLet7qmhA132U7so"
});

const storage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    folder: "images",
  },
});

const upload = multer({ storage: storage });
module.exports = upload;
