import 'package:flutter/material.dart';
import 'package:full_crud_app/screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const ProductListPage(),
      ),
    );
  }
}