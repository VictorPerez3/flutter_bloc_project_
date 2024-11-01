abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoginSuccess extends LoginState {}
