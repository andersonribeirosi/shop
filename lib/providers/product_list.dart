import 'dart:math';

import 'package:coder_shop/data/dummy_data.dart';
import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId
            ? data['id'] as String
            : Random().nextDouble().toString() as String,
        description: data['description'] as String,
        name: data['name'] as String,
        imageUrl: data['imageUrl'] as String,
        price: data['price'] as double);

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((i) => i.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

//   import 'package:coder_shop/data/dummy_data.dart';
// import 'package:coder_shop/models/product.dart';
// import 'package:flutter/material.dart';

// class ProductList with ChangeNotifier {
//   List<Product> _items = dummyProducts;
//   bool _showFavoriteOnly = false;

//   List<Product> get items {
//     if (_showFavoriteOnly) {
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }

//   void addProduto(Product product) {
//     _items.add(product);
//     notifyListeners();
//   }
// }
