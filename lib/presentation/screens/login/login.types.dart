import 'package:portal/presentation/screens/login/login.state.dart';

class LoginViewModel {
  LoginViewModel(
      {required this.state,
      required this.isFormValid,
      required this.onEmailChange,
      required this.onPasswordChange,
      required this.login,
      required this.onLoadDistrict});

  LoginState state;
  bool isFormValid;
  Function() onLoadDistrict;
  Function(String text) onEmailChange;
  Function(String text) onPasswordChange;
  Function() login;
}
