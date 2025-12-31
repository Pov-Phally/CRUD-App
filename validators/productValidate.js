const { body } = require("express-validator");
exports.productValidator = [
  body("productName").not().isEmpty().withMessage("Product name is required"),
  body("price")
    .not()
    .isEmpty()
    .withMessage("Price is required")
    .custom((value) => {
      if (isNaN(value)) {
        throw new Error("Price must be a number");
      }
      if (value <= 0) {
        throw new Error("Price must be greater than zero");
      }
      return true;
    }),
  body("stock")
    .not()
    .isEmpty()
    .withMessage("Stock is required")
    .custom((value) => {
      if (isNaN(value)) {
        throw new Error("Stock must be a number");
      }
      if (value < 0) {
        throw new Error("Stock must be greater zero");
      }
      return true;
    }),
];
