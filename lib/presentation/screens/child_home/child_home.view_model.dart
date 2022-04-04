import 'dart:async';

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/child_home/child_home.types.dart';
import 'package:portal/shared/hooks/hooks.dart';
import 'package:portal/state-management/actions/district_action.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

ChildHomeViewModel useChildHomeViewModel(
    BuildContext context, StoresSelector state) {
  final store = StoreProvider.of<AppState>(context);

  final isLoadingWebView = useState<bool>(false);

  final selectedDistrict =
      useState<DistrictModel>(state.districtState.currentDistrict);

  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  final result = useFutureRetry(controller.future).snapshot.data;

  useUpdateEffect(() {
    if (state.districtState.currentDistrict.url != null && result != null) {
      Future.delayed(const Duration(microseconds: 150), () {
        final urlUpdate = state.districtState.currentDistrict.url ?? "";
        result.loadUrl(urlUpdate);
      });
    }

    return null;
  }, [state.districtState.currentDistrict]);

  useMount(() {
    if (DeviceUtil.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    if (store.state.districtState.listDistrict.isNotEmpty) {
      selectedDistrict.value = store.state.districtState.currentDistrict;
    }
  });

  useUnmount(() {
    if (result != null) {
      result.clearCache();
    }
  });

  useUpdateEffect(() {
    return null;
  }, [selectedDistrict]);

  final onChangedDistrict = useCallback((DistrictModel? district) async {
    if (district != null) {
      AppNavigation.pop();

      store.dispatch(DistrictSetRequest(currentDistrict: district));
    }
  }, [store]);

  return ChildHomeViewModel(
      selectedDistrict: selectedDistrict.value,
      onChangedDistrict: onChangedDistrict,
      isLoadingWebView: isLoadingWebView,
      controller: controller,
      webViewReady: result);
}
