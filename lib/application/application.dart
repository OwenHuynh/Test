import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/navigation/navigation_observer.dart';
import 'package:portal/presentation/screens/login/login.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:portal/shared/theme/app_theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class Application extends StatefulWidget {
  State<Application> createState() => new _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final store = createStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: BaseExtendedApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: Locale.fromSubtags(languageCode: Intl.getCurrentLocale()),
          supportedLocales: <Locale>[Locale('en', 'US'), Locale('ja', 'JP')],
          localizationsDelegates: Localy.localizationsDelegates,
          navigatorObservers: [CustomNavigationObserver()],
          home: LoginScreen(),
        ));
  }
}

class AppBarText extends AppBar {
  AppBarText(String text, {Key? key, List<Widget>? action})
      : super(
            key: key,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyleLight(),
            title: Text(text,
                style: TextStyle(
                    fontSize: FontAlias.fontAlias16,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: action);
}
