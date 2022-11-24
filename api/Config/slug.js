const slugify = require('slugify');
const { Category } = require('../Model/Category');
const { Product } = require('../Model/Product');
// const {Post} = require('../model/Post');
// Slugify config options
const options = {
  replacement: '-',
  remove: undefined,
  lower: true,
  strict: false,
  locale: 'en',
  trim: true,
}
async function SlugF(title,check) {
    if(check == 1){
        const nb = await Product.countDocuments()+1;
        return "H3M-san-pham-" + slugify(title, options);
    }else{
        const nb2 = await Category.countDocuments()+1 ;

        return "H3M-danh-muc-" + slugify(title, options);
    }
}
module.exports = SlugF;