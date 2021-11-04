import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/providers/product_list.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
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
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Deseja realmente excluir?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text('Sim'),
                      )
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false)
                    try {
                      await Provider.of<ProductList>(context, listen: false)
                          .removeProduct(product);
                    } catch (error) {
                      msg.showSnackBar(SnackBar(
                        content: Text(error.toString()),
                      ));
                    }
                });
              },
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
