library brontosaurus_flutter;

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BrontosaurusView extends StatelessWidget {
  final String server;
  final String application;

  BrontosaurusView({
    @required this.server,
    @required this.application,
  }) {
    _init();
  }

  final webview = FlutterWebviewPlugin();

  void _init() {
    webview.onUrlChanged.listen((state) {
      final bool redirected = state.indexOf(server) == -1;
      if (redirected) {
        print(state);
      }
    });
  }

  String _buildUrl() {
    return server + '?key=' + application + '&cb=js://redirect';
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _buildUrl(),
      resizeToAvoidBottomInset: true,
    );
  }
}
