import 'token.dart';

class Brontosaurus {
  static final Brontosaurus _instance = Brontosaurus();

  static Brontosaurus instance() {
    return _instance;
  }

  static Token hard() {
    final Token token = _instance._getToken();
    if (token == null) {
      _instance.executeOut();
      return null;
    }
    if (!token.validate()) {
      _instance.executeOut();
      return null;
    }
    return token;
  }

  static void logout() {
    _instance.executeOut();
    return;
  }

  void Function() _onNavigateOut;
  void Function() _onNavigateIn;
  Token _token;

  Brontosaurus setNavigateOut(void Function() onNavigateOut) {
    _onNavigateOut = onNavigateOut;
    return this;
  }

  Brontosaurus setNavigateIn(void Function() onNavigateIn) {
    _onNavigateIn = onNavigateIn;
    return this;
  }

  void exectueIn() {
    if (_onNavigateIn != null) {
      _onNavigateIn();
    }
  }

  void executeOut() {
    if (_onNavigateOut != null) {
      _onNavigateOut();
    }
  }

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
