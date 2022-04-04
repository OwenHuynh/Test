import 'package:portal/data/remotes/responses/auth/auth_response.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/states/district_state.dart';
import 'package:redux/redux.dart';

class StoresSelector {
  StoresSelector({this.user, this.token, required this.districtState});

  static StoresSelector fromStore(Store<AppState> store) {
    final state = store.state;

    return StoresSelector(
      user: state.authState.user,
      token: state.authState.token,
      districtState: state.districtState,
    );
  }

  UserResponse? user;
  String? token;
  DistrictState districtState;
}
