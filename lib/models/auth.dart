import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {

  static final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAadugr86wrJEl2JinmutR2KHGxDVYhkMM';
Future<void> register(String email, String password) async {

  final response = await http.post(Uri.parse(url), body: json.encode({
    'email': email,
    'password': password,
    'returnSecureToken': true
  }));

  print(json.decode(response.body));
}
}