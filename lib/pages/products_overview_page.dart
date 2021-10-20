import 'package:coder_shop/components/product_item.dart';
import 'package:coder_shop/data/dummy_data.dart';
import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Minha Loja',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: ProductGrid(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    List<Product> loadedProducts = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: dummyProducts.length,
      itemBuilder: (ctx, i) => ProductItem(
        product: loadedProducts[i],
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
