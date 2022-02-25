import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttermax_state_management_shopapp/models/consts.dart';
import 'package:fluttermax_state_management_shopapp/models/http_exeption.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
      {required String email,
      required String password,
      required String urlSegment}) async {
    final Uri authUri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${Consts.apiKey}');
    try {
      final response = await http.post(authUri,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      // kprint(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        kprint(responseData['error']['message']);
        throw HttpExeption(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (e) {
      kprintError(e);
      rethrow;
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    return _authenticate(
        email: email, password: email, urlSegment: 'signInWithPassword');
  }

  Future<void> signUp({required String email, required String password}) async {
    return _authenticate(email: email, password: email, urlSegment: 'signUp');
  }
}
