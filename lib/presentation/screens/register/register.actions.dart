import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterActions extends Equatable {
  RegisterActions({required this.context});

  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class OnChangeEmail extends RegisterActions {
  OnChangeEmail(BuildContext context, {required this.email})
      : super(context: context);

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'OnChangeEmail { email: $email }';
}

class OnChangePassword extends RegisterActions {
  OnChangePassword(BuildContext context, {required this.password})
      : super(context: context);

  final String password;

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'OnChangePassword { password: $password }';
}

class OnChangeConfirmPassword extends RegisterActions {
  OnChangeConfirmPassword(BuildContext context,
      {required this.password, required this.confirmPassword})
      : super(context: context);

  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [password, confirmPassword];

  @override
  String toString() => 'OnChangeConfirmPassword { password: $password,'
      ' confirmPassword: $confirmPassword }';
}

class OnCheckTerns extends RegisterActions {
  OnCheckTerns(BuildContext context, {required this.ternCheck})
      : super(context: context);

  final bool ternCheck;

  @override
  List<Object> get props => [ternCheck];

  @override
  String toString() => 'OnCheckTerns { ternCheck: $ternCheck }';
}

class OnCheckPrivacy extends RegisterActions {
  OnCheckPrivacy(BuildContext context, {required this.privacyCheck})
      : super(context: context);

  final bool privacyCheck;

  @override
  List<Object> get props => [privacyCheck];

  @override
  String toString() => 'OnCheckPrivacy { privacyCheck: $privacyCheck }';
}
