import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/reducers/auth_reducer.dart';
import 'package:portal/state-management/reducers/district_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      districtState: districtReducer(state.districtState, action));
}
