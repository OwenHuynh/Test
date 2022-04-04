import 'package:portal/data/locals/models/district/district_model.dart';

class DistrictUtils {
  static bool districtComparison(
      DistrictModel current, DistrictModel selected) {
    return current.name == selected.name && current.url == selected.url;
  }

  static DistrictModel? groupDistrict(
      DistrictModel current, DistrictModel selected) {
    if (districtComparison(current, selected)) {
      return selected;
    }
    return null;
  }
}
