const express = require("express");
const { Color } = require("../Model/Color");
const { Product } = require("../Model/Product");
const { Size } = require("../Model/Size");
const { Stock } = require("../Model/Stock");
const { StockProduct } = require("../Model/StockProduct");
const { Supply } = require("../Model/Supply");
const router = express.Router();
function checkProduct(id_product, listProduct) {
  if(listProduct.length === 0) return true;
  const check = listProduct.filter((id) => id.toString() === id_product);
  if (check.length === 0) return true;
  return false;
}
async function updateStockProduct(idProduct, size, color, number) {
  let stockProduct = await StockProduct.find({
    id_product: idProduct,
    size: size,
    color: color,
  });
  if (stockProduct.length === 0) {
    stockProduct = new StockProduct({
      id_product: idProduct,
      size: size,
      color: color,
      number: number,
    });
    stockProduct.save()
  } else {
    await StockProduct.findOneAndUpdate(
      { id_product: idProduct, size: size, color: color },
      {
        $inc: { number: number },
      }
    );
  }
}
router.post("/insert", async function (req, res) {
    try {
      let stock = new Stock({
        dateReceive: req.body.dateReceive,
        receive: req.body.receive,
        id_supply: req.body.id_supply,
        status: req.body.status,
        dateCreate: req.body.dateCreate,
        totalPrice: req.body.totalPrice,
      });
      stock = await stock.save();
      let supply = await Supply.findById(req.body.id_supply);
      for (i = 0; i < req.body.receive.length; i++) {
        var arrSize = [];
        var arrColor = [];
        if (checkProduct(req.body.receive[i].id_product, supply.listProduct)) {
          supply.listProduct.push(req.body.receive[i].id_product);
        }
        for (j = 0; j < req.body.receive[i].receive.length; j++) {
          arrSize.push(req.body.receive[i].receive[j].size);
          arrColor.push(req.body.receive[i].receive[j].color);
          await updateStockProduct(
              req.body.receive[i].id_product,
              req.body.receive[i].receive[j].size,
              req.body.receive[i].receive[j].color,
              req.body.receive[i].receive[j].number,
            );
        }
        // const listS = await Size.find({ "_id": { "$in": arrSize } }).select('_id');
        // const listC = await Color.find({ "_id": { "$in": arrColor } }).select('_id');
        insertSizeColorProduct(arrSize, arrColor, req.body.receive[i].id_product);
      }
      await supply.save();
      res.status(200).send({ message: "success" });
    } catch (ex) {
      console.log(ex);
      res.status(400).send({ message: "error" });
    }
  });
async function insertSizeColorProduct(listSize, listColor, idProduct) {
  const product = await Product.findById(idProduct);

  const size = listSize.filter((item) => !product.size.includes(item));
  console.log(size)
  var uniqSize = [ ...new Set(size) ]
  console.log(uniqSize)
  const color = listColor.filter((item) => !product.color.includes(item));
  var uniqColor = [ ...new Set(color) ]
  await Product.findByIdAndUpdate(idProduct, {
    $push: { size: uniqSize, color: uniqColor},
    status:'Chưa bán'
  });
}

router.get("/all/:page", async function (req, res) {
  try {
    const page = req.params.page;
    let stock = await Stock.find({})
      .sort({ dateReceive: -1 })
      .limit(16)
      .skip((page - 1) * 16)
      .populate("id_supply", ["name"])
      .populate("receive.receive.size", ["name"])
      .populate("receive.receive.color", "name")
      .populate("receive.id_product", ["name"]);
    let count = await Stock.countDocuments();
    if (count != 0) {
      count = parseInt((count - 1) / 10) + 1;
    }
    res.status(200).send({ message: "success", stock: stock, count: count });
  } catch (ex) {
    res.status(400).send({ message: "error" });
  }
});
router.get("/supply/:id/:page", async function (req, res) {
  try {
    const page = req.params.page;
    let stock = await Stock.find({ id_supply: req.params.id })
      .sort({ dateReceive: -1 })
      .limit(16)
      .skip((page - 1) * 16)
      .populate("id_supply", ["name"])
      .populate("receive.receive.size", ["name"])
      .populate("receive.receive.color", "name")
      .populate("receive.id_product", ["name"]);
    res.status(200).send({ message: "success", stock: stock });
  } catch (ex) {
    res.status(400).send({ message: "error" });
  }
});
module.exports = router;
