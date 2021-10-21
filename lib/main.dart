import 'package:coder_shop/pages/product_detail_page.dart';
import 'package:coder_shop/pages/products_overview_page.dart';
import 'package:coder_shop/provider/product_list.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'Lato',
          textTheme: const TextTheme(),
        ),
        home: ProductsOverviewPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
        },
      ),
    );
  }
}
