import 'package:flutter/material.dart';
import 'package:portal/presentation/navigation/app_navigation.dart';
import 'package:portal/presentation/screens/child_home/child_home.dart';
import 'package:portal/presentation/screens/download_app/download_app.dart';
import 'package:portal/presentation/screens/home/home.types.dart';
import 'package:portal/presentation/screens/setting/setting.dart';
import 'package:portal/shared/event_bus/event/update_district_event.dart';
import 'package:portal/shared/event_bus/event_bus_utils.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

HomeViewModel useHomeViewModel(BuildContext context) {
  final _selectedIndex = useState(0);

  final pageController = usePageController(
    initialPage: 0,
    keepPage: true,
  );

  useEffect(() {
    eventBus.on<UpdateDistrictEventBus>().listen((event) {
      AppNavigation.pop();
      _selectedIndex.value = PageIndex.HOME;
      pageController.jumpToPage(PageIndex.HOME);
    });

    return null;
  }, []);

  final tabs = useMemoized(
      () => <HomeTabTab>[
            HomeTabTab(
              page: ChildHomeScreen(
                title: Localy.of(context)!.childHomeTitle,
              ),
              bottomTabBarItem: BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: Localy.of(context)!.childHomeTitle),
            ),
            HomeTabTab(
              page: DownloadAppScreen(title: Localy.of(context)!.appPageTitle),
              bottomTabBarItem: BottomNavigationBarItem(
                  icon: Icon(Icons.download),
                  label: Localy.of(context)!.appPageTitle),
            ),
            HomeTabTab(
              page: SettingScreen(title: Localy.of(context)!.settingPageTitle),
              bottomTabBarItem: BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: Localy.of(context)!.settingPageTitle),
            ),
          ],
      [Localy]);

  final onItemSelected = useCallback((int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }, []);

  return HomeViewModel(
      pageController: pageController,
      selectedIndex: _selectedIndex.value,
      tabs: tabs,
      onItemSelected: onItemSelected);
}
