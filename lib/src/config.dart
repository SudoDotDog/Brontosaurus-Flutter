import 'package:shared_preferences/shared_preferences.dart';

import 'token.dart';

class Brontosaurus {
  static final Brontosaurus _instance = Brontosaurus();

  static Brontosaurus instance() {
    return _instance;
  }

  static Future<bool> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String raw = prefs.getString('brontosaurus-token');
    if (raw == null) {
      return false;
    }
    instance().setRawToken(raw);
    return true;
  }

  static Future<void> store(String raw) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('brontosaurus-token', raw);
  }

  static Token ensure(void Function() ifNotValid) {
    if (Brontosaurus.validate()) {
      final Token token = _instance._getToken();
      return token;
    }
    ifNotValid();
    return null;
  }

  static bool validate() {
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

  Token _getToken() {
    return _token;
  }
}
