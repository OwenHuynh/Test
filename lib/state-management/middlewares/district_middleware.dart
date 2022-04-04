import 'package:portal/data/mock/mock_district.dart';
import 'package:portal/di/dependency_injection.dart';
import 'package:portal/domain/repositories/district_repository/district_repository.dart';
import 'package:portal/state-management/actions/district_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreDistrictMiddleware() {
  final onDistrictListRequest = _onDistrictListRequest();
  final onAddDistrictAction = _onAddDistrictAction();
  final onDeleteDistrictAction = _onDeleteDistrictAction();
  final onSetDistrictAction = _onSetDistrictAction();

  return [
    TypedMiddleware<AppState, DistrictListRequest>(onDistrictListRequest),
    TypedMiddleware<AppState, DistrictAddRequest>(onAddDistrictAction),
    TypedMiddleware<AppState, DistrictDeleteRequest>(onDeleteDistrictAction),
    TypedMiddleware<AppState, DistrictSetRequest>(onSetDistrictAction),
  ];
}

Middleware<AppState> _onDistrictListRequest() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DistrictListRequest;
    final districtRepository = getIt<DistrictRepository>();
    action.listener.onStart();
    final result = await districtRepository.loadDistrictList();

    result.fold((l) => action.listener.onError, (r) async {
      if (r.isEmpty) {
        await districtRepository.initDistrictList(defaultListDistrict);
        await districtRepository.setCurrentDistrict(defaultListDistrict.first);
        store.dispatch(DistrictListResponse(
            listener: action.listener,
            districtList: defaultListDistrict,
            currentDistrict: defaultListDistrict.first));
        return;
      }

      final result = await districtRepository.getCurrentDistrict();
      store.dispatch(DistrictListResponse(
          listener: action.listener, districtList: r, currentDistrict: result));
      action.listener.onSuccess();
    });
  };
}

Middleware<AppState> _onAddDistrictAction() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DistrictAddRequest;
    final districtRepository = getIt<DistrictRepository>();
    action.listener.onStart();
    final result = await districtRepository.addDistrict(action.district);

    result.fold((l) => action.listener.onError, (_) {
      store.dispatch(DistrictAddResponse(
          listener: action.listener, district: action.district));
      action.listener.onSuccess();
    });
  };
}

Middleware<AppState> _onDeleteDistrictAction() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DistrictDeleteRequest;
    final districtRepository = getIt<DistrictRepository>();
    action.listener.onStart();
    final result = await districtRepository.deleteDistrictAt(action.index);

    result.fold((l) => action.listener.onError, (_) {
      store.dispatch(DistrictDeleteResponse(
          listener: action.listener, index: action.index));
      action.listener.onSuccess();
    });
  };
}

Middleware<AppState> _onSetDistrictAction() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DistrictSetRequest;
    final districtRepository = getIt<DistrictRepository>();
    final result =
        await districtRepository.setCurrentDistrict(action.currentDistrict);

    result.fold((l) {}, (r) {
      store.dispatch(
          DistrictSetResponse(currentDistrict: action.currentDistrict));
    });
  };
}
