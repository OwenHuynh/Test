import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DistrictFormActions extends Equatable {
  DistrictFormActions({required this.context});

  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class OnChangeAddress extends DistrictFormActions {
  OnChangeAddress(BuildContext context, {required this.address})
      : super(context: context);

  final String address;

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'OnChangeAddress { address: $address }';
}

class OnChangeDistrictName extends DistrictFormActions {
  OnChangeDistrictName(BuildContext context, {required this.districtName})
      : super(context: context);

  final String districtName;

  @override
  List<Object> get props => [districtName];

  @override
  String toString() => 'OnChangeDistrictName { districtName: $districtName }';
}

class OnChangeDistrictUrl extends DistrictFormActions {
  OnChangeDistrictUrl(BuildContext context, {required this.districtUrl})
      : super(context: context);

  final String districtUrl;

  @override
  List<Object> get props => [districtUrl];

  @override
  String toString() => 'OnChangeDistrictUrl { districtUrl: $districtUrl }';
}
