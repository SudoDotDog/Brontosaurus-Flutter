library brontosaurus_flutter;

class Brontosaurus {
  static final Brontosaurus _instance = Brontosaurus();

  static Brontosaurus instance() {
    return _instance;
  }

  void Function() _onNavigateOut;
  void Function() _onNavigateIn;

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
}
