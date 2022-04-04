import 'dart:async';

import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChildHomeViewModel {
  ChildHomeViewModel({
    required this.isLoadingWebView,
    required this.selectedDistrict,
    required this.controller,
    required this.webViewReady,
    required this.onChangedDistrict,
  });

  final ValueNotifier<bool> isLoadingWebView;
  DistrictModel selectedDistrict;
  Completer<WebViewController> controller;
  WebViewController? webViewReady;
  Function(DistrictModel? district) onChangedDistrict;
}
