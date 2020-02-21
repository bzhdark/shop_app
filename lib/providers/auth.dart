import 'dart:convert';
import '../models/http_exception.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlPiece) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlPiece?key=AIzaSyDiFG6iXUsdrhZHdZTbcpHI4uOBVhCx17g";
    try {
      final res = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final data = json.decode(res.body);
      if (data['error'] != null) {
        throw HttpException(data['error']["message"]);
      }
      print(json.decode(res.body));
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
