import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginActions extends Equatable {
  LoginActions({required this.context});

  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class OnChangeEmail extends LoginActions {
  OnChangeEmail(BuildContext context, {required this.email})
      : super(context: context);

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'OnChangeEmail { email: $email }';
}

class OnChangePassword extends LoginActions {
  OnChangePassword(BuildContext context, {required this.password})
      : super(context: context);

  final String password;

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'OnChangePassword { password: $password }';
}
