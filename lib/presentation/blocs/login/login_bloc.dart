import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/validators/login_validator.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) {
    final usernameError = LoginValidator.validateUsername(event.username);
    final passwordError = LoginValidator.validatePassword(event.password);

    if (usernameError != null && passwordError != null) {
      emit(LoginFailure(error: AppStrings.fieldsEmpty));
      return;
    } else if (usernameError != null) {
      emit(LoginFailure(error: usernameError));
      return;
    } else if (passwordError != null) {
      emit(LoginFailure(error: passwordError));
      return;
    }

    if (event.username == AppStrings.mockUsername &&
        event.password == AppStrings.mockPassword) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error: AppStrings.invalidCredentials));
    }
  }
}
