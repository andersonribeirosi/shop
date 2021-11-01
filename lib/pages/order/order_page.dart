import 'package:coder_shop/components/drawer.dart';
import 'package:coder_shop/components/order.dart';
import 'package:coder_shop/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList order = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: order.itemsCount,
          itemBuilder: (ctx, i) => OrderWidget(order: order.items[i])),
    );
  }
}
