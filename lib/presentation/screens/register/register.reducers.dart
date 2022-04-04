import 'package:portal/presentation/screens/register/register.actions.dart';
import 'package:portal/presentation/screens/register/register.state.dart';
import 'package:portal/presentation/screens/register/register.validate.dart';
import 'package:redux/redux.dart';

RegisterState registerReducers(RegisterState state, RegisterActions? action) {
  final appReducer = combineReducers<RegisterState>([
    TypedReducer<RegisterState, OnChangeEmail>(_setEmailChange),
    TypedReducer<RegisterState, OnChangePassword>(_setPasswordChange),
    TypedReducer<RegisterState, OnChangeConfirmPassword>(
        _setConfirmPasswordChange),
    TypedReducer<RegisterState, OnCheckTerns>(_setCheckTerns),
    TypedReducer<RegisterState, OnCheckPrivacy>(_setCheckPrivacy),
  ]);

  return appReducer.call(state, action);
}

RegisterState _setEmailChange(RegisterState state, OnChangeEmail action) {
  final emailError = RegisterScreenValidationResults(action.context)
      .validateEmail(action.email)
      .errorMessage;

  return state.rebuild((b) => b
    ..email = action.email
    ..emailError = emailError);
}

RegisterState _setPasswordChange(RegisterState state, OnChangePassword action) {
  final passwordError = RegisterScreenValidationResults(action.context)
      .validatePassword(action.password)
      .errorMessage;

  return state.rebuild((b) => b
    ..password = action.password
    ..passwordError = passwordError);
}

RegisterState _setConfirmPasswordChange(
    RegisterState state, OnChangeConfirmPassword action) {
  final passwordConfirmError = RegisterScreenValidationResults(action.context)
      .validateConfirmPassword(action.password, action.confirmPassword)
      .errorMessage;

  return state.rebuild((b) => b
    ..confirmPassword = action.confirmPassword
    ..confirmPasswordError = passwordConfirmError);
}

RegisterState _setCheckTerns(RegisterState state, OnCheckTerns action) {
  return state.rebuild((b) => b..ternCheck = action.ternCheck);
}

RegisterState _setCheckPrivacy(RegisterState state, OnCheckPrivacy action) {
  return state.rebuild((b) => b..privacyCheck = action.privacyCheck);
}
