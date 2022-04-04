import 'package:portal/presentation/screens/register/register.state.dart';

class RegisterViewModel {
  RegisterViewModel(
      {required this.state,
      required this.isFormValid,
      required this.onEmailChange,
      required this.onPasswordChange,
      required this.onConfirmPasswordChange,
      required this.register,
      required this.onTernCheck,
      required this.onPrivacyCheck,
      required this.onNavigateToPrivacyPage,
      required this.onNavigateToTernPage});

  RegisterState state;
  bool isFormValid;
  Function(String text) onEmailChange;
  Function(String text) onPasswordChange;
  Function(String text) onConfirmPasswordChange;
  Function() register;
  Function(bool? value) onTernCheck;
  Function(bool? value) onPrivacyCheck;
  Function() onNavigateToPrivacyPage;
  Function() onNavigateToTernPage;
}
