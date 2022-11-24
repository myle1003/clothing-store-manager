const multer = require('multer');
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
      cb(null, './uploads/');
    },
    filename: function(req, file, cb) {
      cb(null, Date.now() + file.originalname);
    }
});
  
const fileFilter = (req, file, cb) => {
    // reject a file
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
      cb(null, true);
    } else {
      cb({message:'wrong format'}, false);
    }
};
exports.upload = multer({
    storage: storage,
    limits: {
      fileSize: 1024 * 1024 *25
    },
    fileFilter: fileFilter
});
