import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/mock/mock_downloadapp.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/download_app/download_app.types.dart';
import 'package:portal/state-management/selector.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

DownloadAppViewModel useDownloadAppViewModel(
    BuildContext context, StoresSelector state) {
  // final dispatcherException = useException();

  // final store = StoreProvider.of<AppState>(context);

  final List<DownloadApp> appList = DownloadAppList;

  final onNavigateDownloadAndroid = useCallback((String messageDownload) async {
    /// Input appPackageName for loading download url
    ///
    ///

    // final String LaunchCommonString =
    //     Uri.encodeFull("market://details?id=$appPackageName");
    // final String LaunchAndroidString = Uri.encodeFull(
    //     "https://play.google.com/store/apps/details?id=$appPackageName");

    // if (await canLaunch(LaunchCommonString)) {
    //   await launch(LaunchCommonString);
    // } else if (await canLaunch(LaunchAndroidString)) {
    //   await launch(LaunchAndroidString);

    // } else {
    //   dispatcherException.dispatch(UrlException());
    // }
    return DialogManager.showConfirmDialog(
      context,
      messageWidget: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(messageDownload, style: TextStyle(fontSize: 14)),
      ),
      confirm: Localy.of(context)!.confirmText,
      cancel: Localy.of(context)!.cancelText,
      onCancel: AppNavigation.pop,
      onConfirm: AppNavigation.pop,
      // dialogStyle: BaseDialogStyle(
      //   titleTextStyle: TextStyle(fontSize: 16),
      // ),
    );
  }, [context, Localy]);

  final onNavigateDownloadIOs = useCallback((String messageDownload) {
    DialogManager.showConfirmDialog(
      context,
      messageWidget: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(messageDownload, style: TextStyle(fontSize: 14)),
      ),
      confirm: Localy.of(context)!.confirmText,
      cancel: Localy.of(context)!.cancelText,
      onCancel: AppNavigation.pop,
      onConfirm: AppNavigation.pop,
      // dialogStyle: BaseDialogStyle(
      //   titleTextStyle: TextStyle(fontSize: 16),
      // ),
    );
  }, [context, Localy]);

  return DownloadAppViewModel(
    appList: appList,
    onNavigateDownloadAndroid: onNavigateDownloadAndroid,
    onNavigateDownloadIOs: onNavigateDownloadIOs,
  );
}
