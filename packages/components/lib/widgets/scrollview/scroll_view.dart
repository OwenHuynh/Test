import 'package:components/global/base_global.dart';
import 'package:components/utils/event.dart';
import 'package:components/widgets/scrollview/over_scroll_behavior.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
export 'sliver/sliver.dart';

const String refreshEvent = 'refreshEvent';

class RefreshScrollView extends ScrollView {
  RefreshScrollView({
    this.refreshConfig,
    bool? noScrollBehavior = false,
    this.padding,
    Key? key,
    Axis? scrollDirection = Axis.vertical,
    bool? reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool? shrinkWrap = false,
    Key? center,
    double anchor = 0.0,
    double? cacheExtent,
    this.slivers = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior? dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip? clipBehavior = Clip.hardEdge,
    ScrollBehavior? scrollBehavior,
  })  : noScrollBehavior = noScrollBehavior ?? false,
        super(
            key: key,
            controller: controller,
            scrollDirection: scrollDirection ?? Axis.vertical,
            shrinkWrap: _shrinkWrap(shrinkWrap, physics),
            reverse: reverse ?? false,
            clipBehavior: clipBehavior ?? Clip.hardEdge,
            dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
            cacheExtent: cacheExtent,
            restorationId: restorationId,
            physics: physics,
            primary: primary,
            center: center,
            anchor: anchor,
            scrollBehavior: scrollBehavior,
            semanticChildCount: semanticChildCount,
            keyboardDismissBehavior: keyboardDismissBehavior ??
                ScrollViewKeyboardDismissBehavior.manual);

  static bool _shrinkWrap(bool? shrinkWrap, ScrollPhysics? physics) {
    if (physics == const NeverScrollableScrollPhysics()) {
      return true;
    }
    return shrinkWrap ?? false;
  }

  final List<Widget> slivers;
  final bool noScrollBehavior;
  final EdgeInsetsGeometry? padding;
  final RefreshConfig? refreshConfig;

  @override
  Widget build(BuildContext context) {
    Widget widget = super.build(context);
    if (refreshConfig != null) {
      widget = EasyRefreshed(
          slivers: buildSlivers(context),
          scrollDirection: scrollDirection,
          reverse: reverse,
          scrollController: controller,
          controller: refreshConfig!.controller,
          onLoading: refreshConfig!.onLoading,
          onRefresh: refreshConfig!.onRefresh,
          header: refreshConfig!.header,
          footer: refreshConfig!.footer,
          primary: primary,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior);
    }
    if (padding != null) {
      widget = Padding(padding: padding!, child: widget);
    }
    if (noScrollBehavior) {
      widget = ScrollConfiguration(behavior: NoScrollBehavior(), child: widget);
    }
    return widget;
  }

  @override
  List<Widget> buildSlivers(BuildContext context) => slivers;
}

void sendRefreshType([EasyRefreshType? refresh]) {
  EventBus().emit(_eventName, refresh ?? EasyRefreshType.refreshSuccess);
}

class RefreshConfig {
  RefreshConfig(
      {this.header,
      this.controller,
      this.onRefresh,
      this.onLoading,
      this.footer});

  EasyRefreshController? controller;
  OnRefreshCallback? onRefresh;
  OnLoadCallback? onLoading;
  Header? header;
  Footer? footer;
}

EasyRefreshController? _holdController;

String get _eventName => refreshEvent + _holdController.hashCode.toString();

enum EasyRefreshType {
  refresh,
  refreshSuccess,
  refreshNoMore,
  refreshFailed,
  loading,
  loadingSuccess,
  loadFailed,
  loadNoMore,
}

class EasyRefreshed extends StatefulWidget {
  const EasyRefreshed({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.reverse = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.controller,
    this.onRefresh,
    this.onLoading,
    this.header,
    this.footer,
    required this.slivers,
    this.cacheExtent,
    this.primary,
    this.scrollController,
  }) : super(key: key);

  final EasyRefreshController? controller;
  final OnRefreshCallback? onRefresh;
  final OnLoadCallback? onLoading;
  final Header? header;
  final Footer? footer;
  final List<Widget> slivers;
  final bool reverse;
  final double? cacheExtent;
  final bool? primary;
  final Axis scrollDirection;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final bool shrinkWrap;

  @override
  _EasyRefreshedState createState() => _EasyRefreshedState();
}

class _EasyRefreshedState extends State<EasyRefreshed> {
  late EasyRefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? EasyRefreshController();
  }

  void initEventBus() {
    EventBus().add(_eventName, (dynamic data) {
      if (data != null && data is EasyRefreshType) {
        switch (data) {
          case EasyRefreshType.refresh:
            _holdController!.callRefresh();
            break;
          case EasyRefreshType.refreshSuccess:
            _holdController!.finishRefresh(success: true);
            break;
          case EasyRefreshType.refreshFailed:
            _holdController!.finishRefresh(success: false);
            break;
          case EasyRefreshType.refreshNoMore:
            _holdController!.finishRefresh(success: true, noMore: true);
            break;
          case EasyRefreshType.loading:
            _holdController!.callLoad();
            break;
          case EasyRefreshType.loadingSuccess:
            _holdController!.finishLoad(success: true);
            break;
          case EasyRefreshType.loadFailed:
            _holdController!.finishLoad(success: false);
            break;
          case EasyRefreshType.loadNoMore:
            _holdController!.finishLoad(success: true, noMore: true);
            break;
        }
      }
      EventBus().remove(_eventName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        controller: controller,
        header: widget.header ?? BaseGlobal().globalRefreshHeader,
        footer: widget.footer ?? BaseGlobal().globalRefreshFooter,
        onLoad: widget.onLoading == null
            ? null
            : () async {
                _holdController = controller;
                initEventBus();
                await widget.onLoading!.call();
              },
        onRefresh: widget.onRefresh == null
            ? null
            : () async {
                _holdController = controller;
                initEventBus();
                await widget.onRefresh!.call();
              },
        slivers: widget.slivers,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        scrollController: widget.scrollController,
        primary: widget.primary,
        shrinkWrap: widget.shrinkWrap,
        cacheExtent: widget.cacheExtent,
        dragStartBehavior: widget.dragStartBehavior);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
