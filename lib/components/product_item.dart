import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.favorite),),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
        ),
        
      ),
    );
  }
}
