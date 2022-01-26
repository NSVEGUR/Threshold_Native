part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupUserNameChanged extends SignupEvent {
  const SignupUserNameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupMobileChanged extends SignupEvent {
  const SignupMobileChanged(this.mobile);

  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class SignupPasswordConfirmChanged extends SignupEvent {
  const SignupPasswordConfirmChanged(this.passwordConfirm);

  final String passwordConfirm;

  @override
  List<Object> get props => [passwordConfirm];
}

class SignupMobileConfirmChanged extends SignupEvent {
  const SignupMobileConfirmChanged(this.mobileConfirm);

  final String mobileConfirm;

  @override
  List<Object> get props => [mobileConfirm];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
