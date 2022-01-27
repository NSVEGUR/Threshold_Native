part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.mobile = const Mobile.pure(),
    this.mobileConfirm = const ConfirmedMobile.pure(),
    this.passwordConfirm = const ConfirmedPassword.pure(),
    this.userError = '',
    this.signupError = '',
    this.role = Roles.student,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Mobile mobile;
  final ConfirmedMobile mobileConfirm;
  final ConfirmedPassword passwordConfirm;
  final Roles role;
  final String userError;
  final String signupError;

  SignupState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Mobile? mobile,
    ConfirmedMobile? mobileConfirm,
    ConfirmedPassword? passwordConfirm,
    Roles? role,
    String? userError,
    String? signupError,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      mobileConfirm: mobileConfirm ?? this.mobileConfirm,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      role: role ?? this.role,
      userError: userError ?? this.userError,
      signupError: signupError ?? this.signupError,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        mobile,
        passwordConfirm,
        mobileConfirm,
        userError,
        signupError,
      ];
}
