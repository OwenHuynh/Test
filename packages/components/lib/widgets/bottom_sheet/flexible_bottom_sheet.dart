// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:components/components.dart';
import 'package:components/widgets/bottom_sheet/change_insets_detector.dart';
import 'package:flutter/material.dart';

/// The signature of a method that provides a [BuildContext] and
/// [ScrollController] for building a widget that may overflow the draggable
/// [Axis] of the containing FlexibleDraggableScrollSheet.
///
/// Users should apply the [scrollController] to a [ScrollView] subclass, such
/// as a [SingleChildScrollView], [ListView] or [GridView], to have the whole
/// sheet be draggable.
///
/// [bottomSheetOffset] - fractional value of offset.
typedef FlexibleDraggableScrollableWidgetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
  double bottomSheetOffset,
);

/// The signature of the method that provides [BuildContext]
/// and [bottomSheetOffset] for determining the position of the BottomSheet
/// relative to the upper border of the screen.
/// [bottomSheetOffset] - fractional value of offset.
typedef FlexibleDraggableScrollableHeaderWidgetBuilder = Widget Function(
  BuildContext context,
  double bottomSheetOffset,
);

/// The signature of a method that provides a [BuildContext]
/// and [bottomSheetOffset] for determining the position of the BottomSheet
/// relative to the upper border of the screen.
/// [bottomSheetOffset] - fractional value of offset.
typedef FlexibleDraggableScrollableWidgetBodyBuilder = SliverChildDelegate
    Function(
  BuildContext context,
  double bottomSheetOffset,
);

typedef FlexibleDraggableScrollableBottomWidgetBuilder = Widget Function(
  BuildContext context,
  double bottomSheetOffset,
);

/// Flexible and scrollable bottom sheet.
///
/// This bottom sheet resizing between min and max size, and when size become
/// max start scrolling content. Reduction size available when content
/// scrolled to 0 offset.
///
/// [minHeight], [maxHeight] are limits of
/// bounds this widget. For example:
/// - you can set  [maxHeight] to 1;
/// - you can set [minHeight] to 0.5;
///
/// [isCollapsible] make possible collapse widget and remove from the screen,
/// but you must be carefully to use it, set it to true only if you show this
/// widget with like showFlexibleBottomSheet() case, because it will be removed
/// by Navigator.pop(). If you set [isCollapsible] true, [minHeight]
/// must be 0.
///
/// The [animationController] that controls the bottom sheet's entrance and
/// exit animations.
/// The FlexibleBottomSheet widget will manipulate the position of this
/// animation, it is not just a passive observer.
///
/// [initHeight] - relevant height for init bottom sheet
class FlexibleBottomSheet extends StatefulWidget {
  FlexibleBottomSheet({
    Key? key,
    this.minHeight = 0,
    this.initHeight = 0.5,
    this.maxHeight = 1,
    this.builder,
    this.headerBuilder,
    this.bodyBuilder,
    this.bottomBuilder,
    this.isCollapsible = false,
    this.isExpand = true,
    this.animationController,
    this.anchors,
    this.minHeaderHeight,
    this.maxHeaderHeight,
    this.decoration,
    this.onDismiss,
  })  : assert(minHeight >= 0 && minHeight <= 1),
        assert(maxHeight > 0 && maxHeight <= 1),
        assert(maxHeight > minHeight),
        assert(!isCollapsible || minHeight == 0),
        assert(anchors == null || !anchors.any((anchor) => anchor > maxHeight)),
        assert(anchors == null || !anchors.any((anchor) => anchor < minHeight)),
        super(key: key);

  FlexibleBottomSheet.collapsible({
    Key? key,
    double initHeight = 0.5,
    double maxHeight = 1,
    FlexibleDraggableScrollableWidgetBuilder? builder,
    FlexibleDraggableScrollableHeaderWidgetBuilder? headerBuilder,
    FlexibleDraggableScrollableWidgetBodyBuilder? bodyBuilder,
    FlexibleDraggableScrollableBottomWidgetBuilder? bottomBuilder,
    bool isExpand = true,
    AnimationController? animationController,
    List<double>? anchors,
    double? minHeaderHeight,
    double? maxHeaderHeight,
    Decoration? decoration,
  }) : this(
          key: key,
          maxHeight: maxHeight,
          builder: builder,
          headerBuilder: headerBuilder,
          bodyBuilder: bodyBuilder,
          bottomBuilder: bottomBuilder,
          minHeight: 0,
          initHeight: initHeight,
          isCollapsible: true,
          isExpand: isExpand,
          animationController: animationController,
          anchors: anchors,
          minHeaderHeight: minHeaderHeight,
          maxHeaderHeight: maxHeaderHeight,
          decoration: decoration,
        );
  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final FlexibleDraggableScrollableWidgetBuilder? builder;
  final FlexibleDraggableScrollableHeaderWidgetBuilder? headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder? bodyBuilder;
  final FlexibleDraggableScrollableBottomWidgetBuilder? bottomBuilder;
  final bool isCollapsible;
  final bool isExpand;
  final AnimationController? animationController;
  final List<double>? anchors;
  final double? minHeaderHeight;
  final double? maxHeaderHeight;
  final Decoration? decoration;
  final VoidCallback? onDismiss;

  @override
  _FlexibleBottomSheetState createState() => _FlexibleBottomSheetState();
}

class _FlexibleBottomSheetState extends State<FlexibleBottomSheet>
    with SingleTickerProviderStateMixin {
  final _controller = DraggableScrollableController();

  late double initialChildSize = widget.initHeight;
  bool _isClosing = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: _scrolling,
      child: DraggableScrollableSheet(
        maxChildSize: widget.maxHeight,
        minChildSize: widget.minHeight,
        initialChildSize: initialChildSize,
        snap: widget.anchors != null,
        controller: _controller,
        snapSizes: widget.anchors,
        expand: widget.isExpand,
        builder: (
          context,
          controller,
        ) {
          return ChangeInsetsDetector(
            handler: (delta, inset) {
              if (delta > 0) {
                _animateToFocused(controller);
                _animateToMaxHeigt();
              }
              // checking for openness of the keyboard before opening the sheet
              if (delta == 0 && inset != 0) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    setState(() {
                      initialChildSize = widget.maxHeight;
                    });
                  },
                );
              }
            },
            child: AnimatedPadding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              onEnd: () {
                _animateToFocused(controller);
                _updateState();
              },
              child: _Content(
                builder: widget.builder,
                decoration: widget.decoration,
                bodyBuilder: widget.bodyBuilder,
                headerBuilder: widget.headerBuilder,
                bottomBuilder: widget.bottomBuilder,
                minHeaderHeight: widget.minHeaderHeight,
                maxHeaderHeight: widget.maxHeaderHeight,
                currentExtent: _controller.size,
                scrollController: controller,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Update state
  /// explicit application [initialChildSize]
  void _updateState() {
    setState(() {});
  }

  /// Method will be called when scrolling
  bool _scrolling(DraggableScrollableNotification notification) {
    if (_isClosing) {
      return false;
    }

    initialChildSize = notification.extent;

    _checkNeedCloseBottomSheet(notification.extent);

    return false;
  }

  /// Make bottom sheet max height
  void _animateToMaxHeigt() {
    final currPosition = _controller.size;
    if (currPosition != widget.maxHeight) {
      _controller.animateTo(
        widget.maxHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  /// scroll to focused widget
  void _animateToFocused(ScrollController controller) {
    if (FocusManager.instance.primaryFocus == null || _isClosing) {
      return;
    }

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final widgetHeight = FocusManager.instance.primaryFocus!.size.height;
    final widgetOffset = FocusManager.instance.primaryFocus!.offset.dy;
    final screenHeight = MediaQuery.of(context).size.height;

    final targetWidgetOffset =
        screenHeight - keyboardHeight - widgetHeight - 20;
    final valueToScroll = widgetOffset - targetWidgetOffset;
    final currentOffset = controller.offset;

    if (valueToScroll > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.animateTo(
          currentOffset + valueToScroll,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      });
    }
  }

  /// checking if the bottom sheet needs to be closed
  void _checkNeedCloseBottomSheet(double extent) {
    if (widget.isCollapsible && !_isClosing) {
      if (extent - widget.minHeight <= 0.005) {
        _isClosing = true;
        _dismiss();
      }
    }
  }

  void _dismiss() {
    if (widget.isCollapsible) {
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
      Navigator.maybePop(context);
    }
  }
}

/// Content for [FlexibleBottomSheet].
class _Content extends StatelessWidget {
  const _Content({
    required this.currentExtent,
    required this.scrollController,
    this.builder,
    this.decoration,
    this.headerBuilder,
    this.bodyBuilder,
    this.bottomBuilder,
    this.minHeaderHeight,
    this.maxHeaderHeight,
    Key? key,
  }) : super(key: key);

  final FlexibleDraggableScrollableWidgetBuilder? builder;
  final Decoration? decoration;
  final FlexibleDraggableScrollableHeaderWidgetBuilder? headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder? bodyBuilder;
  final FlexibleDraggableScrollableBottomWidgetBuilder? bottomBuilder;
  final double? minHeaderHeight;
  final double? maxHeaderHeight;
  final double currentExtent;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder!(
        context,
        scrollController,
        currentExtent,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: decoration,
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            if (headerBuilder != null)
              SliverPersistentHeader(
                pinned: true,
                delegate: FlexibleBottomSheetHeaderDelegate(
                  minHeight: minHeaderHeight ?? 0.0,
                  maxHeight: maxHeaderHeight ?? 1.0,
                  child: headerBuilder!(context, currentExtent),
                ),
              ),
            if (bodyBuilder != null)
              SliverList(
                delegate: bodyBuilder!(
                  context,
                  currentExtent,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBuilder != null
          ? Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.grey3,
                      width: 0.5,
                    ),
                  )),
              child: bottomBuilder!(
                context,
                currentExtent,
              ),
            )
          : null,
    );
  }
}
