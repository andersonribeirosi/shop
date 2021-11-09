import 'dart:convert';

import 'package:coder_shop/models/cart.dart';
import 'package:coder_shop/models/cart_item.dart';
import 'package:coder_shop/models/order.dart';
import 'package:coder_shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  String? _token;
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  OrderList(this._token, this._items);

  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}.json?auth=${_token}'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((orderId, orderData) {
      _items.add(Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
                id: item['id'],
                produtId: item['productId'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price']);
          }).toList(),
          date: DateTime.parse(orderData['date'])));
    });

    print(data.toString());
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response =
        await http.post(Uri.parse('${Constants.ORDER_BASE_URL}.json'),
            body: jsonEncode({
              'total': cart.totalAmount,
              'date': date.toIso8601String(),
              'products': cart.items.values
                  .map((cartItem) => {
                        'id': cartItem.id,
                        'productId': cartItem.produtId,
                        'name': cartItem.name,
                        'quantity': cartItem.quantity,
                        'price': cartItem.price
                      })
                  .toList()
            }));

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        // id: Random().nextDouble().toString(),
        id: id,
        date: date,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
