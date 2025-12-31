import 'package:flutter/material.dart';
import 'package:full_crud_app/screens/add_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'edit_screen.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _searchCtrl = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final prov = context.read<ProductProvider>();
    prov.refresh();
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent - 200) {
        prov.fetchProducts();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton(
            onSelected: (value) => prov.sortProduct(value),
            itemBuilder: (_) => [
              const PopupMenuItem(value: SortBy.none, child: Text('Default')),
              const PopupMenuItem(value: SortBy.priceAsc, child: Text('Price ↑')),
              const PopupMenuItem(value: SortBy.priceDesc, child: Text('Price ↓')),
              const PopupMenuItem(value: SortBy.stockAsc, child: Text('Stock ↑')),
              const PopupMenuItem(value: SortBy.stockDesc, child: Text('Stock ↓')),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: prov.refresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchCtrl,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search products',border: OutlineInputBorder()),
                onChanged: prov.searchProduct,
              ),
            ),
            if (prov.loading) const LinearProgressIndicator(),
            if (prov.error != null) Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prov.error!, style: const TextStyle(color: Colors.red)),
            ),
            Expanded(
              child: prov.loading && prov.items.isEmpty
                  ? const LinearProgressIndicator() : prov.items.isEmpty && !prov.loading
                  ? const Center(child: Text('No products'))
                  : ListView.builder(
                controller: _controller,
                itemCount: prov.items.length + (prov.hasMore ? 1 : 0),
                itemBuilder: (ctx, i) {
                  if (i < prov.items.length) {
                    final p = prov.items[i];
                    return Card(
                      child: ListTile(
                        title: Text(p.name),
                        subtitle: Text('Price: \$${p.price.toStringAsFixed(2)} • Stock: ${p.stock}'),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (_) => EditProductPage(product: p),
                            )),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _confirmDelete(context, p),
                          ),
                        ]),
                      ),
                    );
                  }else {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductPage())),
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, Product p) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Delete product'),
        content: Text('Delete "${p.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () async {
            Navigator.pop(ctx);
            await ctx.read<ProductProvider>().deleteProduct(p.id);
          }, child: const Text('Delete')),
        ],
      ),
    );
  }
}