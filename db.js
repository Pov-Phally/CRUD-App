const sql = require("mssql");
require("dotenv").config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  options: { encrypt: true, trustServerCertificate: true },
  port: parseInt(process.env.DB_PORT, 10),
};
console.log("Database server:", process.env.DB_SERVER);

async function dbConnection() {
  if (!global.pool) {
    global.pool = await sql.connect(config);
  }
  return global.pool;
}

module.exports = { sql, dbConnection };
