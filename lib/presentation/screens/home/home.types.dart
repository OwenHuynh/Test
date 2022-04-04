import 'package:flutter/material.dart';

class HomeTabTab {
  HomeTabTab({
    required this.page,
    required this.bottomTabBarItem,
  });

  Widget page;
  BottomNavigationBarItem bottomTabBarItem;
}

class PageIndex {
  static final int HOME = 0;
  static final int DOWNLOAD_APP = 1;
  static final int SETTING = 2;
}

class HomeViewModel {
  HomeViewModel(
      {required this.pageController,
      required this.onItemSelected,
      required this.selectedIndex,
      required this.tabs});

  final int selectedIndex;
  final List<HomeTabTab> tabs;
  final PageController pageController;
  final Function(int value) onItemSelected;
}
