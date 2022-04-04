import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/application/application.dart';
import 'package:portal/presentation/screens/register/register.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
      converter: StoresSelector.fromStore,
      builder: (context, state) {
        return RegisterBody();
      },
    );
  }
}

class RegisterBody extends HookWidget {
  const RegisterBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = useRegisterViewModel(context);

    return Scaffold(
        appBar: AppBarText(Localy.of(context)!.registerScreenLabelAppBarTitle),
        body: FixedStickyScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: SpacingAlias.Spacing16,
              vertical: SpacingAlias.Spacing8),
          tapOutsideDismissKeyboard: true,
          bottomButton: FlatButtonComponent(
            onPressed: viewModel.register,
            title: Localy.of(context)!.registerScreenSubmitButtonTitle,
            enabled: viewModel.isFormValid,
          ),
          children: [
            _buildTextLabel(context,
                textLabel: Localy.of(context)!.registerScreenLabelEmail),
            TextFormFieldCustom(
              enabled: true,
              labelText: Localy.of(context)!.loginScreenLabelEmailErrorMessage,
              onChanged: viewModel.onEmailChange,
              suffixIcon: const SizedBox.shrink(),
              errorText: viewModel.state.emailError ?? null,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            SpacingAlias.SizeHeight8,
            _buildTextLabel(context,
                textLabel: Localy.of(context)!.registerScreenLabelPassword),
            TextFormFieldCustom(
              enabled: true,
              obscureText: true,
              labelText:
                  Localy.of(context)!.loginScreenLabelPasswordErrorMessage,
              onChanged: viewModel.onPasswordChange,
              suffixIcon: const SizedBox.shrink(),
              errorText: viewModel.state.passwordError ?? null,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            SpacingAlias.SizeHeight8,
            _buildTextLabel(context,
                textLabel:
                    Localy.of(context)!.registerScreenLabelConfirmPassword),
            TextFormFieldCustom(
              enabled: true,
              obscureText: true,
              labelText:
                  Localy.of(context)!.loginScreenLabelPasswordErrorMessage,
              onChanged: viewModel.onConfirmPasswordChange,
              suffixIcon: const SizedBox.shrink(),
              errorText: viewModel.state.confirmPasswordError ?? null,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            Divider(
              height: SpacingAlias.Spacing32,
              thickness: 1,
              color: AppColors.grey1,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Localy.of(context)!.registerScreenConfirmedLabelText,
                    style: AppStyles.titleStyle.generateTextStyle().copyWith(
                          color: AppColors.colorTextImportant,
                        ),
                  ),
                ],
              ),
            ),
            _buildCheckBox(
                textLabel: Localy.of(context)!.termTitle,
                value: viewModel.state.ternCheck,
                onChanged: viewModel.onTernCheck,
                onTap: viewModel.onNavigateToTernPage),
            _buildCheckBox(
                textLabel: Localy.of(context)!.privacyTitle,
                value: viewModel.state.privacyCheck,
                onChanged: viewModel.onPrivacyCheck,
                onTap: viewModel.onNavigateToPrivacyPage),
          ],
        ));
  }

  Widget _buildTextLabel(BuildContext context, {required String textLabel}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: textLabel,
              style: AppStyles.titleStyle.generateTextStyle().copyWith(
                    color: AppColors.colorTextImportant,
                  )),
          TextSpan(
            text: Localy.of(context)!.requiredText,
            style: AppStyles.titleStyle
                .generateTextStyle()
                .copyWith(color: AppColors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBox(
      {required String textLabel,
      required bool value,
      required Function(bool?) onChanged,
      required Function() onTap}) {
    return CheckboxListTile(
      tileColor: AppColors.white,
      title: InkWell(
          onTap: onTap,
          child: Text(
            textLabel,
            style: AppStyles.titleStyle.generateTextStyle().copyWith(
                  color: AppColors.colorLink,
                ),
          )),
      value: value,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: onChanged,
      contentPadding: EdgeInsets.all(0),
    );
  }
}
