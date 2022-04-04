import 'package:components/global/base_global.dart';
import 'package:components/navigation/navigation_extension.dart';
import 'package:flutter/material.dart';

class NavigationHandler {
  static Future<T?> push<T extends Object?>(
    Widget widget, {
    bool maintainState = true,
    bool fullscreenDialog = false,
    RoutePushStyle? pushStyle,
    RouteSettings? settings,
  }) =>
      BaseGlobal().globalNavigatorKey.currentState!.push(widget.buildPageRoute(
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          context: BaseGlobal().globalNavigatorKey.currentState!.context,
          settings: settings,
          pushStyle: pushStyle ?? BaseGlobal().pushStyle));

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
          Widget widget,
          {bool maintainState = true,
          bool fullscreenDialog = false,
          RoutePushStyle? pushStyle,
          RouteSettings? settings,
          TO? result}) =>
      BaseGlobal().globalNavigatorKey.currentState!.pushReplacement(
          widget.buildPageRoute(
              settings: settings,
              context: BaseGlobal().globalNavigatorKey.currentState!.context,
              maintainState: maintainState,
              fullscreenDialog: fullscreenDialog,
              pushStyle: pushStyle ?? BaseGlobal().pushStyle),
          result: result);

  static Future<T?> pushAndRemoveUntil<T extends Object?>(Widget widget,
          {bool maintainState = true,
          bool fullscreenDialog = false,
          RoutePushStyle? pushStyle,
          RouteSettings? settings,
          RoutePredicate? predicate}) =>
      BaseGlobal().globalNavigatorKey.currentState!.pushAndRemoveUntil(
          widget.buildPageRoute(
              settings: settings,
              maintainState: maintainState,
              fullscreenDialog: fullscreenDialog,
              context: BaseGlobal().globalNavigatorKey.currentState!.context,
              pushStyle: pushStyle ?? BaseGlobal().pushStyle),
          predicate ?? (_) => false);

  static Future<bool> maybePop<T extends Object>([T? result]) =>
      BaseGlobal().globalNavigatorKey.currentState!.maybePop<T>(result);

  static void pop<T extends Object>([T? result]) =>
      BaseGlobal().globalNavigatorKey.currentState!.pop<T>(result);

  static void popBack(Future<dynamic> navigator,
      {bool nullBack = false, bool useMaybePop = false}) {
    navigator
      ..then((dynamic value) {
        if (nullBack) {
          useMaybePop ? maybePop(value) : pop(value);
        } else {
          if (value != null) {
            useMaybePop ? maybePop(value) : pop(value);
          }
        }
      });
  }

  static void popUntil(RoutePredicate predicate) =>
      BaseGlobal().globalNavigatorKey.currentState!.popUntil(predicate);
}
