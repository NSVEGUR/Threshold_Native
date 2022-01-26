import 'package:authentication_repository/authentication_repository.dart';

class AuthType {
  final Roles role;
  final AuthenticationRepository authenticationRepository;
  final String username;
  final String password;
  final String mobile;

  const AuthType({
    this.role = Roles.student,
    required this.authenticationRepository,
    this.username = '',
    this.password = '',
    this.mobile = '',
  });

  AuthType copyWith({
    Roles? role,
    required AuthenticationRepository authenticationRepository,
    String? username,
    String? password,
    String? mobile,
  }) {
    return AuthType(
      role: role ?? this.role,
      username: username ?? this.username,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      authenticationRepository: authenticationRepository,
    );
  }
}
