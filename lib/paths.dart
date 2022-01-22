import 'package:flutter/material.dart';
import 'screens/users.screen.dart';
import 'screens/login.screens/login.screen.1.dart';
import 'screens/login.screens/login.screen.2.dart';
import 'screens/signup.screens/signup.screen.1.dart';
import 'screens/signup.screens/signup.screen.2.dart';

appRouter({required BuildContext context}) {
  return {
    UsersSelect.id: (context) => const UsersSelect(),
    LoginScreenOne.id: (context) => const LoginScreenOne(),
    LoginScreenTwo.id: (context) => const LoginScreenTwo(),
    SignupScreenOne.id: (context) => const SignupScreenOne(),
    SignupScreenTwo.id: (context) => const SignupScreenTwo(),
  };
}
