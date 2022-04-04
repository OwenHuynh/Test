import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'district_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class DistrictModel {
  DistrictModel({required this.name, required this.url});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return _$DistrictModelFromJson(json);
  }

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? url;
}
