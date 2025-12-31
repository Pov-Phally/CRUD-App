import 'package:flutter/material.dart';
import 'package:full_crud_app/validators/product_validator.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({super.key, required this.product});
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String name = '';
  late String price = '';
  late String stock = '';

  @override
  void initState() {
    super.initState();
    name = widget.product.name;
    price = widget.product.price.toString();

    stock = widget.product.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => ProductValidator.productName(v),
                onChanged: (v) => name = v,
              ),
              TextFormField(
                initialValue: price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) => ProductValidator.productPrice(v),
                onChanged: (v) => price = v,
              ),
              TextFormField(
                initialValue: stock,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (v) => ProductValidator.productStock(v),
                onChanged: (v) => stock = v,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: prov.loading ? null : _submit,
                child: Text(prov.loading ? 'Saving...' : 'Save'),
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
      name: name.trim(),
      price: double.parse(price.trim()),
      stock: int.parse(stock.trim()),
    );
    await context.read<ProductProvider>().updateProduct(widget.product.id, p);
    Navigator.pop(context);
  }
}