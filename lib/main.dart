import 'package:coder_shop/models/cart.dart';
import 'package:coder_shop/pages/auth/auth_or_home.dart';
import 'package:coder_shop/pages/cart/cart_page.dart';
import 'package:coder_shop/pages/order/order_page.dart';
import 'package:coder_shop/pages/product/product_detail_page.dart';
import 'package:coder_shop/pages/product/product_form_page.dart';
import 'package:coder_shop/pages/product/products_page.dart';
import 'package:coder_shop/providers/auth.dart';
import 'package:coder_shop/providers/order_list.dart';
import 'package:coder_shop/providers/product_list.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? []
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous){
            return OrderList(
              auth.token ?? '',
              previous?.items ?? []
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrderPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
