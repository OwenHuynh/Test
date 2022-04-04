import 'package:portal/presentation/screens/district_list/component/district_form.actions.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.state.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.validate.dart';
import 'package:redux/redux.dart';

DistrictFormState districtFormReducers(
    DistrictFormState state, DistrictFormActions? action) {
  final appReducer = combineReducers<DistrictFormState>([
    TypedReducer<DistrictFormState, OnChangeAddress>(_setAddressChange),
    TypedReducer<DistrictFormState, OnChangeDistrictName>(
        _setDistrictNameChange),
    TypedReducer<DistrictFormState, OnChangeDistrictUrl>(_setDistrictUrlChange),
  ]);

  return appReducer.call(state, action);
}

DistrictFormState _setAddressChange(
    DistrictFormState state, OnChangeAddress action) {
  return state.rebuild((b) => b..address = action.address);
}

DistrictFormState _setDistrictNameChange(
    DistrictFormState state, OnChangeDistrictName action) {
  final districtNameError = DistrictFormValidationResults(action.context)
      .validateDistrictName(action.districtName)
      .errorMessage;

  return state.rebuild((b) => b
    ..districtName = action.districtName
    ..districtNameError = districtNameError);
}

DistrictFormState _setDistrictUrlChange(
    DistrictFormState state, OnChangeDistrictUrl action) {
  final districtUrlError = DistrictFormValidationResults(action.context)
      .validateDistrictUrl(action.districtUrl)
      .errorMessage;
  return state.rebuild((b) => b
    ..districtUrl = action.districtUrl
    ..districtUrlError = districtUrlError);
}
