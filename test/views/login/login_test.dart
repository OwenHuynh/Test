import 'package:components/widgets/input/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/login/login.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import '../../constraints/pump_widget_wrapper.dart';
import '../../utils/mock_methods_for_unit_tests.dart';

void main() {
  late Store<AppState> store;
  late LoginScreen loginScreen;

  setUp(() async {
    await setMockMethodsForUnitTests();
    store = createStore();
  });

  Future<void> setMockLoginScreen(WidgetTester tester) async {
    loginScreen = const LoginScreen();
    await tester.pumpWidget(
      StoreProvider<AppState>(
        store: store,
        child: testAppInjector(
          loginScreen,
        ),
      ),
    );
  }

  group('login view test', () {
    testWidgets("should be defined", (tester) async {
      await setMockLoginScreen(tester);
      expect(loginScreen, isNotNull);

      await tester.tap(find.byKey(const Key('flat_button_login')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('flat_button_register')));
      await tester.pumpAndSettle();

      final emailInput = tester.widget<TextFormFieldCustom>(
          find.byKey(const Key('email_text_field')));
      expect(emailInput.labelText, 'メールアドレス ');

      final passwordInput = tester.widget<TextFormFieldCustom>(
          find.byKey(const Key('password_text_field')));
      expect(passwordInput.labelText, 'パスワード ');
    });

    testWidgets("Action email change test ", (tester) async {
      await setMockLoginScreen(tester);
      final emailInput = tester.widget<TextFormFieldCustom>(
          find.byKey(const Key('email_text_field')));
      expect(emailInput.labelText, 'メールアドレス ');

      await tester.enterText(find.byKey(const Key('email_text_field')), 'test');
      await tester.pumpAndSettle();
      expect(find.text('test'), findsOneWidget);
    });
  });
}
