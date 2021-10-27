import 'package:coder_shop/data/dummy_data.dart';
import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  
  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
