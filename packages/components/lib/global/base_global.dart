import 'dart:ui';

import 'package:components/utils/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

enum RoutePushStyle {
  SlideRight,
  SlideLeft,
  SlideRightWithFade,
  SlideLeftWithFade,
  Ripple
}

class BaseGlobal {
  factory BaseGlobal() => _singleton ??= BaseGlobal._();

  BaseGlobal._();

  static BaseGlobal? _singleton;

  WidgetsBinding? widgetsBinding = WidgetsBinding.instance;

  SchedulerBinding? schedulerBinding = SchedulerBinding.instance;

  GlobalKey<NavigatorState> _globalNavigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get globalNavigatorKey => _globalNavigatorKey;

  set globalNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _globalNavigatorKey = navigatorKey;
  }

  GlobalKey<ScaffoldMessengerState>? _globalScaffoldMessengerKey;

  GlobalKey<ScaffoldMessengerState>? get globalScaffoldMessengerKey =>
      _globalScaffoldMessengerKey;

  set globalScaffoldMessengerKey(
      GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey) {
    _globalScaffoldMessengerKey = scaffoldMessengerKey;
  }

  RoutePushStyle _pushStyle = RoutePushStyle.SlideLeft;

  RoutePushStyle get pushStyle => _pushStyle;

  set pushStyle(RoutePushStyle style) {
    _pushStyle = style;
  }

  final EventBus _eventBus = EventBus();

  EventBus get eventBus => _eventBus;

  Header globalRefreshHeader = ClassicalHeader(
    refreshText: 'refresh',
    refreshReadyText: 'refreshReady',
    refreshingText: 'refreshing',
    refreshedText: 'refreshed',
    refreshFailedText: 'refreshFailed',
    noMoreText: 'noMoreText',
  );

  Footer globalRefreshFooter = ClassicalFooter(
    loadText: 'load',
    loadReadyText: 'loadReady',
    loadingText: 'loading',
    loadedText: 'loaded',
    loadFailedText: 'loadFailed',
    noMoreText: 'noMoreText',
  );
}

void addPostFrameCallback(FrameCallback duration) =>
    BaseGlobal().widgetsBinding?.addPostFrameCallback(duration);

void addObserver(WidgetsBindingObserver observer) =>
    BaseGlobal().widgetsBinding?.addObserver(observer);

void removeObserver(WidgetsBindingObserver observer) =>
    BaseGlobal().widgetsBinding?.removeObserver(observer);

void addPersistentFrameCallback(FrameCallback duration) =>
    BaseGlobal().widgetsBinding?.addPersistentFrameCallback(duration);

void addTimingsCallback(TimingsCallback callback) =>
    BaseGlobal().widgetsBinding?.addTimingsCallback(callback);
