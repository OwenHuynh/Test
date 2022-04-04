import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:portal/data/locals/models/district/district_model.dart';

part 'district_state.g.dart';

final defaultDistrict =
    DistrictModel(name: "世田谷区", url: "https://www.city.setagaya.lg.jp/");

abstract class DistrictState
    implements Built<DistrictState, DistrictStateBuilder> {
  factory DistrictState.initial() {
    return _$DistrictState._(
        listDistrict: [], isLoading: false, currentDistrict: defaultDistrict);
  }

  DistrictState._();

  @override
  @memoized
  int get hashCode;

  List<DistrictModel> get listDistrict;

  bool get isLoading;

  DistrictModel get currentDistrict;

  static Serializer<DistrictState> get serializer => _$districtStateSerializer;
}
