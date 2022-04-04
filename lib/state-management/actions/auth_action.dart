import 'package:equatable/equatable.dart';
import 'package:portal/data/remotes/responses/auth/auth_response.dart';
import 'package:portal/shared/utils/async_action_listener.dart';

abstract class AuthAction extends Equatable {
  const AuthAction();

  @override
  List<Object?> get props => [];
}

class UserLoginRequest extends AuthAction {
  UserLoginRequest(
      {required this.listener, required this.email, required this.password});

  final AsyncActionListener listener;
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class UserLoginSuccess extends AuthAction {
  UserLoginSuccess(
      {required this.listener, required this.user, required this.token});

  final AsyncActionListener listener;
  final UserResponse user;
  final String token;

  @override
  List<Object> get props => [user, token];
}

class UserLoginFailure extends AuthAction {
  UserLoginFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
