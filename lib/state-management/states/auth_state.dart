import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:portal/data/remotes/responses/auth/auth_response.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  factory AuthState.initial() {
    return _$AuthState._(user: null, token: "", isAuthenticated: false);
  }

  AuthState._();

  @override
  @memoized
  int get hashCode;

  UserResponse? get user;

  bool get isAuthenticated;

  String? get token;

  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
