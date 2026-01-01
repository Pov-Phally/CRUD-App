import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';


enum SortBy { none, priceAsc, priceDesc, stockAsc, stockDesc }

class ProductProvider extends ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _filtered;
  bool loading = false;
  String? error;
  String _query = '';
  SortBy sortBy = SortBy.none;
  Timer? _debounce;
  List<Product> _filtered = [];


  int _page = 1;
  final int _limit = 8;
  bool hasMore = true;

  Future<void> fetchProducts() async {
    if (loading || !hasMore) return;
    loading = true; notifyListeners();
    try {
      final newItems = await ApiService.fetchProducts(page: _page, limit: _limit);
      if (newItems.isEmpty) {
        hasMore = false;
      } else {
        _items.addAll(newItems);
        _applyFilters();
        _page++;
      }
    } catch (e) {
      // handle error
    } finally {
      loading = false; notifyListeners();
    }
  }

  Future<void> refresh() async {
    _items.clear();
    _filtered.clear();
    _page = 1;
    hasMore = true;
    await fetchProducts();

  }

// applyFilters
  void _applyFilters() {
    _filtered = _items.where((product) => product.name.toLowerCase().contains(_query.toLowerCase())).toList();
    switch (sortBy) {
      case SortBy.priceAsc: _filtered.sort((a,b)=>a.price.compareTo(b.price)); break;
      case SortBy.priceDesc: _filtered.sort((a,b)=>b.price.compareTo(a.price)); break;
      case SortBy.stockAsc: _filtered.sort((a,b)=>a.stock.compareTo(b.stock)); break;
      case SortBy.stockDesc: _filtered.sort((a,b)=>b.stock.compareTo(a.stock)); break;
      case SortBy.none: break;
    }
  }
  // searchFilter
  void searchProduct(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _query = query;
      _applyFilters();
      notifyListeners();
    });
  }
  //sort Product
  void sortProduct(SortBy s) {
    sortBy = s;
    _applyFilters();
    notifyListeners();
  }
  //Create Product
  Future<void> createProduct(Product p) async {
    loading = true; notifyListeners();
    try {
      final created = await ApiService.createProduct(p);
      _items.add(created);
      _applyFilters();
    } catch (e) { error = e.toString(); }
    loading = false; notifyListeners();
  }
  //Update Product
  Future<void> updateProduct(int id, Product p) async {
    loading = true; notifyListeners();
    try {
      final updated = await ApiService.updateProduct(id, p);
      final idx = _items.indexWhere((x) => x.id == id);
      if (idx >= 0) _items[idx] = updated;
      _applyFilters();
    } catch (e) { error = e.toString(); }
    loading = false; notifyListeners();
  }
//Delete Product
  Future<void> deleteProduct(int id) async {
    loading = true; notifyListeners();
    try {
      await ApiService.deleteProduct(id);
      _items.removeWhere((x) => x.id == id);
      _applyFilters();
    } catch (e) { error = e.toString(); }
    loading = false; notifyListeners();
  }


}
