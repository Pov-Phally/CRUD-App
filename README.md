# CRUD Backend API

A RESTful backend API that supports **Create, Read, Update, and Delete (CRUD)** operations for products.  
This API is designed to work with a Flutter frontend application.

---

## 🚀 Features

- 📦 Get all products (with pagination)
- 🔍 Get a single product by ID
- ➕ Create a new product
- ✏️ Update an existing product
- 🗑️ Delete a product
- 🌐 JSON-based REST API

---

## 🛠️ Tech Stack

> Adjust this section if your stack is different.

- **Node.js**
- **Express.js**
- **Database** (MongoDB / MySQL / MsSQL )
- **REST API**

---

## 📁 Project Structure (Example)

```

backend/
├── controllers/
├── routes/
├── models/
├── server.js
└── package.json

```

---

## ⚙️ API Base URL

```

[http://localhost:3000](http://localhost:3000)

```

> When used with an Android emulator, the Flutter app accesses this API via:
```

[http://10.0.2.2:3000](http://10.0.2.2:3000)

```

---

## 📌 API Endpoints

### Get All Products (Paginated)
```

GET /products?page=1&limit=10

````

**Response**
```json
[
  {
    "id": 1,
    "name": "Product name",
    "price": 100
  }
]
````

---

### Get Product by ID

```
GET /products/:id
```

**Response**

```json
{
  "id": 1,
  "name": "Product name",
  "price": 100
}
```

---

### Create Product

```
POST /products
```

**Request Body**

```json
{
  "name": "New Product",
  "price": 150
}
```

**Response**

```json
{
  "result": {
    "id": 2,
    "name": "New Product",
    "price": 150
  }
}
```

---

### Update Product

```
PUT /products/:id
```

**Request Body**

```json
{
  "name": "Updated Product",
  "price": 200
}
```

**Response**

```json
{
  "result": {
    "id": 1,
    "name": "Updated Product",
    "price": 200
  }
}
```

---

### Delete Product

```
DELETE /products/:id
```

**Response**

```json
{
  "message": "Product deleted successfully"
}
```

---

## ▶️ Getting Started

### Prerequisites

* Node.js installed
* npm or yarn installed

---

### Installation

1. Clone the repository

```bash
git clone <your-backend-repo-url>
```

2. Navigate to the backend folder

```bash
cd backend
```

3. Install dependencies

```bash
npm install
```

4. Start the server

```bash
npm start
```

The server will run at:

```
http://localhost:3000
```

---

## 🧪 Testing the API

You can test endpoints using:

* Postman
* Insomnia
* curl

Example:

```bash
curl http://localhost:3000/products
```

---

## 🔗 Frontend Integration

This backend is designed to work with the Flutter frontend:

* Base URL in Flutter:

```dart
const String BASE_URL = 'http://10.0.2.2:3000';
```

* Ensure the backend is running **before** launching the Flutter app.

---
Just tell me 👌
```
