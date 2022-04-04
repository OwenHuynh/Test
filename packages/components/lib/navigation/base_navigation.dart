import 'package:components/global/base_global.dart';
import 'package:components/navigation/navigation_extension.dart';
import 'package:flutter/material.dart';

class BaseNavigation {
  static Future<T?> push<T extends Object?>(
    Widget widget, {
    bool maintainState = true,
    bool fullscreenDialog = false,
    RoutePushStyle? pushStyle,
    RouteSettings? settings,
  }) =>
      BaseGlobal().globalNavigatorKey.currentState!.push(
          widget.buildPageRoute(
              maintainState: maintainState,
              fullscreenDialog: fullscreenDialog,
              context: BaseGlobal().globalNavigatorKey.currentState!.context,
              settings: settings,
              pushStyle: pushStyle ?? BaseGlobal().pushStyle));
}
