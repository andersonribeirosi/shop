import 'package:coder_shop/pages/auth/auth_page.dart';
import 'package:coder_shop/pages/product/products_overview_page.dart';
import 'package:coder_shop/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    // return auth.isAuth ? ProductsOverviewPage() : AuthPage();

    return FutureBuilder(
        future: auth.tryToLogin(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro'),
            );
          } else {
            return auth.isAuth ? ProductsOverviewPage() : AuthPage();
          }
        });
  }
}
