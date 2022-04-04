import 'package:portal/state-management/actions/district_action.dart';
import 'package:portal/state-management/states/district_state.dart';
import 'package:redux/redux.dart';

DistrictState districtReducer(DistrictState state, dynamic action) {
  final appReducer = combineReducers<DistrictState>([
    TypedReducer<DistrictState, DistrictListRequest>(_onDistrictListRequest),
    TypedReducer<DistrictState, DistrictListResponse>(_onDistrictListResponse),
    TypedReducer<DistrictState, DistrictDeleteRequest>(
        _onDistrictDeleteRequest),
    TypedReducer<DistrictState, DistrictDeleteResponse>(
        _onDistrictDeleteResponse),
    TypedReducer<DistrictState, DistrictAddRequest>(_onDistrictAddRequest),
    TypedReducer<DistrictState, DistrictAddResponse>(_onDistrictAddResponse),
    TypedReducer<DistrictState, DistrictSetRequest>(_onDistrictSetRequest),
    TypedReducer<DistrictState, DistrictSetResponse>(_onDistrictSetResponse),
  ]);

  return appReducer.call(state, action);
}

DistrictState _onDistrictListRequest(
    DistrictState state, DistrictListRequest action) {
  return state.rebuild((b) => b..isLoading = false);
}

DistrictState _onDistrictListResponse(
    DistrictState state, DistrictListResponse action) {
  return state.rebuild((b) => b
    ..isLoading = false
    ..listDistrict = action.districtList
    ..currentDistrict = action.currentDistrict);
}

DistrictState _onDistrictDeleteRequest(
    DistrictState state, DistrictDeleteRequest action) {
  return state.rebuild((b) => b..isLoading = true);
}

DistrictState _onDistrictDeleteResponse(
    DistrictState state, DistrictDeleteResponse action) {
  final result = state.listDistrict.toList()..removeAt(action.index);
  if (result.contains(state.currentDistrict)) {
    return state.rebuild((b) => b
      ..listDistrict = result
      ..isLoading = true);
  }
  return state.rebuild((b) => b
    ..listDistrict = result
    ..isLoading = true
    ..currentDistrict = result.first);
}

DistrictState _onDistrictAddRequest(
    DistrictState state, DistrictAddRequest action) {
  return state.rebuild((b) => b..isLoading = true);
}

DistrictState _onDistrictAddResponse(
    DistrictState state, DistrictAddResponse action) {
  final result = state.listDistrict.toList()..add(action.district);
  return state.rebuild((b) => b
    ..listDistrict = result
    ..isLoading = true);
}

DistrictState _onDistrictSetRequest(
    DistrictState state, DistrictSetRequest action) {
  return state.rebuild((b) => b..isLoading = true);
}

DistrictState _onDistrictSetResponse(
    DistrictState state, DistrictSetResponse action) {
  return state.rebuild((b) => b
    ..isLoading = false
    ..currentDistrict = action.currentDistrict);
}
