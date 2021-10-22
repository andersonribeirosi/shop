import 'package:coder_shop/components/product_grid.dart';
import 'package:coder_shop/provider/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            elevation: 5,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
            // onSelected: (FilterOptions selectedValue) {
            //   if (selectedValue == FilterOptions.Favorite) {
            //     provider.showFavoriteOnly();
            //   } else {
            //     provider.showAll();
            //   }
            // },
          )
        ],
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
