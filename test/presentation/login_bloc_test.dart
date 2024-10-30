import 'package:bloc_project_empiricus/presentation/blocs/login/login_bloc.dart';
import 'package:bloc_project_empiricus/presentation/blocs/login/login_event.dart';
import 'package:bloc_project_empiricus/presentation/blocs/login/login_state.dart';
import 'package:bloc_project_empiricus/presentation/utils/constants/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginBloc Test', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc();
    });

    tearDown(() {
      loginBloc.close();
    });

    test('Campo usuario e senha vazios -> LoginFailure', () async {
      loginBloc.add(LoginButtonPressed(username: '', password: ''));

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginFailure>()
              .having((e) => e.error, 'error', AppStrings.fieldsEmpty),
        ]),
      );
    });

    test('Campo usuario curto -> LoginFailure', () async {
      loginBloc.add(LoginButtonPressed(username: 'usua', password: 'senha'));

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginFailure>()
              .having((e) => e.error, 'error', AppStrings.usernameTooShort),
        ]),
      );
    });

    test('Campo senha curto -> LoginFailure', () async {
      loginBloc.add(LoginButtonPressed(username: 'usuario', password: '123'));

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginFailure>()
              .having((e) => e.error, 'error', AppStrings.passwordTooShort),
        ]),
      );
    });

    test('Campos corretos -> LoginSucess', () async {
      loginBloc.add(LoginButtonPressed(
        username: AppStrings.mockUsername,
        password: AppStrings.mockPassword,
      ));

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginSuccess>(),
        ]),
      );
    });

    test('Campo usuario e senha incorretos -> LoginFailure', () async {
      loginBloc.add(LoginButtonPressed(
        username: 'xxxxxxxxxxxxx',
        password: 'yyyyyyyyyyyy',
      ));

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginFailure>()
              .having((e) => e.error, 'error', AppStrings.invalidCredentials),
        ]),
      );
    });
  });
}
