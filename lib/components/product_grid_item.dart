import 'package:coder_shop/models/cart.dart';
import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: Consumer<Product>(
            builder: (ctx, productListen, _) => IconButton(
              color: Colors.deepOrange,
              onPressed: () {
                product.toogleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
          ),
          trailing: IconButton(
            color: Colors.deepOrange,
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} - Adicionado com sucesso!'),
                  // backgroundColor: Theme.of(context).primaryColor,
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    // textColor: Colors.white,
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
