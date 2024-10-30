import '../constants/app_strings.dart';

class LoginValidator {
  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return AppStrings.usernameEmpty;
    } else if (username.length < 5) {
      return AppStrings.usernameTooShort;
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return AppStrings.passwordEmpty;
    } else if (password.length < 5) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }
}
