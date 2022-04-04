import 'package:portal/domain/repositories/auth_repository/auth_repository.dart';
import 'package:portal/shared/utils/async_action_listener.dart';
import 'package:portal/state-management/actions/auth_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:redux/src/store.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> login(
      {required Store<AppState> store,
      required String email,
      required String password,
      required AsyncActionListener listener}) async {
    store.dispatch(
        UserLoginRequest(listener: listener, email: email, password: password));
  }
}
