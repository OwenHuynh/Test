import 'package:portal/data/locals/models/district/district_model.dart';

class DistrictListViewModel {
  DistrictListViewModel({
    required this.onDeleteDistrictAtPosition,
    required this.onStoreDistrict,
    required this.onChangeDistrict,
    required this.districtList,
    required this.onTextChange,
    required this.onConfirmDistrict,
    required this.isChangedDistrict,
    required this.selectedDistrict,
  });

  Function(String name, String url) onStoreDistrict;
  Function(DistrictModel district) onDeleteDistrictAtPosition;
  Function(DistrictModel?) onChangeDistrict;
  List<DistrictModel> districtList;
  Function(String value) onTextChange;
  Function(bool value) onConfirmDistrict;
  bool isChangedDistrict;
  DistrictModel selectedDistrict;
}
