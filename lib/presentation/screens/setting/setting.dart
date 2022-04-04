import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/setting/setting.view_model.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SettingScreen extends HookWidget {
  const SettingScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
        converter: StoresSelector.fromStore,
        builder: (context, state) {
          return SettingBody(
            state,
            title: title,
          );
        });
  }
}

class SettingBody extends HookWidget {
  const SettingBody(this.state, {required this.title});

  final StoresSelector state;
  final String title;

  @override
  Widget build(BuildContext context) {
    final viewModel = useSettingViewModel(context);
    return BaseScaffold(
      isScroll: true,
      tapOutsideDismissKeyboard: true,
      useSingleChildScrollView: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actions: [],
      ),
      children: [
        SpacingAlias.SizeHeight32,
        CardItem(
          title: Localy.of(context)!.serviceCityTitle,
          itemTitleList: [
            state.districtState.currentDistrict.name ?? "",
          ],
          itemFunctions: [
            viewModel.onNavigateToDistrictListScreen,
          ],
        ),
        CardItem(
          title: Localy.of(context)!.accountSettingTitle,
          itemTitleList: [
            Localy.of(context)!.accountUpdate,
          ],
          itemFunctions: [
            viewModel.onNavigateAccountUpdateScreen,
          ],
        ),
        CardItem(
          title: Localy.of(context)!.otherSettingTitle,
          itemTitleList: [
            Localy.of(context)!.contactLink,
            Localy.of(context)!.termsTitle,
            Localy.of(context)!.policyTitle,
          ],
          itemFunctions: [
            viewModel.onNavigateMailScreen,
            viewModel.onNavigateTermsScreen,
            viewModel.onNavigatePrivacyScreen,
          ],
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.title,
    required this.itemTitleList,
    required this.itemFunctions,
  }) : super(key: key);

  final String title;
  final List<String> itemTitleList;
  final List itemFunctions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 16, 10, 16),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DMSans',
                    fontSize: FontAlias.fontAlias18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          itemTitleList.isEmpty
              ? SpacingAlias.SizeHeight20
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap:
                          itemFunctions.isEmpty ? null : itemFunctions[index],
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: ListTile(
                          title: Text(itemTitleList[index]),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, int) => SizedBox(
                    height: 1,
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                  ),
                  itemCount: itemTitleList.length,
                ),
          SizedBox(
            height: 1,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          SpacingAlias.SizeHeight44,
        ],
      ),
    );
  }
}
