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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            // Text('Categorias ${product.id}'),
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'R\$ ${product.price}', style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              // padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Text(product.description, style: TextStyle(fontSize: 20),),
              alignment: Alignment.center,
              // color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
