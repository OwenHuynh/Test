import 'package:components/components.dart';
import 'package:components/widgets/loading/staggered_dots_wave.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/child_home/component/bottom_sheet.list.dart';
import 'package:portal/presentation/screens/child_home/child_home.types.dart';
import 'package:portal/presentation/screens/child_home/child_home.view_model.dart';
import 'package:portal/presentation/screens/child_home/component/webview_impl.dart';
import 'package:portal/shared/hooks/hooks.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:portal/state-management/states/district_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';

class ChildHomeScreen extends HookWidget {
  ChildHomeScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
        converter: StoresSelector.fromStore,
        builder: (context, state) {
          return ChildHomeBodyWidget(state, title: title);
        });
  }
}

class ChildHomeBodyWidget extends HookWidget {
  ChildHomeBodyWidget(this.state, {required this.title});

  final StoresSelector state;
  final String title;

  @override
  Widget build(BuildContext context) {
    final viewModel = useChildHomeViewModel(context, state);

    final firstMountState = useFirstMountState();
    if (firstMountState || viewModel.webViewReady != null) {
      // ignore: nested_hooks
      useAutomaticKeepAlive(wantKeepAlive: true);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actions: [
          if (viewModel.webViewReady != null)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await viewModel.webViewReady!.canGoBack()) {
                  await viewModel.webViewReady!.goBack();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text(Localy.of(context)!.loadPreviousWebError)),
                  );
                  return;
                }
              },
            ),
          if (viewModel.webViewReady != null)
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await viewModel.webViewReady!.canGoForward()) {
                  await viewModel.webViewReady!.goForward();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(Localy.of(context)!.loadNextWebError),
                    ),
                  );
                  return;
                }
              },
            ),
          if (viewModel.webViewReady != null)
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                viewModel.webViewReady!.reload();
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewSizedChild(
            height: double.infinity,
            width: double.infinity,
            builder: (w, h) {
              return WebView(
                  initialUrl: viewModel.selectedDistrict.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: viewModel.controller.complete,
                  onProgress: (int progress) {
                    print('WebView is loading (progress : $progress%)');
                  },
                  javascriptChannels: <JavascriptChannel>{
                    // _toasterJavascriptChannel(context),
                  },
                  onPageStarted: (String url) {
                    viewModel.isLoadingWebView.value = true;
                  },
                  onPageFinished: (String url) async {
                    viewModel.isLoadingWebView.value = false;
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000));
            },
          ),
          ValueListenableBuilder(
            valueListenable: viewModel.isLoadingWebView,
            builder: (ctx, bool status, child) {
              return viewModel.isLoadingWebView.value
                  ? Center(
                      child: Container(
                      color: AppColors.black.withOpacity(0.5),
                      child: Center(
                        child: StaggeredDotsWave(
                          color: AppColors.white,
                          size: 50,
                        ),
                      ),
                    ))
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context, double bottomSheetOffset) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        Localy.of(context)!.selectDistrictTitle,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  List<Widget> children(
    BuildContext context,
    ChildHomeViewModel viewModel,
    DistrictState state,
  ) {
    return [
      BottomSheetWidget(
        onChangedDistrict: viewModel.onChangedDistrict,
        selectedDistrict: state.currentDistrict,
      ),
    ];
  }
}
