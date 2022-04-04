import 'package:flutter/material.dart';
import 'package:portal/shared/utils/utils.dart';

class CustomNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    LoggerUtils.printInfo('[NAVIGATOR - PUSH]: ${route}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    LoggerUtils.printInfo('[NAVIGATOR - POP]: ${route}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    LoggerUtils.printInfo('[NAVIGATOR - REMOVE]: ${route}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    LoggerUtils.printInfo('[NAVIGATOR - REPLACE]: ${newRoute}');
  }
}
