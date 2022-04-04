import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/presentation/screens/district_list/district_list.types.dart';
import 'package:portal/presentation/screens/district_list/district_list.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/district_utils.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DistrictListScreen extends HookWidget {
  const DistrictListScreen({Key? key, required this.isRegister})
      : super(key: key);

  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
        converter: StoresSelector.fromStore,
        builder: (context, state) {
          return DistrictListBody(state, isRegister: isRegister);
        });
  }
}

class DistrictListBody extends HookWidget {
  const DistrictListBody(this.state, {required this.isRegister});

  final StoresSelector state;
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        useDistrictListViewModel(context, state.districtState.listDistrict);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isRegister
              ? Localy.of(context)!.selectDistrictTitle
              : Localy.of(context)!.serviceCityTitle,
          textAlign: TextAlign.center,
        ),
        // actions: isRegister
        //     ? []
        //     : [
        //         IconButton(
        //             onPressed: () {
        //               showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return DistrictForm(
        //                         submitCallback: viewModel.onStoreDistrict);
        //                   });
        //             },
        //             icon: Icon(Icons.add)),
        //       ],
      ),
      body: FixedStickyScrollView(
        padding: EdgeInsets.symmetric(vertical: SpacingAlias.Spacing8),
        bottomButton: !isRegister && !viewModel.isChangedDistrict
            ? null
            : FlatButtonComponent(
                title: Localy.of(context)!.selectDistrictButton,
                onPressed: () => viewModel.onConfirmDistrict(isRegister),
              ),
        children: [
          Padding(
            padding: const EdgeInsets.all(SpacingAlias.Spacing16),
            child: Text(
              "サービスを利用する市区町村を選択してください",
              style:
                  TextStyleCommon().generateTextStyle().copyWith(fontSize: 17),
            ),
          ),
          SearchInputText(
            onTextChange: viewModel.onTextChange,
            hintText: Localy.of(context)!.searchText,
          ),
          SpacingAlias.SizeHeight10,
          state.districtState.listDistrict.isEmpty
              ? Center(
                  child: Text(Localy.of(context)!.emptyDistrict),
                )
              : _buildListDistrict(
                  state: state, viewModel: viewModel, context: context),
        ],
      ),
    );
  }

  Widget _buildListDistrict(
      {required StoresSelector state,
      required DistrictListViewModel viewModel,
      required BuildContext context}) {
    return viewModel.districtList.length != 0
        ? ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${viewModel.districtList[index].name}"),
                subtitle: Text("${viewModel.districtList[index].url}"),
                leading: Radio<DistrictModel>(
                  key: Key(index.toString()),
                  onChanged: viewModel.onChangeDistrict,
                  groupValue: DistrictUtils.groupDistrict(
                      viewModel.selectedDistrict,
                      viewModel.districtList[index]),
                  value: viewModel.districtList[index],
                ),
                // trailing:
                //     state.districtState.listDistrict.length == 1
                //     || isRegister
                //         ? null
                //         : IconButton(
                //             icon: Icon(
                //               Icons.delete,
                //               color: Colors.red,
                //             ),
                //             onPressed: () {
                //               viewModel.onDeleteDistrictAtPosition(
                //                   viewModel.districtList[index]);
                //             },
                //           ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: viewModel.districtList.length)
        : Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(Localy.of(context)!.emptySearchText),
            ),
          );
  }
}
