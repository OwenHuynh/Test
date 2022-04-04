import 'package:flutter/cupertino.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/district_list/component/district_form.validate.dart';
import 'package:portal/presentation/screens/district_list/district_list.types.dart';
import 'package:portal/shared/event_bus/event/update_district_event.dart';
import 'package:portal/shared/event_bus/event_bus_utils.dart';
import 'package:portal/shared/hooks/use_mount.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/async_action_listener.dart';
import 'package:portal/shared/utils/district_utils.dart';
import 'package:portal/shared/utils/utils.dart';
import 'package:portal/state-management/actions/district_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

DistrictListViewModel useDistrictListViewModel(
    BuildContext context, List<DistrictModel> listDistrict) {
  final store = StoreProvider.of<AppState>(context);

  final districtListState = useState<List<DistrictModel>>([]);

  final isChangedDistrict = useState<bool>(false);

  final _currentDistrict = useRef(store.state.districtState.currentDistrict);

  final _selectedDistrict = useState(store.state.districtState.currentDistrict);

  useMount(() {
    districtListState.value = store.state.districtState.listDistrict;
  });

  final isFormValid = useCallback((name, url) {
    return DistrictFormValidationResults(context).validateForm(name, url);
  }, [context]);

  final onStoreDistrict = useCallback((String name, String url) async {
    if (!isFormValid(name, url)) {
      return;
    }
    store.dispatch(DistrictAddRequest(
        district: DistrictModel(name: name, url: url),
        listener: AsyncActionListener(
            onStart: () {},
            onSuccess: () {
              districtListState.value = store.state.districtState.listDistrict;
            },
            onError: (e) {
              AppNavigation.pop();
            })));

    AppNavigation.pop();
  }, [store, isFormValid]);

  final onDeleteDistrictAtPosition = useCallback((DistrictModel district) {
    UIUtils.showConfirmDialog(
        context: context,
        title: Localy.of(context)!.deleteDistrict,
        message:
            "${Localy.of(context)!.deleteDistrictConfirm} ${district.name}",
        buttonConfirmCallback: () {
          final index = listDistrict.indexWhere(
              (element) => DistrictUtils.districtComparison(element, district));
          store.dispatch(DistrictDeleteRequest(
              index: index,
              listener: AsyncActionListener(
                  onStart: () {},
                  onSuccess: () {
                    AppNavigation.pop();
                    districtListState.value =
                        store.state.districtState.listDistrict;
                  },
                  onError: (e) {
                    AppNavigation.pop();
                  })));
        },
        onCancel: AppNavigation.pop);
  }, [store, context, Localy, listDistrict]);

  final onChangeDistrict = useCallback((DistrictModel? district) {
    if (district != null) {
      _selectedDistrict.value = district;
      isChangedDistrict.value =
          !DistrictUtils.districtComparison(_currentDistrict.value, district);
    }
  }, []);

  final onChangeText = useCallback((String? value) async {
    if (value!.isEmpty) {
      districtListState.value = listDistrict;
    } else {
      districtListState.value = listDistrict
          .where((DistrictModel district) => district.name!.contains(value))
          .toList();
    }
  }, [listDistrict]);

  final onConfirmDistrict = useCallback((bool isRegister) async {
    store
        .dispatch(DistrictSetRequest(currentDistrict: _selectedDistrict.value));
    if (isRegister) {
      AppNavigation.onNavigateToHome();
      return;
    }
    eventBus.fire(UpdateDistrictEventBus());
  }, [_selectedDistrict.value, store]);

  return DistrictListViewModel(
      onDeleteDistrictAtPosition: onDeleteDistrictAtPosition,
      onStoreDistrict: onStoreDistrict,
      onChangeDistrict: onChangeDistrict,
      districtList: districtListState.value,
      onTextChange: onChangeText,
      onConfirmDistrict: onConfirmDistrict,
      isChangedDistrict: isChangedDistrict.value,
      selectedDistrict: _selectedDistrict.value);
}
