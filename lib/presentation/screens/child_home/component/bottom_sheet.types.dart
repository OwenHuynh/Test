import 'package:portal/data/locals/models/district/district_model.dart';

class BottomSheetViewModel {
  BottomSheetViewModel({
    required this.districtList,
    required this.onTextChange,
    required this.districtComparison,
    required this.groupValue,
  });

  List<DistrictModel> districtList;
  Function(String value) onTextChange;
  Function(DistrictModel) districtComparison;
  Function(DistrictModel) groupValue;
}
