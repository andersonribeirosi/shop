import 'package:coder_shop/pages/order_page.dart';
import 'package:coder_shop/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo usuário'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            title: Text('Loja'),
            leading: Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          ListTile(
            title: Text('Pedidos'),
            leading: Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          ListTile(
            title: Text('Gerenciador de Produtos'),
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
