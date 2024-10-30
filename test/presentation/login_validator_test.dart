import 'package:bloc_project_empiricus/presentation/utils/constants/app_strings.dart';
import 'package:bloc_project_empiricus/presentation/utils/validators/login_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginValidator Test', () {
    test('Campo usuario vazio', () {
      final result = LoginValidator.validateUsername('');
      expect(result, AppStrings.usernameEmpty);
    });

    test('Campo usuario curto', () {
      final result = LoginValidator.validateUsername('usua');
      expect(result, AppStrings.usernameTooShort);
    });

    test('Campo usuario válido -> null', () {
      final result = LoginValidator.validateUsername('usuario');
      expect(result, null);
    });

    test('Campo senha vazio', () {
      final result = LoginValidator.validatePassword('');
      expect(result, AppStrings.passwordEmpty);
    });

    test('Campo senha curto', () {
      final result = LoginValidator.validatePassword('123');
      expect(result, AppStrings.passwordTooShort);
    });

    test('Campo senha válido -> null', () {
      final result = LoginValidator.validatePassword('senha');
      expect(result, null);
    });
  });
}
