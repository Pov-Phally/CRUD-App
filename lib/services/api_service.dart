import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

const String BASE_URL = 'http://10.0.2.2:3000'; // change to your backend

class ApiService {
  static Future<List<Product>> fetchProducts({int page = 1, int limit = 10}) async {
    final res = await http.get(Uri.parse('$BASE_URL/products?page=$page&limit=$limit'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Failed to load products');
  }

  // static Future<List<Product>> fetchProducts() async {
  //   final res = await http.get(Uri.parse('$BASE_URL/products'));
  //   if (res.statusCode == 200) {
  //     final List data = jsonDecode(res.body);
  //     return data.map((e) => Product.fromJson(e)).toList();
  //   }
  //   throw Exception('Failed to load products');
  // }

  static Future<Product> getProduct(id) async {
    final res = await http.get(Uri.parse('$BASE_URL/products/$id'));
    if (res.statusCode == 200) return Product.fromJson(jsonDecode(res.body));
    throw Exception('Product not found');
  }

  static Future<Product> createProduct(data) async {
    final res = await http.post(Uri.parse('$BASE_URL/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    if (res.statusCode == 201) return Product.fromJson(jsonDecode(res.body)['result']);
    throw Exception('Create failed: ${res.body}');
  }

  static Future<Product> updateProduct(id, data) async {
    final res = await http.put(Uri.parse('$BASE_URL/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final result = body['result'];
      return (result is List) ? Product.fromJson(result.first) : Product.fromJson(result);
    }
    throw Exception('Update failed: ${res.body}');
  }

  static Future<void> deleteProduct( id) async {
    final res = await http.delete(Uri.parse('$BASE_URL/products/$id'));
    if (res.statusCode != 200) throw Exception('Delete failed');
  }
}