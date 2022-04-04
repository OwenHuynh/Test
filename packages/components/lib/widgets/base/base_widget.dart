import 'dart:ui';

import 'package:components/utils/ext/object_extension.dart';
import 'package:components/widgets/scrollview/over_scroll_behavior.dart';
import 'package:components/widgets/scrollview/scroll_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    Key? key,
    this.addCard = false,
    this.addInkWell = false,
    this.isScroll = false,
    this.useSingleChildScrollView = true,
    this.isStack = false,
    this.isWrap = false,
    this.expanded = false,
    this.expand = false,
    this.shrink = false,
    this.intrinsicHeight = false,
    this.intrinsicWidth = false,
    this.isOval = false,
    this.isClipRRect = false,
    this.isClipRect = false,
    this.visible = true,
    this.offstage = false,
    this.enabled = false,
    this.reverse = false,
    this.autoFocus = false,
    this.maintainState = false,
    this.transitionOnUserGestures = false,
    this.isCircleAvatar = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    this.excludeFromSemantics = false,
    this.enableFeedback = true,
    this.canRequestFocus = true,
    this.noScrollBehavior = true,
    this.sized = true,
    this.gaussian = false,
    this.safeLeft = false,
    this.safeTop = false,
    this.safeRight = false,
    this.safeBottom = false,
    this.fuzzyDegree = 4,
    this.wrapSpacing = 0.0,
    this.runSpacing = 0.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.shadowColor = Colors.transparent,
    this.replacement = const SizedBox.shrink(),
    this.stackFit = StackFit.loose,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.wrapAlignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.direction = Axis.vertical,
    this.scrollDirection,
    this.behavior = HitTestBehavior.opaque,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.child,
    this.children,
    this.padding,
    this.physics,
    this.scrollController,
    this.primary,
    this.foregroundDecoration,
    this.transform,
    this.origin,
    this.constraints,
    this.width,
    this.height,
    this.margin,
    this.decoration,
    this.textBaseline,
    this.textDirection,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.shape,
    this.onHighlightChanged,
    this.onHover,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.customBorder,
    this.focusNode,
    this.onFocusChange,
    this.heroTag,
    this.createRectTween,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.foregroundColor,
    this.minRadius,
    this.maxRadius,
    this.clipper,
    this.size,
    this.onSecondaryTap,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressEnd,
    this.onSecondaryLongPressStart,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.flex,
    this.elevation,
    this.opacity,
    this.clipBehavior,
    this.refreshConfig,
    this.widthFactor,
    this.heightFactor,
    this.filter,
    this.builder,
    this.fit,
    this.systemOverlayStyle,
  })  : assert(!(addCard && addInkWell), 'One of them must be true'),
        super(key: key);

  /// ****** [AnnotatedRegion]  ****** ///
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool sized;

  /// [GestureDetector]、[SingleChildScrollView] 使用
  final DragStartBehavior dragStartBehavior;
  final bool intrinsicHeight;
  final bool intrinsicWidth;
  final Clip? clipBehavior;
  final AlignmentGeometry? alignment;
  final double? widthFactor;
  final double? heightFactor;
  final BorderRadius borderRadius;
  final Widget? child;
  final List<Widget>? children;
  final dynamic builder;
  final bool isWrap;
  final WrapAlignment wrapAlignment;
  final double wrapSpacing;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final WrapCrossAlignment wrapCrossAlignment;
  final int? flex;
  final bool expanded;

  /// ****** [Transform] ****** ///
  final Matrix4? transform;
  final Offset? origin;

  /// ****** [ConstrainedBox] ****** ///
  final BoxConstraints? constraints;

  /// ****** [ColoredBox]||[DecoratedBox] ****** ///
  final Color? color;

  /// ****** [Padding] ****** ///
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  /// ****** [DecoratedBox] ****** ///
  final Decoration? decoration;
  final Decoration? foregroundDecoration;

  /// ****** [Positioned] ****** ///
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  /// ****** [FittedBox] ****** ///
  final BoxFit? fit;

  /// ****** [Card] ****** ///
  final bool addCard;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;

  /// ****** [Flex]=[Column]+[Row] ****** ///
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final TextBaseline? textBaseline;
  final VerticalDirection verticalDirection;
  final TextDirection? textDirection;
  final MainAxisSize mainAxisSize;

  /// ****** [ClipRRect]、[ClipPath]、[ClipRect]、[ClipOval] ****** ///
  /// [RRect]、[Path]、[Rect]
  final CustomClipper<dynamic>? clipper;
  final bool isOval;
  final bool isClipRRect;
  final bool isClipRect;

  /// ****** [CircleAvatar] ****** ///
  final bool isCircleAvatar;
  final ImageProvider? backgroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final Color? foregroundColor;
  final double? minRadius;
  final double? maxRadius;

  final bool isScroll;

  final bool useSingleChildScrollView;

  final bool noScrollBehavior;

  /// ****** [SingleChildScrollView] ****** ///
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Axis? scrollDirection;
  final bool reverse;
  final bool? primary;

  /// ****** [SizedBox] ****** ///
  final bool expand;
  final bool shrink;
  final Size? size;
  final double? width;
  final double? height;

  /// ****** [Visibility] ****** ///
  final Widget replacement;
  final bool visible;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;
  final bool offstage;

  /// ****** [Opacity] ****** ///
  final double? opacity;

  /// ****** [InkWell] ****** ///
  final ValueChanged<bool>? onHighlightChanged;

  final ValueChanged<bool>? onHover;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final Color? splashColor;

  final InteractiveInkFeatureFactory? splashFactory;

  final double? radius;

  final ShapeBorder? customBorder;

  final bool? enableFeedback;

  final FocusNode? focusNode;
  final bool canRequestFocus;

  final ValueChanged<bool>? onFocusChange;

  final bool autoFocus;

  /// [addInkWell]添加[InkWell] 有水波纹效果
  final bool addInkWell;

  final bool enabled;

  final GestureTapCallback? onTap;

  final GestureTapCallback? onDoubleTap;

  final GestureLongPressCallback? onLongPress;

  final GestureTapDownCallback? onTapDown;

  final GestureTapCancelCallback? onTapCancel;

  final bool excludeFromSemantics;

  /// ****** [GestureDetector] ****** ///
  final GestureTapUpCallback? onTapUp;

  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;

  final GestureLongPressStartCallback? onLongPressStart;

  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  final GestureLongPressUpCallback? onLongPressUp;

  final GestureLongPressEndCallback? onLongPressEnd;

  final GestureDragDownCallback? onVerticalDragDown;

  final GestureDragStartCallback? onVerticalDragStart;

  final GestureDragUpdateCallback? onVerticalDragUpdate;

  final GestureDragEndCallback? onVerticalDragEnd;

  final GestureDragCancelCallback? onVerticalDragCancel;

  final GestureDragDownCallback? onHorizontalDragDown;

  final GestureDragStartCallback? onHorizontalDragStart;

  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  final GestureDragEndCallback? onHorizontalDragEnd;

  final GestureDragCancelCallback? onHorizontalDragCancel;

  final GestureDragDownCallback? onPanDown;

  final GestureDragStartCallback? onPanStart;

  final GestureDragUpdateCallback? onPanUpdate;

  final GestureDragEndCallback? onPanEnd;

  final GestureDragCancelCallback? onPanCancel;

  final GestureScaleStartCallback? onScaleStart;

  final GestureScaleUpdateCallback? onScaleUpdate;

  final GestureScaleEndCallback? onScaleEnd;
  final GestureForcePressStartCallback? onForcePressStart;
  final GestureForcePressPeakCallback? onForcePressPeak;
  final GestureForcePressUpdateCallback? onForcePressUpdate;
  final GestureForcePressEndCallback? onForcePressEnd;
  final GestureTapCallback? onSecondaryTap;
  final GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate;
  final GestureLongPressCallback? onSecondaryLongPressUp;
  final GestureLongPressCallback? onSecondaryLongPress;
  final GestureLongPressEndCallback? onSecondaryLongPressEnd;
  final GestureLongPressStartCallback? onSecondaryLongPressStart;
  final HitTestBehavior behavior;
  final String? heroTag;
  final CreateRectTween? createRectTween;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;
  final bool transitionOnUserGestures;
  final HeroPlaceholderBuilder? placeholderBuilder;
  final bool isStack;
  final StackFit stackFit;
  final RefreshConfig? refreshConfig;
  final ImageFilter? filter;
  final double fuzzyDegree;
  final bool gaussian;
  final bool safeLeft;
  final bool safeTop;
  final bool safeRight;
  final bool safeBottom;

  EdgeInsetsGeometry? get _paddingIncludingDecoration {
    if (decoration == null || decoration!.padding == null) {
      return padding;
    }
    final EdgeInsetsGeometry decorationPadding = decoration!.padding!;
    if (padding == null) {
      return decorationPadding;
    }
    return padding!.add(decorationPadding);
  }

  @override
  Widget build(BuildContext context) {
    Widget current = const SizedBox();
    if (children != null && children!.isNotEmpty) {
      if (child != null) {
        children!.insert(0, child!);
      }
      if (builder != null) {
        children!.insert(1, builderWidget(current));
      }
      current = isStack ? stackWidget(children!) : flexWidget(children!);
      if (isWrap) {
        current = wrapWidget(children!);
      }
    } else {
      if (child != null) {
        current = child!;
      }
      if (builder != null) {
        current = builderWidget(current);
      }
    }

    if (isScroll || refreshConfig != null) {
      if (refreshConfig == null && useSingleChildScrollView) {
        current = noScrollBehavior
            ? ScrollConfiguration(
                behavior: NoScrollBehavior(),
                child: singleChildScrollViewWidget(current))
            : singleChildScrollViewWidget(current);

        /// 添加padding
        current = paddingWidget(current);
      } else {
        if (children != null && children!.isNotEmpty && !isStack && !isWrap) {
          current = refreshedWidget(children!
              .builder((Widget item) => SliverToBoxAdapter(child: item)));
        } else {
          current =
              refreshedWidget(<Widget>[SliverToBoxAdapter(child: current)]);
        }
      }
    } else {
      /// 添加padding
      current = paddingWidget(current);
    }

    if (alignment != null) {
      current = Align(
          alignment: alignment!,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: current);
    }
    if (intrinsicWidth) {
      current = IntrinsicWidth(child: current);
    }
    if (intrinsicHeight) {
      current = IntrinsicHeight(child: current);
    }

    if (color != null && decoration == null && !addInkWell && !addCard) {
      current = ColoredBox(color: color!, child: current);
    }

    if (decoration != null &&
        clipBehavior != null &&
        clipBehavior != Clip.none) {
      current = clipWidget(current,
          clipper: _DecorationClipper(
              textDirection: Directionality.of(context),
              decoration: decoration!));
    }
    if (decoration != null && !addInkWell) {
      current = DecoratedBox(decoration: decoration!, child: current);
    }
    if (foregroundDecoration != null) {
      current = DecoratedBox(
          decoration: foregroundDecoration!,
          position: DecorationPosition.foreground,
          child: current);
    }
    if (transform != null) {
      current =
          Transform(transform: transform!, origin: origin, child: current);
    }
    if (enabled ||
        onTap != null ||
        onDoubleTap != null ||
        onLongPress != null) {
      current =
          addInkWell ? inkWellWidget(current) : gestureDetectorWidget(current);
    }
    if (shrink) {
      current = SizedBox.shrink(child: current);
    }
    if (expand) {
      current = SizedBox.expand(child: current);
    }
    if (width != null || height != null) {
      current = SizedBox(width: width, height: height, child: current);
    }
    if (size != null) {
      current = SizedBox.fromSize(size: size, child: current);
    }

    if (heroTag != null) {
      current = heroWidget(current);
    }
    if (addCard) {
      current = cardWidget(current, context);
    }
    if (isCircleAvatar) {
      current = circleAvatarWidget(current);
    }
    if (clipper != null || isOval || isClipRRect) {
      current = clipWidget(current, clipper: clipper);
    }

    if (constraints != null) {
      current = ConstrainedBox(constraints: constraints!, child: current);
    }

    if (margin != null) {
      current = Padding(padding: margin!, child: current);
    }
    if (expanded || flex != null) {
      current = flexibleWidget(current);
    }
    if (left != null || top != null || right != null || bottom != null) {
      current = Positioned(
          left: left, top: top, right: right, bottom: bottom, child: current);
    }
    if (gaussian) {
      backdropFilter(current);
    }
    if (fit != null) {
      current = fittedBox(current);
    }
    if (opacity != null && opacity! > 0) {
      current = Opacity(opacity: opacity!, child: current);
    }

    if (systemOverlayStyle != null) {
      current = annotatedRegionWidget(current);
    }
    if (offstage) {
      current = offstageWidget(current);
    }
    if (!visible) {
      current = visibilityWidget(current);
    }
    if (safeLeft || safeTop || safeRight || safeBottom) {
      current = SafeArea(
          left: safeLeft,
          top: safeTop,
          right: safeRight,
          bottom: safeBottom,
          child: current);
    }
    return current;
  }

  Widget annotatedRegionWidget(Widget current) =>
      AnnotatedRegion<SystemUiOverlayStyle>(
          sized: sized, value: systemOverlayStyle!, child: current);

  Widget fittedBox(Widget current) => FittedBox(
      fit: fit!,
      alignment: alignment ?? Alignment.center,
      clipBehavior: clipBehavior ?? Clip.none,
      child: current);

  Widget builderWidget(Widget current) {
    if (builder is StatefulWidgetBuilder) {
      return StatefulBuilder(builder: builder as StatefulWidgetBuilder);
    } else if (builder is WidgetBuilder) {
      return Builder(builder: builder as WidgetBuilder);
    } else if (builder is LayoutWidgetBuilder) {
      return LayoutBuilder(builder: builder as LayoutWidgetBuilder);
    }
    return current;
  }

  Widget paddingWidget(Widget current) => _paddingIncludingDecoration == null
      ? current
      : Padding(padding: _paddingIncludingDecoration!, child: current);

  Widget backdropFilter(Widget current) => BackdropFilter(
      filter:
          filter ?? ImageFilter.blur(sigmaX: fuzzyDegree, sigmaY: fuzzyDegree),
      child: current);

  Widget offstageWidget(Widget current) =>
      Offstage(offstage: offstage, child: current);

  Widget clipWidget(Widget current, {CustomClipper<dynamic>? clipper}) {
    if (isOval) {
      return ClipOval(
          clipBehavior: clipBehavior ?? Clip.antiAlias, child: current);
    } else if (clipper is CustomClipper<Rect> || isClipRect) {
      return ClipRect(
          clipper: clipper is CustomClipper<Rect> ? clipper : null,
          clipBehavior: clipBehavior ?? Clip.hardEdge,
          child: current);
    } else if (clipper is CustomClipper<Path>) {
      return ClipPath(
          clipper: clipper,
          clipBehavior: clipBehavior ?? Clip.antiAlias,
          child: current);
    } else if (clipper is CustomClipper<RRect> || isClipRRect) {
      return ClipRRect(
          borderRadius: borderRadius,
          clipper: clipper is CustomClipper<RRect> ? clipper : null,
          clipBehavior: clipBehavior ?? Clip.antiAlias,
          child: current);
    }
    return current;
  }

  Widget circleAvatarWidget(Widget current) => CircleAvatar(
      backgroundColor: color,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      foregroundColor: foregroundColor,
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: current);

  Widget heroWidget(Widget current) => Hero(
      tag: heroTag!,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      child: current);

  Widget visibilityWidget(Widget current) => Visibility(
      replacement: replacement,
      visible: visible,
      maintainState: maintainState,
      maintainAnimation: maintainAnimation,
      maintainSize: maintainSize,
      maintainSemantics: maintainSemantics,
      maintainInteractivity: maintainInteractivity,
      child: current);

  Widget flexibleWidget(Widget current) => Flexible(
      flex: flex ?? 1,
      fit: expanded ? FlexFit.tight : FlexFit.loose,
      child: current);

  Widget cardWidget(Widget current, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);
    return material(current,
        mType: MaterialType.card,
        mShadowColor: shadowColor ?? cardTheme.shadowColor ?? theme.shadowColor,
        mColor: color ?? cardTheme.color ?? theme.cardColor,
        mElevation: elevation ?? cardTheme.elevation ?? 10,
        mShape: shape ??
            cardTheme.shape ??
            RoundedRectangleBorder(
                borderRadius: borderRadius == BorderRadius.zero
                    ? BorderRadius.circular(4)
                    : borderRadius),
        mClipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
        mBorderOnForeground: true);
  }

  Material material(Widget current,
          {required MaterialType mType,
          Color? mShadowColor,
          Color? mColor,
          TextStyle? mTextStyle,
          required double mElevation,
          BorderRadiusGeometry? mBorderRadius,
          ShapeBorder? mShape,
          required bool mBorderOnForeground,
          required Clip mClipBehavior}) =>
      Material(
          color: mColor,
          type: mType,
          elevation: mElevation,
          shadowColor: mShadowColor,
          textStyle: mTextStyle,
          borderRadius: (mShape != null || shape != null) ? null : borderRadius,
          shape: mShape ?? shape,
          borderOnForeground: mBorderOnForeground,
          clipBehavior: mClipBehavior,
          child: current);

  Widget inkWellWidget(Widget current) => Ink(
      decoration: decoration,
      child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          onFocusChange: onFocusChange,
          autofocus: autoFocus,
          child: current));

  Widget singleChildScrollViewWidget(Widget current) => SingleChildScrollView(
      physics: physics,
      reverse: reverse,
      primary: primary,
      dragStartBehavior: dragStartBehavior,
      controller: scrollController,
      scrollDirection: scrollDirection ?? direction,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      child: current);

  Widget refreshedWidget(List<Widget> slivers) => RefreshScrollView(
      controller: scrollController,
      slivers: slivers,
      padding: _paddingIncludingDecoration,
      noScrollBehavior: noScrollBehavior,
      reverse: reverse,
      primary: primary,
      scrollDirection: scrollDirection ?? direction,
      refreshConfig: refreshConfig);

  Widget flexWidget(List<Widget> children) => Flex(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      direction: direction,
      textBaseline: textBaseline,
      verticalDirection: verticalDirection,
      textDirection: textDirection,
      mainAxisSize: mainAxisSize,
      children: children);

  Widget wrapWidget(List<Widget> children) => Wrap(
      direction: direction,
      alignment: wrapAlignment,
      spacing: wrapSpacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: wrapCrossAlignment,
      clipBehavior: clipBehavior ?? Clip.none,
      verticalDirection: verticalDirection,
      textDirection: textDirection,
      children: children);

  Widget stackWidget(List<Widget> children) => Stack(
      alignment: alignment ?? AlignmentDirectional.topStart,
      textDirection: textDirection,
      fit: stackFit,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      children: children);

  Widget gestureDetectorWidget(Widget current) => GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onDoubleTap: onDoubleTap,
      onSecondaryTap: onSecondaryTap,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp: onSecondaryLongPressUp,
      onSecondaryLongPress: onSecondaryLongPress,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      onSecondaryLongPressStart: onSecondaryLongPressStart,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      child: current);
}

/// A clipper that uses [Decoration.getClipPath] to clip.
class _DecorationClipper extends CustomClipper<Path> {
  _DecorationClipper({TextDirection? textDirection, required this.decoration})
      : textDirection = textDirection ?? TextDirection.ltr;

  final TextDirection textDirection;
  final Decoration decoration;

  @override
  Path getClip(Size size) =>
      decoration.getClipPath(Offset.zero & size, textDirection);

  @override
  bool shouldReclip(_DecorationClipper oldClipper) =>
      oldClipper.decoration != decoration ||
      oldClipper.textDirection != textDirection;
}
