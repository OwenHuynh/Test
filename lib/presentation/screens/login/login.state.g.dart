// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LoginState> _$loginStateSerializer = new _$LoginStateSerializer();

class _$LoginStateSerializer implements StructuredSerializer<LoginState> {
  @override
  final Iterable<Type> types = const [LoginState, _$LoginState];
  @override
  final String wireName = 'LoginState';

  @override
  Iterable<Object?> serialize(Serializers serializers, LoginState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
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
    return result;
  }

  @override
  LoginState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginStateBuilder();

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
      }
    }

    return result.build();
  }
}

class _$LoginState extends LoginState {
  @override
  final String email;
  @override
  final String? emailError;
  @override
  final String password;
  @override
  final String? passwordError;

  factory _$LoginState([void Function(LoginStateBuilder)? updates]) =>
      (new LoginStateBuilder()..update(updates)).build();

  _$LoginState._(
      {required this.email,
      this.emailError,
      required this.password,
      this.passwordError})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'LoginState', 'email');
    BuiltValueNullFieldError.checkNotNull(password, 'LoginState', 'password');
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState &&
        email == other.email &&
        emailError == other.emailError &&
        password == other.password &&
        passwordError == other.passwordError;
  }

  int? __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc($jc(0, email.hashCode), emailError.hashCode),
            password.hashCode),
        passwordError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginState')
          ..add('email', email)
          ..add('emailError', emailError)
          ..add('password', password)
          ..add('passwordError', passwordError))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState? _$v;

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

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _emailError = $v.emailError;
      _password = $v.password;
      _passwordError = $v.passwordError;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginState build() {
    final _$result = _$v ??
        new _$LoginState._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'LoginState', 'email'),
            emailError: emailError,
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'LoginState', 'password'),
            passwordError: passwordError);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
