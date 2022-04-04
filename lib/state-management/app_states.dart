import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:portal/state-management/states/auth_state.dart';
import 'package:portal/state-management/states/district_state.dart';

part 'app_states.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState(
      {required AuthState authState, required DistrictState districtState}) {
    return _$AppState._(
      authState: authState,
      districtState: districtState,
    );
  }

  factory AppState.initial() {
    return _$AppState._(
      authState: AuthState.initial(),
      districtState: DistrictState.initial(),
    );
  }

  AppState._();

  @override
  @memoized
  int get hashCode;

  AuthState get authState;

  DistrictState get districtState;

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
