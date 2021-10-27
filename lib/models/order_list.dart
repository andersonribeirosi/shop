import 'dart:math';

import 'package:coder_shop/models/cart.dart';
import 'package:coder_shop/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        date: DateTime.now(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
