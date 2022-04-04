import 'dart:math';

import 'package:components/utils/utils.dart';
import 'package:components/widgets/base/base_widget.dart';
import 'package:components/widgets/widget_extension.dart';
import 'package:flutter/material.dart';

class TransitionsBuildersAnim {
  const TransitionsBuildersAnim._();

  static const RouteTransitionsBuilder slideRight = _slideRight;

  static Widget _slideRight(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideLeft = _slideLeft;

  static Widget _slideLeft(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideRightWithFade = _slideRightWithFade;

  static Widget _slideRightWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  static const RouteTransitionsBuilder slideLeftWithFade = _slideLeftWithFade;

  static Widget _slideLeftWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  static const RouteTransitionsBuilder slideTop = _slideTop;

  static Widget _slideTop(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideBottom = _slideBottom;

  static Widget _slideBottom(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder fadeIn = _fadeIn;

  static Widget _fadeIn(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  static const RouteTransitionsBuilder zoomIn = _zoomIn;

  static Widget _zoomIn(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(scale: animation, child: child);
  }

  static const RouteTransitionsBuilder noTransition = _noTransition;

  static Widget _noTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class TransitionBuilderPageRoute<T> extends PageRouteBuilder<T> {
  TransitionBuilderPageRoute(
      {required this.builder,
      required this.routeTransitionsBuilder,
      this.routeSettings})
      : super(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, _, __) => builder(context),
            opaque: false,
            settings: routeSettings,
            transitionsBuilder: routeTransitionsBuilder);

  final WidgetBuilder builder;
  final RouteTransitionsBuilder routeTransitionsBuilder;
  final RouteSettings? routeSettings;
}

class RippleRouteConfig {
  RippleRouteConfig.fromContext(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    offset = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    final Size size = MediaQuery.of(context).size;
    if (offset.dx > size.width / 2) {
      if (offset.dy > size.height / 2) {
        circleRadius = sqrt(pow(offset.dx, 2) + pow(offset.dy, 2)).toDouble();
      } else {
        circleRadius = sqrt(pow(offset.dx, 2) + pow(size.height - offset.dy, 2))
            .toDouble();
      }
    }
    if (offset.dx <= size.width / 2) {
      if (offset.dy > size.height / 2) {
        circleRadius =
            sqrt(pow(size.width - offset.dx, 2) + pow(offset.dy, 2)).toDouble();
      } else {
        circleRadius = sqrt(pow(size.width - offset.dx, 2) +
                pow(size.height - offset.dy, 2))
            .toDouble();
      }
    }
  }

  late Offset offset;
  late double circleRadius;
}

class RipplePageRoute<T> extends PageRouteBuilder<T> {
  RipplePageRoute({required this.builder, required this.routeConfig})
      : super(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, _, __) => builder(context),
            opaque: false,
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> __, Widget child) {
              final Widget widget = Positioned(
                  top: routeConfig.circleRadius * animation.value -
                      routeConfig.offset.dy,
                  left: routeConfig.circleRadius * animation.value -
                      routeConfig.offset.dx,
                  child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: ScreenUtil.deviceWidth,
                          height: ScreenUtil.deviceHeight,
                          child: child)));
              return Stack(alignment: Alignment.center, children: <Widget>[
                Positioned(
                    top: routeConfig.offset.dy -
                        routeConfig.circleRadius * animation.value,
                    left: routeConfig.offset.dx -
                        routeConfig.circleRadius * animation.value,
                    child: BaseWidget(
                        height: routeConfig.circleRadius * 2 * animation.value,
                        width: routeConfig.circleRadius * 2 * animation.value,
                        isOval: true,
                        isStack: true,
                        children: widget.asList())),
              ]);
            });

  final WidgetBuilder builder;
  final RippleRouteConfig routeConfig;
}
