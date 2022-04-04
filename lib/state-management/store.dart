import 'package:portal/state-management/app_reducers.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/middlewares/auth_middleware.dart';
import 'package:portal/state-management/middlewares/district_middleware.dart';
import 'package:portal/state-management/middlewares/logging_middleware/logging_middleware.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  return Store(appReducer,
      initialState: AppState.initial(),
      distinct: true,
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStoreDistrictMiddleware())
        ..addAll([
          LoggingMiddleware<dynamic>.printer(
            formatter: LoggingMiddleware.multiLineFormatter,
          ),
        ]));
}
