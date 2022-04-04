class SettingViewModel {
  SettingViewModel({
    required this.onNavigateToDistrictListScreen,
    required this.onNavigateAccountUpdateScreen,
    required this.onNavigateMailScreen,
    required this.onNavigateTermsScreen,
    required this.onNavigatePrivacyScreen,
  });

  Function() onNavigateToDistrictListScreen;
  Function() onNavigateAccountUpdateScreen;
  Function() onNavigateMailScreen;
  Function() onNavigateTermsScreen;
  Function() onNavigatePrivacyScreen;
}
