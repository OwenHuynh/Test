import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DistrictForm extends HookWidget {
  DistrictForm({required this.submitCallback});

  final Function(String name, String url) submitCallback;

  @override
  Widget build(BuildContext context) {
    final viewModel = useDistrictViewModel(context);
    return BaseDialog(
      titleText: Localy.of(context)!.addDistrict,
      contentWidget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormFieldCustom(
              enabled: true,
              labelText: Localy.of(context)!.district,
              onChanged: viewModel.onDistrictNameChange,
              errorText: viewModel.state.districtNameError,
              keyboardType: TextInputType.name,
            ),
            TextFormFieldCustom(
              enabled: true,
              labelText: Localy.of(context)!.urlDistrict,
              onChanged: viewModel.onDistrictUrlChange,
              errorText: viewModel.state.districtUrlError,
              keyboardType: TextInputType.url,
            ),
            SpacingAlias.SizeHeight10,
            FlatButtonComponent(
              onPressed: () {
                submitCallback(
                    viewModel.state.districtName, viewModel.state.districtUrl);
              },
              title: Localy.of(context)!.addDistrict,
              enabled: viewModel.isValidated,
            )
          ],
        ),
      ),
    );
  }
}
