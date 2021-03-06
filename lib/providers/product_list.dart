import 'dart:convert';
import 'dart:math';

import 'package:coder_shop/exceptions/http_exception.dart';
import 'package:coder_shop/models/product.dart';
import 'package:coder_shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  ProductList([this._token = '', this._userId = '', this._items = const []]);

  Future<void> loadProducts() async {
    _items.clear();
    
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=${_token}'),
    );

    // final favResponse = await http.get(Uri.parse('${Constants.FAVORITES_URL}/$_userId.json?auth=${_token}'));

        final favResponse = await http.get(
      Uri.parse(
        '${Constants.FAVORITES_URL}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData = favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    print('FAVORITOS ${favResponse.body}');

    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          imageUrl: productData['imageUrl'],
          price: productData['price'],
          isFavorite: isFavorite
          // isFavorite: productData['isFavorite'],
        ),
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
    // ?? necess??rio colocar .jon depois da barra, junto com o nome que deseja para salvar a cole????o - Ex: /products.json
    final response = await http.post(
        Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=${_token}'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          // "isFavorite": product.isFavorite,
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
      await http.patch(
          Uri.parse(
              '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=${_token}'),
          body: jsonEncode({
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl
          }));

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere(
        (i) => i.id == product.id); // Testa se o elemento est?? contido na lista

    if (index >= 0) {
      final product = _items[index];
      // _items.removeWhere((p) => p.id == product.id);
      _items.remove(product);
      notifyListeners();

      // await http.delete(Uri.parse('$_baseUrl/${product.id}.json'));
      final response = await http.delete(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=${_token}'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
            msg: 'N??o foi poss??vel excluir o produto',
            statusCode: response.statusCode);
      }
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
