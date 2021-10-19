import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(product.title),
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
