import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.actions.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.reducers.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.state.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.types.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.validate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

DistrictFormViewModel useDistrictViewModel(BuildContext context) {
  final asReducer = useReducer<DistrictFormState, DistrictFormActions?>(
    districtFormReducers,
    initialState: DistrictFormState.initial(),
    initialAction: null,
  );
  final isFormValid = useCallback(() {
    return DistrictFormValidationResults(context).validateForm(
        asReducer.state.districtName, asReducer.state.districtUrl);
  }, [context, asReducer.state]);

  final isValidate = useState<bool>(false);

  final onDistrictNameChange = useCallback((String districtName) {
    asReducer
        .dispatch(OnChangeDistrictName(context, districtName: districtName));
    isValidate.value = isFormValid();
  }, [asReducer, context, isFormValid]);

  final onDistrictUrlChange = useCallback((String districtUrl) {
    asReducer.dispatch(OnChangeDistrictUrl(context, districtUrl: districtUrl));
    isValidate.value = isFormValid();
  }, [asReducer, context, isFormValid]);

  return DistrictFormViewModel(
    state: asReducer.state,
    onDistrictNameChange: onDistrictNameChange,
    onDistrictUrlChange: onDistrictUrlChange,
    isValidated: isValidate.value,
  );
}
