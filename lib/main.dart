import 'package:coder_shop/pages/counter_page.dart';
import 'package:coder_shop/pages/product_detail_page.dart';
import 'package:coder_shop/pages/products_overview_page.dart';
import 'package:coder_shop/provider/counter.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.portraitUp,
    ]);
    // return CounterProvider(MaterialApp());
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Lato',
        textTheme: const TextTheme(),
      ),
      home: ProductsOverviewPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
        // AppRoutes.COUNTER: (ctx) => CounterPage()
      },
    );
  }
}
