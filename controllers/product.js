const { dbConnection, sql } = require("../db");
const { validationResult } = require("express-validator");

// GET all products
exports.getproducts = async (req, res) => {
  try {
    const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
    const limit = parseInt(req.query.limit, 10) || 100;
    const offset = (page - 1) * limit;

    const products = await dbConnection();
    const result = await products
      .request()
      .input("limit", sql.Int, limit)
      .input("offset", sql.Int, offset).query(`
        SELECT * FROM dbo.PRODUCTS
        ORDER BY PRODUCTID
        OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;
      `);

    res.status(200).json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get product by ID
exports.getproductbyid = async (req, res) => {
  try {
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) {
      return res.status(400).json({ error: "Invalid ID" });
    }

    const products = await dbConnection();
    const result = await products
      .request()
      .input("id", sql.Int, id)
      .query("SELECT * FROM PRODUCTS WHERE PRODUCTID = @id");

    if (!result.recordset.length) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.status(200).json(result.recordset[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create Product
exports.createproduct = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const messageError = errors.array().map((error) => ({
      field: error.path,
      msg: error.msg,
    }));
    return res.status(400).json({
      messageError,
    });
  }
  try {
    const { productName, price, stock } = req.body;
    const products = await dbConnection();
    const result = await products
      .request()
      .input("name", sql.NVarChar(100), productName)
      .input("price", sql.Decimal(10, 2), price)
      .input("stock", sql.Int, stock).query(`
        INSERT INTO PRODUCTS (PRODUCTNAME, PRICE, STOCK)
        OUTPUT inserted.*
        VALUES (@name, @price, @stock);
      `);

    //return result
    res.status(201).json({
      message: "Product created successfully",
      result: result.recordset[0],
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

//Update Product
exports.updateproduct = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const messageError = errors.array().map((error) => ({
      field: error.path,
      msg: error.msg,
    }));
    return res.status(400).json({
      messageError,
    });
  }
  try {
    const { productName, price, stock } = req.body;
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) {
      return res.status(400).json({ error: "Invalid ID" });
    }
    const products = await dbConnection();
    const result = await products
      .request()
      .input("id", sql.Int, id)
      .input("name", sql.NVarChar(100), productName)
      .input("price", sql.Decimal(10, 2), price)
      .input("stock", sql.Int, stock).query(`
       UPDATE PRODUCTS
    SET PRODUCTNAME=@name, PRICE=@price, STOCK=@stock
        OUTPUT INSERTED.*
        WHERE PRODUCTID=@id
      `);
    if (!result.recordset.length) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.status(200).json({
      message: "Product updated successfully",
      result: result.recordset,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// DELETE products
exports.deleteproduct = async (req, res) => {
  try {
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) {
      return res.status(400).json({ error: "Invalid ID" });
    }

    const products = await dbConnection();
    const result = await products
      .request()
      .input("id", sql.Int, id)
      .query("DELETE FROM PRODUCTS WHERE PRODUCTID=@id");
    if (result.rowsAffected[0] === 0) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.status(200).json({ message: "Product deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
