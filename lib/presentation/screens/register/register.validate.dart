import 'package:cores/utils/validate_utils.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/register/register.state.dart';
import 'package:portal/shared/validation/validation_result.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';

class RegisterScreenValidationResults {
  RegisterScreenValidationResults(BuildContext context) {
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

  ValidationResult validateConfirmPassword(
      String password, String confirmPassword) {
    if (ValidateUtils.isNullEmptyOrWhitespace(password)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelPasswordErrorMessage,
      );
    }
    if (password != confirmPassword) {
      return ValidationResult.error(
        Localy.of(context)!.registerScreenLabelPasswordErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  bool validateForm(RegisterState state) {
    final emailValid = validateEmail(state.email).isValid;
    final passwordValid = validatePassword(state.password).isValid;
    final confirmPasswordValid =
        validateConfirmPassword(state.password, state.confirmPassword).isValid;

    return emailValid &&
        passwordValid &&
        confirmPasswordValid &&
        state.ternCheck &&
        state.privacyCheck;
  }
}
