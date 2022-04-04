import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/mock/mock_html_policy.dart';
import 'package:portal/data/mock/mock_html_terms.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/register/register.actions.dart';
import 'package:portal/presentation/screens/register/register.reducers.dart';
import 'package:portal/presentation/screens/register/register.state.dart';
import 'package:portal/presentation/screens/register/register.types.dart';
import 'package:portal/presentation/screens/register/register.validate.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/ui_utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

RegisterViewModel useRegisterViewModel(BuildContext context) {
  final asReducer = useReducer<RegisterState, RegisterActions?>(
    registerReducers,
    initialState: RegisterState(),
    initialAction: null,
  );

  final onEmailChange = useCallback((String email) {
    asReducer.dispatch(OnChangeEmail(context, email: email));
  }, [asReducer, context]);

  final onPasswordChange = useCallback((String email) {
    asReducer.dispatch(OnChangePassword(context, password: email));
  }, [asReducer, context]);

  final onConfirmPasswordChange = useCallback((String confirmPass) {
    asReducer.dispatch(OnChangeConfirmPassword(context,
        password: asReducer.state.password, confirmPassword: confirmPass));
  }, [asReducer, context]);

  final isFormValid = useCallback(() {
    return RegisterScreenValidationResults(context)
        .validateForm(asReducer.state);
  }, [asReducer.state, context]);

  final register = useCallback(() async {
    if (!isFormValid()) {
      UIUtils.showErrorMessage(context, Localy.of(context)!.loginSubmitError);
      return;
    }
    AppNavigation.onNavigateToDistrictList(isRegister: true);
  }, [isFormValid, context, Localy]);

  final onTernCheck = useCallback((bool? value) {
    asReducer.dispatch(OnCheckTerns(context, ternCheck: value!));
  }, [asReducer, context]);

  final onPrivacyCheck = useCallback((bool? value) {
    asReducer.dispatch(OnCheckPrivacy(context, privacyCheck: value!));
  }, [asReducer, context]);

  final onNavigateToPrivacyPage = useCallback(
      () => AppNavigation.onPrivacyScreen(
          title: Localy.of(context)!.privacyTitle, content: htmlPolicy),
      [Localy]);

  final onNavigateToTernPage = useCallback(
      () => AppNavigation.onPrivacyScreen(
          title: Localy.of(context)!.termTitle, content: htmlTerms),
      [Localy]);

  return RegisterViewModel(
      state: asReducer.state,
      isFormValid: isFormValid(),
      onEmailChange: onEmailChange,
      onPasswordChange: onPasswordChange,
      onConfirmPasswordChange: onConfirmPasswordChange,
      register: register,
      onTernCheck: onTernCheck,
      onPrivacyCheck: onPrivacyCheck,
      onNavigateToPrivacyPage: onNavigateToPrivacyPage,
      onNavigateToTernPage: onNavigateToTernPage);
}
