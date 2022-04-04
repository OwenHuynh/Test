import 'package:flutter/material.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/presentation/screens/child_home/component/bottom_sheet.types.dart';
import 'package:portal/shared/hooks/use_mount.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

BottomSheetViewModel useBottomSheetViewModel(
    BuildContext context, List<DistrictModel> listDistrict) {
  final store = StoreProvider.of<AppState>(context);

  final districtListState = useState<List<DistrictModel>>([]);

  useMount(() {
    districtListState.value = store.state.districtState.listDistrict;
  });

  final onChangeText = useCallback((String? value) async {
    if (value!.isEmpty) {
      districtListState.value = listDistrict;
    } else {
      districtListState.value = listDistrict
          .where((DistrictModel district) => district.name!.contains(value))
          .toList();
    }
  }, [listDistrict]);

  final onCompareDistrict = useCallback((DistrictModel selected) {
    if (store.state.districtState.currentDistrict.name == selected.name &&
        store.state.districtState.currentDistrict.url == selected.url) {
      return true;
    }
    return false;
  }, [store.state.districtState.currentDistrict]);

  final onGroupValue = useCallback((DistrictModel selected) {
    if (onCompareDistrict(selected)) {
      return selected;
    }
    return null;
  }, [onCompareDistrict]);

  return BottomSheetViewModel(
      districtList: districtListState.value,
      onTextChange: onChangeText,
      groupValue: onGroupValue,
      districtComparison: onCompareDistrict);
}
