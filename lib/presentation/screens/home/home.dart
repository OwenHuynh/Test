import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/home/home.types.dart';
import 'package:portal/presentation/screens/home/home.view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useHomeViewModel(context);

    return BaseScaffold(
      tapOutsideDismissKeyboard: true,
      safeBottom: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.onItemSelected,
        selectedItemColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          viewModel.tabs[PageIndex.HOME].bottomTabBarItem,
          viewModel.tabs[PageIndex.DOWNLOAD_APP].bottomTabBarItem,
          viewModel.tabs[PageIndex.SETTING].bottomTabBarItem,
        ],
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: viewModel.pageController,
        itemCount: viewModel.tabs.length,
        itemBuilder: (BuildContext context, int index) {
          return viewModel.tabs[index].page;
        },
      ),
    );
  }
}
