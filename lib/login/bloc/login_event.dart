part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSetRole extends LoginEvent {
  const LoginSetRole(this.role);
  final Roles role;

  @override
  List<Object> get props => [role];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginMobileChanged extends LoginEvent {
  const LoginMobileChanged(this.mobile);

  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
