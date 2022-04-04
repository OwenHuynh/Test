import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register.state.g.dart';

abstract class RegisterState
    implements Built<RegisterState, RegisterStateBuilder> {
  factory RegisterState() {
    return _$RegisterState._(
        email: "",
        emailError: null,
        password: "",
        passwordError: null,
        confirmPassword: "",
        confirmPasswordError: null,
        ternCheck: false,
        privacyCheck: false);
  }

  RegisterState._();

  @override
  @memoized
  int get hashCode;

  String get email;

  String? get emailError;

  String get password;

  String? get passwordError;

  String get confirmPassword;

  String? get confirmPasswordError;

  bool get ternCheck;

  bool get privacyCheck;

  static Serializer<RegisterState> get serializer => _$registerStateSerializer;
}
