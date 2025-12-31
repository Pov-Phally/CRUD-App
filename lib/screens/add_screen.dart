import 'package:flutter/material.dart';
import 'package:full_crud_app/validators/product_validator.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => ProductValidator.productName(v),
                controller: nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) => ProductValidator.productPrice(v),
                controller: priceController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (v) => ProductValidator.productStock(v),
                controller: stockController,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: prov.loading ? null : _submit,
                child: Text(prov.loading ? 'Saving...' : 'Create'),
              ),
              if (prov.error != null)
                Text(prov.error!, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final p = Product(
      name: nameController.text.trim(),
      price: double.parse(priceController.text.trim()),
      stock: int.parse(stockController.text.trim()),
    );
    await context.read<ProductProvider>().createProduct(p);
    Navigator.pop(context);
  }
}