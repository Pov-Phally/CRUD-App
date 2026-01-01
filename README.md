---

# 📦 CRUD Backend API

A **RESTful backend API** built with **Node.js** and **Express.js** to support Create, Read, Update, and Delete (CRUD) operations for managing products. This backend is designed to work with a frontend app (such as Flutter). ([GitHub][1])

---

## 🚀 Features

✔️ Get all products (with pagination)
✔️ Get a product by ID
✔️ Create a new product
✔️ Update an existing product
✔️ Delete a product
✔️ JSON-based REST API responses

---

## 🛠️ Tech Stack

This project uses:

* **Node.js**
* **Express.js**
* **MySQL** 
* **REST API architecture** ([GitHub][1])

---

## 📁 Project Structure

````
backend/
├── controllers/
├── routes/
├── validators/
├── .env
├── db.js
├── index.js
├── package.json
└── README.md
``` 

---

## 📍 API Base URL

````

[http://localhost:3000](http://localhost:3000)

```

> When used with Android emulators (like Flutter), access via:  
> `http://10.0.2.2:3000`

---

## 📌 API Endpoints

### 🔹 Get All Products (Paginated)

```

GET /products?page=<number>&limit=<number>

````

**Response:**

```json
[
  {
    "id": 1,
    "productName": "Product name",
    "price": 100,
    "stock": 1
  }
]
````

---

### 🔹 Get Single Product

```
GET /products/:id
```

**Response:**

```json
{
  "id": 1,
  "productName": "Product name",
  "price": 100,
  "stock": 1
}
```

---

### 🔹 Create Product

```
POST /products
```

**Request Body:**

```json
{
  "productName": "New Product",
  "price": 150,
  "stock": 1
}
```

**Response:**

```json
{
  "result": {
    "id": 2,
    "productName": "New Product",
    "price": 150,
    "stock": 1
  }
}
```

---

### 🔹 Update Product

```
PUT /products/:id
```

**Request Body:**

```json
{
  "productName": "Updated Product",
  "price": 200,
  "stock": 1
}
```

---

### 🔹 Delete Product

```
DELETE /products/:id
```

**Response:**

```json
{
  "message": "Product deleted successfully"
}
```

---

## 🛠️ Getting Started (Setup)

### 🔹 Prerequisites

* **Node.js** installed on your system
* (Optional) **MySQL** installed and running locally or remotely

### 🔹 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Pov-Phally/CRUD-App.git
   ```

2. Navigate to the backend directory:

   ```bash
   cd CRUD-App/backend
   ```

3. Install dependencies:

   ```bash
   npm install
   ```

4. Create a `.env` file with your database configuration:

   ```
   DB_HOST=<your_host>
   DB_USER=<your_username>
   DB_PASSWORD=<your_password>
   DB_NAME=<your_database_name>
   PORT=3000
   ```

5. Start the server:

   ```bash
   npm start
   ```

Server will run at:

````
http://localhost:3000
---

## 🧪 Testing the API

Use tools like **Postman**, **Insomnia**, or **curl** to test the endpoints:

Example:

```bash
curl http://localhost:3000/products
````

---

[1]: https://github.com/Pov-Phally/CRUD-App/tree/backend "GitHub - Pov-Phally/CRUD-App at backend"
