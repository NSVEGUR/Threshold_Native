import 'package:flutter/material.dart';
import 'package:threshold_native/login/views/login_screen.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
