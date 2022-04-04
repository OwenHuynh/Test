import 'package:equatable/equatable.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/shared/utils/async_action_listener.dart';

abstract class DistrictAction extends Equatable {
  const DistrictAction();

  @override
  List<Object?> get props => [];
}

class DistrictListRequest extends DistrictAction {
  DistrictListRequest({required this.listener});

  final AsyncActionListener listener;

  @override
  List<Object> get props => [listener];
}

class DistrictListResponse extends DistrictAction {
  DistrictListResponse(
      {required this.listener,
      required this.districtList,
      required this.currentDistrict});

  final AsyncActionListener listener;
  final List<DistrictModel> districtList;
  final DistrictModel currentDistrict;

  @override
  List<Object> get props => [listener, districtList, currentDistrict];
}

class DistrictDeleteRequest extends DistrictAction {
  DistrictDeleteRequest({required this.index, required this.listener});

  final int index;
  final AsyncActionListener listener;

  @override
  List<Object> get props => [index, listener];
}

class DistrictDeleteResponse extends DistrictAction {
  DistrictDeleteResponse({required this.index, required this.listener});

  final int index;
  final AsyncActionListener listener;

  @override
  List<Object> get props => [index, listener];
}

class DistrictAddRequest extends DistrictAction {
  DistrictAddRequest({required this.listener, required this.district});

  final AsyncActionListener listener;
  final DistrictModel district;

  @override
  List<Object> get props => [listener, district];
}

class DistrictAddResponse extends DistrictAction {
  DistrictAddResponse({required this.listener, required this.district});

  final AsyncActionListener listener;
  final DistrictModel district;

  @override
  List<Object> get props => [listener, district];
}

class DistrictSetRequest extends DistrictAction {
  DistrictSetRequest({required this.currentDistrict});

  final DistrictModel currentDistrict;

  @override
  List<Object> get props => [currentDistrict];
}

class DistrictSetResponse extends DistrictAction {
  DistrictSetResponse({required this.currentDistrict});

  final DistrictModel currentDistrict;

  @override
  List<Object> get props => [currentDistrict];
}
