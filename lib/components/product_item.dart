
import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        backgroundColor: Colors.white,
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
