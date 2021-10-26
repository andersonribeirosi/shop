import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  // final Product product;
  // const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Text('Categorias ${product.id}'),
          Container(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
