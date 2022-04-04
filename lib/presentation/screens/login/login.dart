import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/application/application.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/login/login.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
      converter: StoresSelector.fromStore,
      builder: (context, state) {
        return LoginBody();
      },
    );
  }
}

class LoginBody extends HookWidget {
  const LoginBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = useLoginViewModel(context);

    return BaseScaffold(
        padding: EdgeInsets.only(
            left: SpacingAlias.Spacing16,
            top: SpacingAlias.Spacing12,
            right: SpacingAlias.Spacing16),
        tapOutsideDismissKeyboard: true,
        useSingleChildScrollView: true,
        isScroll: true,
        appBar: AppBarText(Localy.of(context)!.loginText),
        children: [
          SpacingAlias.SizeHeight44,
          TextFormFieldCustom(
              key: Key("email_text_field"),
              enabled: true,
              labelText: Localy.of(context)!.registerScreenLabelEmail,
              onChanged: viewModel.onEmailChange,
              suffixIcon: const SizedBox.shrink(),
              errorText: viewModel.state.emailError ?? null),
          TextFormFieldCustom(
              key: Key("password_text_field"),
              enabled: true,
              obscureText: true,
              labelText: Localy.of(context)!.registerScreenLabelPassword,
              onChanged: viewModel.onPasswordChange,
              suffixIcon: const SizedBox.shrink(),
              errorText: viewModel.state.passwordError ?? null),
          SpacingAlias.SizeHeight32,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: FlatButtonComponent(
                key: Key("flat_button_login"),
                onPressed: viewModel.login,
                title: Localy.of(context)!.loginText,
              )),
              SpacingAlias.SizeWidth8,
              Expanded(
                  child: FlatButtonOutlinedComponent(
                key: Key("flat_button_register"),
                onPressed: AppNavigation.onRegisterScreen,
                title: Localy.of(context)!.registerScreenSubmitButtonTitle,
              )),
            ],
          ),
        ]);
  }
}
