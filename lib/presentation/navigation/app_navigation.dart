import 'package:components/components.dart';
import 'package:portal/presentation/screens/account_update/account_update_screen.dart';
import 'package:portal/presentation/screens/district_list/district_list.dart';
import 'package:portal/presentation/screens/home/home.dart';
import 'package:portal/presentation/screens/html/html_page.dart';
import 'package:portal/presentation/screens/login/login.dart';
import 'package:portal/presentation/screens/register/register.dart';

class AppNavigation {
  static void pop() {
    NavigationHandler.pop();
  }

  static void onNavigateToHome() {
    NavigationHandler.pushAndRemoveUntil(HomeScreen());
  }

  static void onLogoutToLoginScreen() {
    NavigationHandler.pushAndRemoveUntil(LoginScreen());
  }

  static void onAccountUpdateScreen({required String title}) {
    NavigationHandler.push(AccountUpdateScreen(
      title: title,
    ));
  }

  static void onPrivacyScreen(
      {required String title, required String content}) {
    NavigationHandler.push(HTMLPage(appBarTitle: title, contentHTML: content));
  }

  static void onTermsScreen({required String title, required String content}) {
    NavigationHandler.push(HTMLPage(appBarTitle: title, contentHTML: content));
  }

  static void onRegisterScreen() {
    NavigationHandler.push(RegisterScreen());
  }

  static void onNavigateToDistrictList({required bool isRegister}) {
    NavigationHandler.push(DistrictListScreen(isRegister: isRegister));
  }
}
