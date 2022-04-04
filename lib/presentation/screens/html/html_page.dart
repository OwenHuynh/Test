import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portal/application/application.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HTMLPage extends HookWidget {
  HTMLPage({Key? key, required this.appBarTitle, required this.contentHTML})
      : super(key: key);
  final String appBarTitle;
  final String contentHTML;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBarText(appBarTitle),
        body: SafeArea(
            child: WebView(
          initialUrl: Uri.dataFromString(contentHTML,
                  mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
              .toString(),
        )));
  }
}
