import 'package:portal/shared/utils/async_action_listener.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:redux/redux.dart';

abstract class AuthRepository {
  Future<void> login({
    required Store<AppState> store,
    required String email,
    required String password,
    required AsyncActionListener listener,
  });
}
