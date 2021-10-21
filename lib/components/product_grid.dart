import 'package:coder_shop/components/product_item.dart';
import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/provider/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    List<Product> loadedProducts = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (_) => loadedProducts[i], // Sem necessidade de criação
        value: loadedProducts[i], // Utiliza um ChangeNotifier já criado anteriormente, e passa apenas os valores direto.
        child: ProductItem(),
      ),
      // ignore: prefer_const_constructors
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
