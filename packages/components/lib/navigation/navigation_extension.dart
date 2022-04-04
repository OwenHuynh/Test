import 'package:components/global/base_global.dart';
import 'package:components/navigation/transition_builders_anim.dart';
import 'package:flutter/material.dart';

extension NavigationExtension on Widget {
  RoutePageBuilder get toRoutePageBuilder =>
      (_, Animation<double> animation, Animation<double> secondaryAnimation) =>
          this;

  RouteTransitionsBuilder get toRouteTransitionsBuilder => (_,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      this;

  PageRoute<T> buildPageRoute<T>(
      {bool maintainState = true,
      bool fullscreenDialog = false,
      RoutePushStyle pushStyle = RoutePushStyle.SlideLeftWithFade,
      RouteSettings? settings,
      BuildContext? context}) {
    switch (pushStyle) {
      case RoutePushStyle.SlideLeft:
        return TransitionBuilderPageRoute<T>(
            builder: (_) => this,
            routeSettings: settings,
            routeTransitionsBuilder: TransitionsBuildersAnim.slideLeft);
      case RoutePushStyle.SlideRight:
        return TransitionBuilderPageRoute<T>(
            builder: (_) => this,
            routeSettings: settings,
            routeTransitionsBuilder: TransitionsBuildersAnim.slideRight);
      case RoutePushStyle.SlideRightWithFade:
        return TransitionBuilderPageRoute<T>(
            builder: (_) => this,
            routeSettings: settings,
            routeTransitionsBuilder:
                TransitionsBuildersAnim.slideRightWithFade);
      case RoutePushStyle.SlideLeftWithFade:
        return TransitionBuilderPageRoute<T>(
            builder: (_) => this,
            routeSettings: settings,
            routeTransitionsBuilder: TransitionsBuildersAnim.slideLeftWithFade);
      case RoutePushStyle.Ripple:
        return RipplePageRoute<T>(
            builder: (_) => this,
            routeConfig: RippleRouteConfig.fromContext(context!));
    }
  }
}
