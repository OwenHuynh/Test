import 'package:flutter/material.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as flutter_hooks;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

Widget testAppInjector(
  Widget widgetBody, {
  Key? key,
  Key? scaffoldKey,
}) {
  return Builder(builder: (context) {
    return MaterialApp(
      locale: const Locale.fromSubtags(languageCode: 'ja'),
      key: key ?? const Key('material-app-test'),
      home: Scaffold(key: scaffoldKey, body: widgetBody),
      localizationsDelegates: Localy.localizationsDelegates,
      supportedLocales: Localy.supportedLocales,
    );
  });
}

Future<_HookTestingAction<T, P>> testAppWithHookInjector<T, P>(
  Widget widgetBody, {
  required T Function(P? props, BuildContext context) hook,
  required Store<AppState> store,
  Key? key,
  Key? scaffoldKey,
  P? initialProps,
}) async {
  late T result;

  Widget builder([P? props]) {
    return MaterialApp(
      locale: const Locale.fromSubtags(languageCode: 'ja'),
      key: key ?? const Key('material-app-test'),
      home: Scaffold(
        key: scaffoldKey,
        body: StoreProvider<AppState>(
            store: store,
            child: flutter_hooks.HookBuilder(builder: (context) {
              result = hook(props, context);
              return widgetBody;
            })),
      ),
      localizationsDelegates: Localy.localizationsDelegates,
      supportedLocales: Localy.supportedLocales,
    );
  }

  await _build(builder(initialProps));

  Future<void> rebuild([P? props]) => _build(builder(props));

  Future<void> unmount() => _build(Container());

  return _HookTestingAction<T, P>(() => result, rebuild, unmount);
}

class _HookTestingAction<T, P> {
  const _HookTestingAction(this._current, this.rebuild, this.unmount);

  /// The current value of the result will reflect the latest of whatever is
  /// returned from the callback passed to buildHook.
  final T Function() _current;

  T get current => _current();

  /// A function to rebuild the test component, causing any hooks to be
  /// recalculated.
  final Future<void> Function([P? props]) rebuild;

  /// A function to unmount the test component. This is commonly used to trigger
  /// cleanup effects for useEffect hooks.
  final Future<void> Function() unmount;
}

Future<void> _build(Widget widget) async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  return TestAsyncUtils.guard<void>(() {
    binding
      ..attachRootWidget(widget)
      ..scheduleFrame();
    return binding.pump();
  });
}
