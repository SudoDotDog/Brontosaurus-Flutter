import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'config.dart';

class BrontosaurusView extends StatefulWidget {
  final String server;
  final String application;
  final void Function() next;

  final Widget appBar;
  final Widget placeholder;

  BrontosaurusView({
    Key key,
    @required this.server,
    @required this.application,
    @required this.next,
    this.appBar,
    this.placeholder,
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
    final String platform = '${Platform.operatingSystem}@${Platform.version}';

    return widget.server +
        '?key=' +
        widget.application +
        '&cb=js://redirect' +
        '&useragent=Brontosaurus-Flutter' +
        '&platform=$platform';
  }

  bool _isAndroid() {
    return Platform.isAndroid;
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldShow) {
      if (widget.placeholder != null) {
        return widget.placeholder;
      }
      return Container();
    }
    return WebviewScaffold(
      appBar: widget.appBar,
      url: _buildUrl(),
      enableAppScheme: false,
      scrollBar: false,
      resizeToAvoidBottomInset: _isAndroid(),
    );
  }
}
