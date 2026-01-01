# Flutter CRUD App

A Flutter application that demonstrates **CRUD (Create, Read, Update, Delete)** operations using a REST API backend.

---

## 🚀 Features

- 📦 Fetch paginated products from an API
- ➕ Create new products
- ✏️ Update existing products
- 🗑️ Delete products
- 📱 Works on Android emulator and real devices

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **REST API**
- **http package**

---

## 📁 Project Structure

```

lib/
├── models/
│   └── product.dart
├── services/
│   └── api_service.dart
├── screens/
├── widgets/
└── main.dart

````

---

## 🌐 API Configuration

The API base URL is defined in:

```dart
const String BASE_URL = 'http://10.0.2.2:3000';
````

> `10.0.2.2` allows the Android emulator to access `localhost`.
> Change this URL if you are using a real device or a deployed backend.

---

## 🔧 API Service Overview

The `ApiService` class handles all HTTP requests.

### Fetch Products (with pagination)

```dart
fetchProducts({int page = 1, int limit = 10})
```

### Get a Single Product

```dart
getProduct(int id)
```

### Create a Product

```dart
createProduct(Product data)
```

### Update a Product

```dart
updateProduct(int id, Product data)
```

### Delete a Product

```dart
deleteProduct(int id)
```

---

## ▶️ Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio or VS Code
* A running REST API backend on port `3000`

---

### Installation

1. Clone the repository

```bash
git clone https://github.com/Pov-Phally/CRUD-App.git
```

2. Navigate to the project directory

```bash
cd CRUD-App
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the app

```bash
flutter run
```

---

## 🧪 Backend API Requirements

Your backend should expose the following endpoints:

| Method | Endpoint        | Description       |
| ------ | --------------- | ----------------- |
| GET    | `/products`     | Fetch products    |
| GET    | `/products/:id` | Get product by ID |
| POST   | `/products`     | Create a product  |
| PUT    | `/products/:id` | Update a product  |
| DELETE | `/products/:id` | Delete a product  |

---

