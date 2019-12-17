import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'config.dart';

class BrontosaurusView extends StatefulWidget {
  final String server;
  final String application;
  final void Function() next;

  BrontosaurusView({
    Key key,
    @required this.server,
    @required this.application,
    @required this.next,
  }) : super(key: key);

  @override
  BrontosaurusViewStates createState() {
    return BrontosaurusViewStates();
  }
}

class BrontosaurusViewStates extends State<BrontosaurusView> {
  bool shouldShow = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  final webview = FlutterWebviewPlugin();

  Future<void> _init() async {
    final bool result = await Brontosaurus.init();
    if (!result) {
      webview.onUrlChanged.listen((state) async {
        final bool redirected = state.indexOf(widget.server) == -1;
        if (redirected) {
          webview.close();
          final int startFrom = "js://redirect?token=".length;
          final String raw = state.substring(startFrom);
          Brontosaurus.instance().setRawToken(raw);
          await Brontosaurus.store(raw);
          widget.next();
        }
      });
      setState(() {
        shouldShow = true;
      });
    } else {
      widget.next();
    }
  }

  String _buildUrl() {
    return widget.server + '?key=' + widget.application + '&cb=js://redirect';
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldShow) {
      return Container();
    }
    return WebviewScaffold(
      url: _buildUrl(),
      resizeToAvoidBottomInset: true,
    );
  }
}
