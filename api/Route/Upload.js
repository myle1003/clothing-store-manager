const express = require('express');
const router = express.Router();
const { upload } = require('../Config/multer');
const cloudinary = require('../Config/storage');

router.post('/upload-image',upload.array('image'), async(req,res)=>{
    try{
            const files = req.files;
            const urls = [];
            for (const file of files){
                    const result = await cloudinary.uploader.upload(file.path,{
                    public_id: `${Date.now()}`,
                    resource_type: "auto",
                    folder: "H3M_Store"
                    })
                    urls.push(result.url)
            }
            res.status(200).send(urls);
    }catch(err){
            res.status(400).send('error')
    }
});
module.exports = router;