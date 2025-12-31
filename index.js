const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

const productsRouter = require("./routes/products");

app.use("/products", productsRouter);

const port = process.env.PORT;
app.listen(port, () => console.log(`http://localhost:${port}`));
