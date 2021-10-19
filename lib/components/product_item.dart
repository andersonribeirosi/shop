import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/pages/product_detail_page.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              // AppRoutes.PRODUCT_DETAIL,
              AppRoutes.COUNTER,
              arguments: product
            );
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailPage(product: product),
            //   ),
            // );
          },
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
          leading: IconButton(
            color: Colors.deepOrange,
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          trailing: IconButton(
            color: Colors.deepOrange,
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
