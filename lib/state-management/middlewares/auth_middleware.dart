import 'package:portal/data/remotes/services/auth/auth_service.dart';
import 'package:portal/state-management/actions/auth_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:net_module/net_module.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreAuthMiddleware() {
  final onUserLoginRequest = _onUserLoginRequest();

  return [
    TypedMiddleware<AppState, UserLoginRequest>(onUserLoginRequest),
  ];
}

Middleware<AppState> _onUserLoginRequest() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as UserLoginRequest;

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api-nodejs-todolist.herokuapp.com',
      ),
    );

    try {
      action.listener.onStart();
      final service = AuthService(dio);
      final result =
          await service.login(email: action.email, password: action.password);

      action.listener.onSuccess();
      store.dispatch(UserLoginSuccess(
          listener: action.listener, user: result.user, token: result.token));
    } on HttpServiceException catch (e) {
      action.listener.onError(e);
      store.dispatch(UserLoginFailure(errorMessage: e.toString()));
    }
  };
}
