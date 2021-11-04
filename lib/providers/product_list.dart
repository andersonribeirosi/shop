import 'dart:convert';
import 'dart:math';

import 'package:coder_shop/data/dummy_data.dart';
import 'package:coder_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _url =
      'https://coder-shop-firebase-default-rtdb.firebaseio.com/products.json';
  // List<Product> _items = dummyProducts;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse(_url));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            price: productData['price']),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId
            ? data['id'] as String
            : Random().nextDouble().toString() as String,
        description: data['description'] as String,
        name: data['name'] as String,
        imageUrl: data['imageUrl'] as String,
        price: data['price'] as double);

    if (!hasId) {
      return addProduct(product);
    } else {
      return updateProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    // É necessário colocar .jon depois da barra, junto com o nome que deseja para salvar a coleção - Ex: /products.json
    final response = await http.post(Uri.parse(_url),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "isFavorite": product.isFavorite,
          "imageUrl": product.imageUrl
        }));

// name: retorno do ID que vem do firebase
    final id = jsonDecode(response.body)['name'];

    _items.add(
      Product(
          id: id,
          name: product.name,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price),
    );

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((i) => i.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return await Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere(
        (i) => i.id == product.id); // Testa se o elemento está contido na lista

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
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
