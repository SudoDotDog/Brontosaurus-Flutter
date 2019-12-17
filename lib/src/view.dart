import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'config.dart';

class BrontosaurusView extends StatelessWidget {
  final String server;
  final String application;
  final void Function() next;

  BrontosaurusView({
    Key key,
    @required this.server,
    @required this.application,
    @required this.next,
  }) : super(key: key) {
    _init();
  }

  final webview = FlutterWebviewPlugin();

  void _init() {
    webview.onUrlChanged.listen((state) {
      final bool redirected = state.indexOf(server) == -1;
      if (redirected) {
        webview.close();
        final int startFrom = "js://redirect?token=".length;
        final String raw = state.substring(startFrom);
        Brontosaurus.instance().setRawToken(raw);
        Brontosaurus.store(raw);
        this.next();
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
