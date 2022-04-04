import 'package:cores/utils/validate_utils.dart';
import 'package:flutter/material.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/validation/validation_result.dart';

class DistrictFormValidationResults {
  DistrictFormValidationResults(BuildContext context) {
    this.context = context;
  }

  late BuildContext context;

  ValidationResult validateDistrictName(String name) {
    if (ValidateUtils.isNullEmptyOrWhitespace(name)) {
      return ValidationResult.error(
        Localy.of(context)!.districtNameErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  ValidationResult validateDistrictUrl(String url) {
    if (ValidateUtils.isNullEmptyOrWhitespace(url)) {
      return ValidationResult.error(
        Localy.of(context)!.districtUrlErrorEmptyMessage,
      );
    }
    if (!ValidateUtils.isUrl(url)) {
      return ValidationResult.error(
        Localy.of(context)!.districtUrlErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  bool validateForm(String districtName, String districtUrl) {
    final districtNameValid = validateDistrictName(districtName).isValid;
    final districtUrlValid = validateDistrictUrl(districtUrl).isValid;

    return districtNameValid && districtUrlValid;
  }
}
