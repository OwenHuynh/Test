import 'package:components/components.dart';
import 'package:components/widgets/overlay/overlay.dart';
import 'package:components/widgets/scrollview/scroll_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool scaffoldWillPop = true;

void closeAllOverlay() => ExtendedOverlay().closeAllOverlay();

bool closeOverlay({ExtendedOverlayEntry? entry}) =>
    ExtendedOverlay().closeOverlay(entry: entry);

ExtendedOverlayEntry? showOverlay(Widget widget, {bool autoOff = false}) =>
    ExtendedOverlay().showOverlay(widget, autoOff: autoOff);

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    this.safeLeft = false,
    this.safeTop = false,
    this.safeRight = false,
    this.safeBottom = false,
    this.isStack = false,
    this.isScroll = false,
    this.onWillPopOverlayClose = false,
    this.useSingleChildScrollView = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.appBar,
    this.body,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.drawerEdgeDragWidth,
    this.drawerScrimColor,
    this.onWillPop,
    this.appBarHeight,
    this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.direction = Axis.vertical,
    this.margin,
    this.decoration,
    this.refreshConfig,
    this.restorationId,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.tapOutsideDismissKeyboard = false,
    this.gestures = const [GestureType.onTap],
  }) : super(key: key);
  final List<Widget>? children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final bool isStack;
  final bool isScroll;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final bool onWillPopOverlayClose;
  final WillPopCallback? onWillPop;
  final RefreshConfig? refreshConfig;
  final bool useSingleChildScrollView;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? body;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? appBar;
  final double? appBarHeight;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final DragStartBehavior drawerDragStartBehavior;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final double? drawerEdgeDragWidth;
  final Color? drawerScrimColor;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final List<Widget>? persistentFooterButtons;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final String? restorationId;
  final bool safeLeft;
  final bool safeTop;
  final bool safeRight;
  final bool safeBottom;
  final bool tapOutsideDismissKeyboard;
  final List<GestureType> gestures;

  @override
  Widget build(BuildContext context) {
    final Widget scaffold = Scaffold(
        key: key,
        primary: primary,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: extendBody,
        drawer: drawer,
        endDrawer: endDrawer,
        onDrawerChanged: onDrawerChanged,
        onEndDrawerChanged: onEndDrawerChanged,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        backgroundColor: backgroundColor,
        appBar: appBarFun,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        restorationId: restorationId,
        body: universal);

    final Widget dismissKeyboardScaffold = tapOutsideDismissKeyboard
        ? KeyboardDismiss(
            gestures: gestures,
            child: scaffold,
          )
        : scaffold;

    return onWillPop != null || onWillPopOverlayClose
        ? WillPopScope(
            onWillPop: onWillPop ?? onWillPopFun,
            child: dismissKeyboardScaffold)
        : dismissKeyboardScaffold;
  }

  Future<bool> onWillPopFun() async {
    if (!scaffoldWillPop) {
      return scaffoldWillPop;
    }
    if (onWillPopOverlayClose &&
        ExtendedOverlay().overlayEntryList.isNotEmpty) {
      closeOverlay();
      return false;
    }
    return true;
  }

  PreferredSizeWidget? get appBarFun {
    if (appBar is AppBar && appBarHeight == null) {
      // ignore: cast_nullable_to_non_nullable
      return appBar as AppBar;
    }
    return appBar == null
        ? null
        : PreferredSize(
            preferredSize: Size.fromHeight(
                ScreenUtil.getStatusBarHeight + (appBarHeight ?? 30)),
            child: appBar!);
  }

  BaseWidget get universal => BaseWidget(
      expand: true,
      refreshConfig: refreshConfig,
      margin: margin,
      systemOverlayStyle: systemOverlayStyle,
      useSingleChildScrollView: useSingleChildScrollView,
      padding: padding,
      isScroll: isScroll,
      safeLeft: safeLeft,
      safeTop: safeTop,
      safeRight: safeRight,
      safeBottom: safeBottom,
      isStack: isStack,
      direction: direction,
      decoration: decoration,
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      child: body);
}
