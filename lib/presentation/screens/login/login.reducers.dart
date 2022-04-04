import 'package:portal/presentation/screens/login/login.actions.dart';
import 'package:portal/presentation/screens/login/login.state.dart';
import 'package:portal/presentation/screens/login/login.validate.dart';
import 'package:redux/redux.dart';

LoginState loginReducers(LoginState state, LoginActions? action) {
  final appReducer = combineReducers<LoginState>([
    TypedReducer<LoginState, OnChangeEmail>(_setEmailChange),
    TypedReducer<LoginState, OnChangePassword>(_setPasswordChange),
  ]);

  return appReducer.call(state, action);
}

LoginState _setEmailChange(LoginState state, OnChangeEmail action) {
  final emailError = LoginScreenValidationResults(action.context)
      .validateEmail(action.email)
      .errorMessage;

  return state.rebuild((b) => b
    ..email = action.email
    ..emailError = emailError);
}

LoginState _setPasswordChange(LoginState state, OnChangePassword action) {
  final passwordError = LoginScreenValidationResults(action.context)
      .validatePassword(action.password)
      .errorMessage;

  return state.rebuild((b) => b
    ..password = action.password
    ..passwordError = passwordError);
}
