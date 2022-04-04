import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login.state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  factory LoginState() {
    return _$LoginState._(
        email: "", emailError: null, password: "", passwordError: null);
  }

  LoginState._();

  @override
  @memoized
  int get hashCode;

  String get email;

  String? get emailError;

  String get password;

  String? get passwordError;

  static Serializer<LoginState> get serializer => _$loginStateSerializer;
}
