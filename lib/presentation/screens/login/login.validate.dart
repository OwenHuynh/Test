import 'package:cores/utils/validate_utils.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/login/login.state.dart';
import 'package:portal/shared/validation/validation_result.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';

class LoginScreenValidationResults {
  LoginScreenValidationResults(BuildContext context) {
    this.context = context;
  }

  late BuildContext context;

  ValidationResult validateEmail(String email) {
    if (ValidateUtils.isNullEmptyOrWhitespace(email)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelEmailErrorMessage,
      );
    } else if (!ValidateUtils.validateEmail(email)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelEmailTypeErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  ValidationResult validatePassword(String password) {
    if (ValidateUtils.isNullEmptyOrWhitespace(password)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelPasswordErrorMessage,
      );
    }
    if (password.length < 6) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelPasswordLengthErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  bool validateForm(LoginState state) {
    final emailValid = validateEmail(state.email).isValid;
    final passwordValid = validatePassword(state.password).isValid;

    return emailValid && passwordValid;
  }
}
