import 'token.dart';

class Brontosaurus {
  static final Brontosaurus _instance = Brontosaurus();

  static Brontosaurus instance() {
    return _instance;
  }

  static Token ensure() {
    final Token token = _instance._getToken();
    return token;
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
