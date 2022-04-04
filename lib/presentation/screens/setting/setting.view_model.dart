import 'package:flutter/cupertino.dart';
import 'package:portal/data/mock/mock_html_policy.dart';
import 'package:portal/data/mock/mock_html_terms.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/setting/setting.types.dart';
import 'package:portal/shared/errors/url_exception/url_exception.dart';
import 'package:portal/shared/hooks/use_exception.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:portal/shared/utils/ui_utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

SettingViewModel useSettingViewModel(BuildContext context) {
  final dispatcherException = useException();

  final showErrorMessage = useCallback(() {
    final disposeFuture = Future.microtask(() {
      UIUtils.showErrorMessage(context, "Could not launch mail");
    });
    return () => disposeFuture.then((dispose) => dispose);
  }, [context]);

  useEffect(() {
    if (dispatcherException.value is UrlException) {
      showErrorMessage();
    }

    return null;
  }, [dispatcherException.value, showErrorMessage]);

  final onNavigateToDistrictListScreen = useCallback(() {
    AppNavigation.onNavigateToDistrictList(isRegister: false);
  }, []);

  final onNavigateAccountUpdateScreen = useCallback(() {
    AppNavigation.onAccountUpdateScreen(
        title: Localy.of(context)!.accountUpdate);
  }, [Localy]);

  final onNavigateMailScreen = useCallback(() async {
    final String emailLaunchString =
        Uri.encodeFull('mailto:contact@mcpass.co.jp?subject=【TT自治体ポータル】');

    if (await canLaunch(emailLaunchString)) {
      await launch(emailLaunchString);
    } else {
      dispatcherException.dispatch(UrlException());
    }
  }, [dispatcherException]);

  final onNavigateTermsScreen = useCallback(() {
    AppNavigation.onTermsScreen(
        title: Localy.of(context)!.termTitle, content: htmlTerms);
  }, [Localy]);

  final onNavigatePrivacyScreen = useCallback(() {
    AppNavigation.onPrivacyScreen(
        title: Localy.of(context)!.policyTitle, content: htmlPolicy);
  }, [Localy]);

  return SettingViewModel(
    onNavigateToDistrictListScreen: onNavigateToDistrictListScreen,
    onNavigateAccountUpdateScreen: onNavigateAccountUpdateScreen,
    onNavigateMailScreen: onNavigateMailScreen,
    onNavigateTermsScreen: onNavigateTermsScreen,
    onNavigatePrivacyScreen: onNavigatePrivacyScreen,
  );
}
