import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/login/login.actions.dart';
import 'package:portal/presentation/screens/login/login.reducers.dart';
import 'package:portal/presentation/screens/login/login.state.dart';
import 'package:portal/presentation/screens/login/login.types.dart';
import 'package:portal/presentation/screens/login/login.validate.dart';
import 'package:portal/shared/hooks/hooks.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/async_action_listener.dart';
import 'package:portal/shared/utils/ui_utils.dart';
import 'package:portal/state-management/actions/district_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

LoginViewModel useLoginViewModel(BuildContext context) {
  final store = StoreProvider.of<AppState>(context);
  // final authRepository = getIt<AuthRepository>();

  final asReducer = useReducer<LoginState, LoginActions?>(
    loginReducers,
    initialState: LoginState(),
    initialAction: null,
  );

  final onLoadDistrict = useCallback(() async {
    store.dispatch(DistrictListRequest(
        listener: AsyncActionListener(
            onStart: () {}, onSuccess: () {}, onError: (e) {})));
  }, [store]);

  useMount(onLoadDistrict);

  final onEmailChange = useCallback((String email) {
    asReducer.dispatch(OnChangeEmail(context, email: email));
  }, [asReducer, context]);

  final onPasswordChange = useCallback((String email) {
    asReducer.dispatch(OnChangePassword(context, password: email));
  }, [asReducer, context]);

  final isFormValid = useCallback(() {
    return LoginScreenValidationResults(context).validateForm(asReducer.state);
  }, [asReducer.state, context]);

  final login = useCallback(() async {
    if (!isFormValid()) {
      UIUtils.showErrorMessage(context, Localy.of(context)!.loginSubmitError);
      return;
    }

    // await authRepository.login(
    //     store: store,
    //     email: asReducer.state.email,
    //     password: asReducer.state.password,
    //     listener: AsyncActionListener(onStart: () {
    //       UIUtils.showLoading(context);
    //     }, onSuccess: ([_]) {
    //       UIUtils.hideLoading(context);
    //       AppNavigation.onNavigateToHome();
    //     }, onError: (HttpServiceException error) {
    //       UIUtils.hideLoading(context);
    //       UIUtils.showErrorMessage(
    //       context, ErrorConverterString.parseError(context, error: error));
    //     }));
    AppNavigation.onNavigateToHome();
  }, [isFormValid, context, Localy]);

  return LoginViewModel(
      state: asReducer.state,
      isFormValid: isFormValid(),
      onLoadDistrict: onLoadDistrict,
      onEmailChange: onEmailChange,
      onPasswordChange: onPasswordChange,
      login: login);
}
