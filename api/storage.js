const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');

cloudinary.config({
    cloud_name: "dw4h0fvg5",
    api_key: "643416143133947",
    api_secret: "h7eMQ8P4nnRLLet7qmhA132U7so"
});



module.exports = cloudinary;