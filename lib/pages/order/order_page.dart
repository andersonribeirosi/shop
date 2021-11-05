import 'package:coder_shop/components/drawer.dart';
import 'package:coder_shop/components/order.dart';
import 'package:coder_shop/providers/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorre um erro!'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => RefreshIndicator(
                onRefresh: () => _refreshOrders(context),
                child: ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => OrderWidget(
                    order: orders.items[i],
                  ),
                ),
              ),
            );
          }
        },
      ),
      // body: _isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     : RefreshIndicator(
      //         onRefresh: () => _refreshOrders(context),
      //         child: ListView.builder(
      //           itemCount: order.itemsCount,
      //           itemBuilder: (ctx, i) => OrderWidget(
      //             order: order.items[i],
      //           ),
      //         ),
      //       ),
    );
  }
}
