import 'package:portal/state-management/actions/auth_action.dart';
import 'package:portal/state-management/states/auth_state.dart';
import 'package:redux/redux.dart';

AuthState authReducer(AuthState state, dynamic action) {
  final appReducer = combineReducers<AuthState>([
    TypedReducer<AuthState, UserLoginRequest>(_onUserLoginRequest),
    TypedReducer<AuthState, UserLoginSuccess>(_onUserLoginSuccess),
    TypedReducer<AuthState, UserLoginFailure>(_onUserLoginFailure),
  ]);

  return appReducer.call(state, action);
}

AuthState _onUserLoginRequest(AuthState state, UserLoginRequest action) {
  return state.rebuild((b) => b
    ..user = null
    ..token = ""
    ..isAuthenticated = false);
}

AuthState _onUserLoginSuccess(AuthState state, UserLoginSuccess action) {
  return state.rebuild((b) => b
    ..user = action.user
    ..token = action.token
    ..isAuthenticated = true);
}

AuthState _onUserLoginFailure(AuthState state, UserLoginFailure action) {
  return state.rebuild((b) => b..isAuthenticated = false);
}
