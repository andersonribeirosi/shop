import 'dart:convert';

import 'package:coder_shop/exceptions/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlFragment}?key=AIzaSyAadugr86wrJEl2JinmutR2KHGxDVYhkMM';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    final body = json.decode(response.body);

    if(body['error'] != null){
      throw AuthException(key: body['error']['message']);
    }

    print(body);
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
