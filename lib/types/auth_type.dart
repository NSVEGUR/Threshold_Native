import 'package:authentication_repository/authentication_repository.dart';

class AuthType {
  final Roles role;
  final AuthenticationRepository authenticationRepository;
  final String username;
  final String password;
  final String mobile;
  String token;

  AuthType({
    this.role = Roles.student,
    required this.authenticationRepository,
    this.username = '',
    this.password = '',
    this.mobile = '',
    this.token = '',
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

  Future<void> updateToken() async {
    token = await authenticationRepository.token;
  }
}
