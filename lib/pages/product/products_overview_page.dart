// ignore_for_file: prefer_const_constructors

import 'package:coder_shop/components/badge.dart';
import 'package:coder_shop/components/drawer.dart';
import 'package:coder_shop/components/product/product_grid.dart';
import 'package:coder_shop/models/cart.dart';
import 'package:coder_shop/providers/product_list.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<ProductList>(context, listen: false)
        .loadProducts()
        .then((value) => setState(() {
              _isLoading = false;
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // ignore: duplicate_ignore
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
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
                print(_showFavoriteOnly);
              });
            },
          ),
          Consumer<Cart>(
            // child: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(AppRoutes.CART);
            //     },
            //     icon: Icon(
            //       Icons.shopping_cart,
            //       // color: Colors.white,
            //     ),
            //   ),
            builder: (ctx, cart, child) => Badge(
              // child: child!,
              value: cart.itemsCount.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'Minha Loja',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
