// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RegisterState> _$registerStateSerializer =
    new _$RegisterStateSerializer();

class _$RegisterStateSerializer implements StructuredSerializer<RegisterState> {
  @override
  final Iterable<Type> types = const [RegisterState, _$RegisterState];
  @override
  final String wireName = 'RegisterState';

  @override
  Iterable<Object?> serialize(Serializers serializers, RegisterState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'confirmPassword',
      serializers.serialize(object.confirmPassword,
          specifiedType: const FullType(String)),
      'ternCheck',
      serializers.serialize(object.ternCheck,
          specifiedType: const FullType(bool)),
      'privacyCheck',
      serializers.serialize(object.privacyCheck,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.emailError;
    if (value != null) {
      result
        ..add('emailError')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.passwordError;
    if (value != null) {
      result
        ..add('passwordError')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.confirmPasswordError;
    if (value != null) {
      result
        ..add('confirmPasswordError')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  RegisterState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RegisterStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'emailError':
          result.emailError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'passwordError':
          result.passwordError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'confirmPassword':
          result.confirmPassword = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'confirmPasswordError':
          result.confirmPasswordError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'ternCheck':
          result.ternCheck = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'privacyCheck':
          result.privacyCheck = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$RegisterState extends RegisterState {
  @override
  final String email;
  @override
  final String? emailError;
  @override
  final String password;
  @override
  final String? passwordError;
  @override
  final String confirmPassword;
  @override
  final String? confirmPasswordError;
  @override
  final bool ternCheck;
  @override
  final bool privacyCheck;

  factory _$RegisterState([void Function(RegisterStateBuilder)? updates]) =>
      (new RegisterStateBuilder()..update(updates)).build();

  _$RegisterState._(
      {required this.email,
      this.emailError,
      required this.password,
      this.passwordError,
      required this.confirmPassword,
      this.confirmPasswordError,
      required this.ternCheck,
      required this.privacyCheck})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'RegisterState', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, 'RegisterState', 'password');
    BuiltValueNullFieldError.checkNotNull(
        confirmPassword, 'RegisterState', 'confirmPassword');
    BuiltValueNullFieldError.checkNotNull(
        ternCheck, 'RegisterState', 'ternCheck');
    BuiltValueNullFieldError.checkNotNull(
        privacyCheck, 'RegisterState', 'privacyCheck');
  }

  @override
  RegisterState rebuild(void Function(RegisterStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterStateBuilder toBuilder() => new RegisterStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterState &&
        email == other.email &&
        emailError == other.emailError &&
        password == other.password &&
        passwordError == other.passwordError &&
        confirmPassword == other.confirmPassword &&
        confirmPasswordError == other.confirmPasswordError &&
        ternCheck == other.ternCheck &&
        privacyCheck == other.privacyCheck;
  }

  int? __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, email.hashCode), emailError.hashCode),
                            password.hashCode),
                        passwordError.hashCode),
                    confirmPassword.hashCode),
                confirmPasswordError.hashCode),
            ternCheck.hashCode),
        privacyCheck.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegisterState')
          ..add('email', email)
          ..add('emailError', emailError)
          ..add('password', password)
          ..add('passwordError', passwordError)
          ..add('confirmPassword', confirmPassword)
          ..add('confirmPasswordError', confirmPasswordError)
          ..add('ternCheck', ternCheck)
          ..add('privacyCheck', privacyCheck))
        .toString();
  }
}

class RegisterStateBuilder
    implements Builder<RegisterState, RegisterStateBuilder> {
  _$RegisterState? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _emailError;
  String? get emailError => _$this._emailError;
  set emailError(String? emailError) => _$this._emailError = emailError;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _passwordError;
  String? get passwordError => _$this._passwordError;
  set passwordError(String? passwordError) =>
      _$this._passwordError = passwordError;

  String? _confirmPassword;
  String? get confirmPassword => _$this._confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _$this._confirmPassword = confirmPassword;

  String? _confirmPasswordError;
  String? get confirmPasswordError => _$this._confirmPasswordError;
  set confirmPasswordError(String? confirmPasswordError) =>
      _$this._confirmPasswordError = confirmPasswordError;

  bool? _ternCheck;
  bool? get ternCheck => _$this._ternCheck;
  set ternCheck(bool? ternCheck) => _$this._ternCheck = ternCheck;

  bool? _privacyCheck;
  bool? get privacyCheck => _$this._privacyCheck;
  set privacyCheck(bool? privacyCheck) => _$this._privacyCheck = privacyCheck;

  RegisterStateBuilder();

  RegisterStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _emailError = $v.emailError;
      _password = $v.password;
      _passwordError = $v.passwordError;
      _confirmPassword = $v.confirmPassword;
      _confirmPasswordError = $v.confirmPasswordError;
      _ternCheck = $v.ternCheck;
      _privacyCheck = $v.privacyCheck;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterState;
  }

  @override
  void update(void Function(RegisterStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RegisterState build() {
    final _$result = _$v ??
        new _$RegisterState._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'RegisterState', 'email'),
            emailError: emailError,
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'RegisterState', 'password'),
            passwordError: passwordError,
            confirmPassword: BuiltValueNullFieldError.checkNotNull(
                confirmPassword, 'RegisterState', 'confirmPassword'),
            confirmPasswordError: confirmPasswordError,
            ternCheck: BuiltValueNullFieldError.checkNotNull(
                ternCheck, 'RegisterState', 'ternCheck'),
            privacyCheck: BuiltValueNullFieldError.checkNotNull(
                privacyCheck, 'RegisterState', 'privacyCheck'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
