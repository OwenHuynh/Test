import 'package:components/res/res.dart';
import 'package:components/utils/device_util.dart';
import 'package:components/widgets/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:components/widgets/scrollview/over_scroll_behavior.dart';
import 'package:flutter/material.dart';

class FixedStickyScrollView extends StatelessWidget {
  const FixedStickyScrollView({
    Key? key,
    required this.children,
    this.padding,
    this.physics = const BouncingScrollPhysics(),
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.contentAlignment = Alignment.topLeft,
    this.bottomButton,
    this.bottomSafe = true,
    this.tapOutsideDismissKeyboard = false,
    this.overScroll = 16.0,
    this.borderRadius,
  }) : super(key: key);

  final List<Widget> children;

  final EdgeInsetsGeometry? padding;

  final ScrollPhysics physics;

  final MainAxisSize mainAxisSize;

  final CrossAxisAlignment crossAxisAlignment;

  final AlignmentGeometry contentAlignment;

  final Widget? bottomButton;

  final bool bottomSafe;

  final bool tapOutsideDismissKeyboard;

  final double overScroll;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget contents = Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (borderRadius != null) {
      contents = ClipRRect(borderRadius: borderRadius, child: contents);
    }

    if (DeviceUtil.isWeb || DeviceUtil.isDesktop) {
      contents = SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: contents,
      );
    } else {
      contents = ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SingleChildScrollView(
          padding: padding,
          physics: physics,
          child: contents,
        ),
      );
    }

    if (bottomButton != null) {
      contents = Column(
        children: <Widget>[
          Expanded(
              child: Align(
            alignment: contentAlignment,
            child: contents,
          )),
          bottomSafe
              ? SafeArea(
                  child: Padding(
                      padding: AppStyles.paddingButtonFooter,
                      child: bottomButton))
              : bottomButton!
        ],
      );
    }

    if (tapOutsideDismissKeyboard) {
      return KeyboardDismiss(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: contents,
      );
    }
    return contents;
  }
}
