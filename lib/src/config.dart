import 'package:shared_preferences/shared_preferences.dart';

import 'token.dart';

class Brontosaurus {
  static final Brontosaurus _instance = Brontosaurus();

  static Brontosaurus instance() {
    return _instance;
  }

  static Future<bool> init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String raw = preferences.getString('brontosaurus-token');
    if (raw == null) {
      return false;
    }
    if (instance().setRawToken(raw).validate()) {
      return true;
    }
    return false;
  }

  static Future<void> store(String raw) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('brontosaurus-token', raw);
  }

  static Future<void> reset() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('brontosaurus-token');
    instance().removeToken();
  }

  static Token ensure(void Function() ifNotValid) {
    if (Brontosaurus.validateToken()) {
      final Token token = _instance._getToken();
      return token;
    }
    ifNotValid();
    return null;
  }

  static bool validateToken() {
    final Token token = _instance._getToken();
    if (token == null) {
      return false;
    }
    if (!token.validate()) {
      return false;
    }
    return true;
  }

  Token _token;

  Brontosaurus setRawToken(String raw) {
    final Token token = Token.create(raw);
    _token = token;
    return this;
  }

  Brontosaurus setToken(Token token) {
    _token = token;
    return this;
  }

  Brontosaurus removeToken() {
    _token = null;
    return this;
  }

  Token _getToken() {
    return _token;
  }

  bool validate() {
    if (_token == null) {
      return false;
    }
    if (!_token.validate()) {
      return false;
    }
    return true;
  }
}
