import 'dart:math' as math;

import 'package:components/widgets/scrollview/sliver/way.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SliverWaterfallFlow extends StatelessWidget {
  const SliverWaterfallFlow(
      {Key? key,
      this.itemBuilder,
      this.itemCount,
      this.findChildIndexCallback,
      this.semanticIndexCallback,
      this.addAutomaticKeepALives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.maxCrossAxisExtent,
      this.crossAxisCount,
      this.placeholder = const PlaceholderChild()})
      : assert(maxCrossAxisExtent != null || crossAxisCount != null),
        aligned = false,
        children = null,
        super(key: key);

  const SliverWaterfallFlow.count(
      {Key? key,
      this.children,
      this.semanticIndexCallback,
      this.addAutomaticKeepALives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.maxCrossAxisExtent,
      this.crossAxisCount,
      this.placeholder = const PlaceholderChild()})
      : assert(maxCrossAxisExtent != null || crossAxisCount != null),
        aligned = false,
        itemBuilder = null,
        itemCount = null,
        findChildIndexCallback = null,
        super(key: key);

  const SliverWaterfallFlow.aligned(
      {Key? key,
      // ignore: tighten_type_of_initializing_formals
      this.itemBuilder,
      this.itemCount,
      this.findChildIndexCallback,
      this.semanticIndexCallback,
      this.addAutomaticKeepALives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.mainAxisSpacing = 0,
      this.maxCrossAxisExtent,
      this.crossAxisSpacing = 0,
      this.crossAxisCount,
      this.placeholder = const PlaceholderChild()})
      : assert(maxCrossAxisExtent != null || crossAxisCount != null),
        assert(itemBuilder != null),
        children = null,
        aligned = true,
        super(key: key);

  final ChildIndexGetter? findChildIndexCallback;
  final SemanticIndexCallback? semanticIndexCallback;
  final bool addAutomaticKeepALives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final List<Widget>? children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? maxCrossAxisExtent;
  final int? crossAxisCount;
  final Widget placeholder;
  final bool aligned;

  @override
  Widget build(BuildContext context) {
    late Widget current = SliverToBoxAdapter(child: placeholder);
    SliverChildDelegate? delegate;
    SliverSimpleGridDelegate? gridDelegate;
    if (maxCrossAxisExtent != null) {
      gridDelegate = SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent!);
    } else if (crossAxisCount != null) {
      gridDelegate = SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount!);
    }
    if (aligned &&
        itemCount != null &&
        itemCount! > 0 &&
        gridDelegate != null) {
      current = SliverAlignedGrid(
          itemBuilder: itemBuilder!,
          itemCount: itemCount,
          gridDelegate: gridDelegate,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          addAutomaticKeepAlives: addAutomaticKeepALives,
          addRepaintBoundaries: addRepaintBoundaries);
    } else {
      if (itemBuilder != null && itemCount != null && itemCount! > 0) {
        delegate = SliverChildBuilderDelegate(itemBuilder!,
            childCount: itemCount,
            findChildIndexCallback: findChildIndexCallback,
            addAutomaticKeepAlives: addAutomaticKeepALives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback ??
                (Widget _, int localIndex) => localIndex);
      } else if (children != null && children!.isNotEmpty) {
        delegate = SliverChildListDelegate(children!,
            addAutomaticKeepAlives: addAutomaticKeepALives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback ??
                (Widget _, int localIndex) => localIndex);
      }
      if (delegate != null && gridDelegate != null) {
        current = SliverMasonryGrid(
            delegate: delegate,
            gridDelegate: gridDelegate,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing);
      }
    }
    return current;
  }
}

/// [SliverList]、[SliverGrid]、[SliverFixedExtentList]
class SliverListGrid extends StatelessWidget {
  const SliverListGrid({
    Key? key,
    this.crossAxisCount = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.crossAxisFlex = false,
    this.maxCrossAxisExtent = 10,
    this.mainAxisExtent,
    this.itemBuilder,
    this.itemCount,
    this.separatorBuilder,
    this.findChildIndexCallback,
    this.semanticIndexCallback,
    this.itemExtent,
    this.addAutomaticKeepALives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.placeholder = const PlaceholderChild(),
    this.prototypeItem,
  })  : assert(itemBuilder != null && itemCount != null),
        children = null,
        super(key: key);

  const SliverListGrid.count({
    Key? key,
    this.crossAxisCount = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.crossAxisFlex = false,
    this.maxCrossAxisExtent = 10,
    this.mainAxisExtent,
    // ignore: tighten_type_of_initializing_formals
    this.children,
    this.semanticIndexCallback,
    this.addAutomaticKeepALives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.placeholder = const PlaceholderChild(),
    this.prototypeItem,
    this.itemExtent,
  })  : assert(children != null),
        itemBuilder = null,
        itemCount = null,
        separatorBuilder = null,
        findChildIndexCallback = null,
        super(key: key);

  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool crossAxisFlex;
  final double maxCrossAxisExtent;
  final double? mainAxisExtent;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final IndexedWidgetBuilder? separatorBuilder;
  final List<Widget>? children;
  final Widget? prototypeItem;
  final double? itemExtent;
  final ChildIndexGetter? findChildIndexCallback;
  final SemanticIndexCallback? semanticIndexCallback;
  final bool addAutomaticKeepALives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    late Widget current = SliverToBoxAdapter(child: placeholder);
    late SliverChildDelegate delegate;
    if (itemBuilder != null && itemCount != null && itemCount! > 0) {
      int childCount = itemCount!;
      IndexedWidgetBuilder item = itemBuilder!;
      if (separatorBuilder != null) {
        item = (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          Widget? widget;
          if (index.isEven) {
            widget = itemBuilder!(context, itemIndex);
          } else {
            widget = separatorBuilder!(context, itemIndex);
            assert(() {
              if (widget == null) {
                throw FlutterError('separatorBuilder cannot return null.');
              }
              return true;
            }());
          }
          return widget;
        };
        childCount = _computeActualChildCount(itemCount!);
      }
      delegate = SliverChildBuilderDelegate(item,
          childCount: childCount,
          findChildIndexCallback: findChildIndexCallback,
          addAutomaticKeepAlives: addAutomaticKeepALives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback ??
              (Widget _, int localIndex) => localIndex);
    } else if (children != null && children!.isNotEmpty) {
      delegate = SliverChildListDelegate(children!,
          addAutomaticKeepAlives: addAutomaticKeepALives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback ??
              (Widget _, int localIndex) => localIndex);
    } else {
      return current;
    }
    if (crossAxisCount > 1 || crossAxisFlex) {
      current = SliverGrid(
          delegate: delegate,
          gridDelegate: crossAxisFlex
              ? SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: mainAxisExtent,
                  mainAxisSpacing: mainAxisSpacing,
                  crossAxisSpacing: crossAxisSpacing,
                  childAspectRatio: childAspectRatio,
                  maxCrossAxisExtent: maxCrossAxisExtent)
              : SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: mainAxisSpacing,
                  crossAxisSpacing: crossAxisSpacing,
                  childAspectRatio: childAspectRatio,
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: mainAxisExtent));
    } else {
      if (itemExtent == null && prototypeItem == null) {
        current = SliverList(delegate: delegate);
      } else if (itemExtent != null) {
        current =
            SliverFixedExtentList(delegate: delegate, itemExtent: itemExtent!);
      } else if (prototypeItem != null) {
        current = SliverPrototypeExtentList(
            delegate: delegate, prototypeItem: prototypeItem!);
      }
    }
    return current;
  }

  int _computeActualChildCount(int itemCount) => math.max(0, itemCount * 2 - 1);
}
