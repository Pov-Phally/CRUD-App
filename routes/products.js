const express = require("express");
const productController = require("../controllers/product");
const { productValidator } = require("../validators/productValidate");

const router = express.Router();

router.get("/", productController.getproducts);
router.get("/:id", productController.getproductbyid);
router.post("/", productValidator, productController.createproduct);
router.put("/:id", productValidator, productController.updateproduct);
router.delete("/:id", productController.deleteproduct);

module.exports = router;
