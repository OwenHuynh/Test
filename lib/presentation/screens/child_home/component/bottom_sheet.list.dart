import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/presentation/screens/child_home/component/bottom_sheet.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/district_utils.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BottomSheetWidget extends HookWidget {
  BottomSheetWidget(
      {required this.onChangedDistrict, required this.selectedDistrict});

  final Function(DistrictModel? district) onChangedDistrict;
  final DistrictModel selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
        converter: StoresSelector.fromStore,
        builder: (context, state) {
          return BottomSheetBody(state, onChangedDistrict: onChangedDistrict);
        });
  }
}

class BottomSheetBody extends HookWidget {
  BottomSheetBody(this.state, {required this.onChangedDistrict});

  final StoresSelector state;
  final Function(DistrictModel? district) onChangedDistrict;

  @override
  Widget build(BuildContext context) {
    final bottomSheetViewModel =
        useBottomSheetViewModel(context, state.districtState.listDistrict);

    return Column(
      children: [
        SearchInputText(
          onTextChange: bottomSheetViewModel.onTextChange,
          hintText: Localy.of(context)!.searchText,
        ),
        (bottomSheetViewModel.districtList.length > 0)
            ? ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return RadioListTile<DistrictModel>(
                    key: Key(index.toString()),
                    title: Text(
                        bottomSheetViewModel.districtList[index].name ?? ''),
                    subtitle: Text(
                        bottomSheetViewModel.districtList[index].url ?? ''),
                    selected: DistrictUtils.districtComparison(
                        state.districtState.currentDistrict,
                        bottomSheetViewModel.districtList[index]),
                    controlAffinity: ListTileControlAffinity.trailing,
                    tileColor: Colors.blue,
                    value: bottomSheetViewModel.districtList[index],
                    groupValue: DistrictUtils.groupDistrict(
                        state.districtState.currentDistrict,
                        bottomSheetViewModel.districtList[index]),
                    onChanged: onChangedDistrict,
                  );
                },
                itemCount: bottomSheetViewModel.districtList.length,
                separatorBuilder: (context, position) {
                  return Container();
                },
              )
            : Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(Localy.of(context)!.emptySearchText),
                ),
              ),
      ],
    );
  }
}
