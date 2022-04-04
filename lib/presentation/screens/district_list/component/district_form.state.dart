import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'district_form.state.g.dart';

abstract class DistrictFormState
    implements Built<DistrictFormState, DistrictFormStateBuilder> {
  factory DistrictFormState.initial() {
    return _$DistrictFormState._(
        address: "",
        districtName: "",
        districtUrl: "",
        districtNameError: null,
        districtUrlError: null);
  }

  DistrictFormState._();

  @override
  @memoized
  int get hashCode;

  String get address;

  String get districtName;

  String get districtUrl;

  String? get districtNameError;

  String? get districtUrlError;

  static Serializer<DistrictFormState> get serializer =>
      _$districtFormStateSerializer;
}
