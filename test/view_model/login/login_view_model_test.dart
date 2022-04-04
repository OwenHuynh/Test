import 'package:portal/presentation/screens/login/login.dart';
import 'package:portal/presentation/screens/login/login.view_model.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/store.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as flutter_hooks;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:redux/redux.dart';

import '../../constraints/pump_widget_wrapper.dart';
import '../../mock/mock.dart';
import '../../utils/flutter_hooks_testing.dart';
import '../../utils/mock_methods_for_unit_tests.dart';

void main() {
  late Store<AppState> store;

  setUp(() async {
    await setMockMethodsForUnitTests();
    store = createStore();
  });

  group('login view model test', () {
    testWidgets("handling function onEmailChange test", (tester) async {
      var result;
      await tester.pumpWidget(
        StoreProvider<AppState>(
          store: store,
          child: testAppInjector(
            flutter_hooks.HookBuilder(builder: (context) {
              result = useLoginViewModel(context);
              return LoginBody();
            }),
          ),
        ),
      );

      await act(() => result.onEmailChange("test"));

      expect(result.state.email, "test");
      expect(
          result.state.emailError,
          "メールアドレスを正しく入力してください。 "
          "\n例：sample@gmail.com");
    });

    testWidgets("handling function onPasswordChange test", (tester) async {
      var result;
      await tester.pumpWidget(
        StoreProvider<AppState>(
          store: store,
          child: testAppInjector(
            flutter_hooks.HookBuilder(builder: (context) {
              result = useLoginViewModel(context);
              return LoginBody();
            }),
          ),
        ),
      );

      await act(() => result.onPasswordChange("test"));

      expect(result.state.password, "test");
      expect(result.state.passwordError, "パスワードを正しく入力してください。６字以上で入力してください。");
    });

    testWidgets("handling form validation actions test", (tester) async {
      var result;
      await tester.pumpWidget(
        StoreProvider<AppState>(
          store: store,
          child: testAppInjector(
            flutter_hooks.HookBuilder(builder: (context) {
              result = useLoginViewModel(context);
              return LoginBody();
            }),
          ),
        ),
      );

      await act(() => result.onEmailChange("test@gmail.com"));

      await act(() => result.onPasswordChange("12345678"));

      expect(result.state.email, "test@gmail.com");

      expect(result.state.emailError, null);

      expect(result.state.password, "12345678");

      expect(result.state.passwordError, null);

      expect(result.isFormValid, true);
    });

    testWidgets("handling useEffect actions test", (tester) async {
      var result;
      final hooks =
          await testAppWithHookInjector(LoginBody(), hook: (_, context) {
        result = useLoginViewModel(context)..onLoadDistrict = MockEffect();
      }, store: store);

      await act(() => result.onLoadDistrict());

      verify(result.onLoadDistrict).called(1);
      await hooks.rebuild();
      verifyNever(result.onLoadDistrict);
    });
  });
}
