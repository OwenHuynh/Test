import 'package:components/global/base_global.dart';
import 'package:components/navigation/transition_builders_anim.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseExtendedApp extends StatelessWidget {
  const BaseExtendedApp({
    Key? key,
    this.routes = const <String, WidgetBuilder>{},
    this.title = '',
    this.themeMode = ThemeMode.system,
    this.pushStyle = RoutePushStyle.Ripple,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.debugShowWidgetInspector = false,
    this.debugShowCheckedModeBanner = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.color,
    this.navigatorKey,
    this.home,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.onGenerateTitle,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.inspectorSelectButtonBuilder,
    this.cupertinoTheme,
    this.scaffoldMessengerKey,
    this.scrollBehavior,
    this.restorationScopeId,
    this.textStyle,
    this.useInheritedMediaQuery = false,
  }) : super(key: key);

  final RoutePushStyle pushStyle;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? home;

  final String? initialRoute;

  final RouteFactory? onGenerateRoute;

  final RouteFactory? onUnknownRoute;

  final TransitionBuilder? builder;

  final LocaleListResolutionCallback? localeListResolutionCallback;

  final LocaleResolutionCallback? localeResolutionCallback;

  final GenerateAppTitle? onGenerateTitle;

  final CupertinoThemeData? cupertinoTheme;

  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;

  final Color? color;

  final Map<String, WidgetBuilder> routes;

  final List<NavigatorObserver> navigatorObservers;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final String title;

  final ThemeMode themeMode;

  final Locale? locale;

  final Iterable<Locale> supportedLocales;

  final bool showPerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final bool showSemanticsDebugger;

  final bool debugShowCheckedModeBanner;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final InspectorSelectButtonBuilder? inspectorSelectButtonBuilder;
  final String? restorationScopeId;
  final bool debugShowWidgetInspector;
  final TextStyle? textStyle;
  final bool useInheritedMediaQuery;

  @override
  Widget build(BuildContext context) {
    if (navigatorKey != null) {
      BaseGlobal().globalNavigatorKey = navigatorKey!;
    }
    if (theme != null ||
        darkTheme != null ||
        pushStyle == RoutePushStyle.SlideLeftWithFade) {
      return materialApp;
    }

    if (cupertinoTheme != null ||
        pushStyle == RoutePushStyle.SlideRightWithFade) {
      return cupertinoApp;
    }
    late Color _color;
    switch (pushStyle) {
      case RoutePushStyle.SlideRight:
        _color = color ?? theme?.primaryColor ?? Colors.blue;
        break;
      case RoutePushStyle.SlideLeft:
        _color = color ?? theme?.primaryColor ?? Colors.blue;
        break;
      case RoutePushStyle.SlideRightWithFade:
        _color = color ?? theme?.primaryColor ?? Colors.blue;
        break;
      case RoutePushStyle.SlideLeftWithFade:
        _color = color ?? theme?.primaryColor ?? Colors.blue;
        break;
      case RoutePushStyle.Ripple:
        _color = color ?? theme?.primaryColor ?? Colors.blue;
        break;
    }
    return WidgetsApp(
        key: key,
        navigatorKey: BaseGlobal().globalNavigatorKey,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers,
        initialRoute: initialRoute,
        pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
          switch (pushStyle) {
            case RoutePushStyle.SlideLeft:
              return TransitionBuilderPageRoute<T>(
                  builder: (_) => this,
                  routeTransitionsBuilder: TransitionsBuildersAnim.slideLeft);
            case RoutePushStyle.SlideRight:
              return TransitionBuilderPageRoute<T>(
                  builder: (_) => this,
                  routeTransitionsBuilder: TransitionsBuildersAnim.slideRight);
            case RoutePushStyle.SlideRightWithFade:
              return TransitionBuilderPageRoute<T>(
                  builder: (_) => this,
                  routeTransitionsBuilder:
                      TransitionsBuildersAnim.slideRightWithFade);
            case RoutePushStyle.SlideLeftWithFade:
              return TransitionBuilderPageRoute<T>(
                  builder: (_) => this,
                  routeTransitionsBuilder:
                      TransitionsBuildersAnim.slideLeftWithFade);
            case RoutePushStyle.Ripple:
              return RipplePageRoute<T>(
                  builder: (_) => this,
                  routeConfig: RippleRouteConfig.fromContext(context));
          }
        },
        home: home,
        routes: routes,
        builder: builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        textStyle: textStyle,
        color: _color,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowWidgetInspector: debugShowWidgetInspector,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        inspectorSelectButtonBuilder: inspectorSelectButtonBuilder,
        shortcuts: shortcuts,
        actions: actions,
        useInheritedMediaQuery: useInheritedMediaQuery,
        restorationScopeId: restorationScopeId);
  }

  MaterialApp get materialApp {
    BaseGlobal().globalScaffoldMessengerKey =
        scaffoldMessengerKey ?? GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
        key: key,
        navigatorKey: BaseGlobal().globalNavigatorKey,
        scaffoldMessengerKey: BaseGlobal().globalScaffoldMessengerKey,
        home: home,
        routes: routes,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers,
        builder: builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        color: color,
        theme: theme,
        darkTheme: darkTheme,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowMaterialGrid: debugShowMaterialGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        useInheritedMediaQuery: useInheritedMediaQuery,
        scrollBehavior: scrollBehavior);
  }

  CupertinoApp get cupertinoApp => CupertinoApp(
      key: key,
      navigatorKey: BaseGlobal().globalNavigatorKey,
      home: home,
      theme: cupertinoTheme,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
      scrollBehavior: scrollBehavior);
}
