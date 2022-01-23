import 'package:flutter/material.dart';
import 'screens/users.screen.dart';
import 'screens/login.screens/login.screen.1.dart';
import 'screens/login.screens/login.screen.2.dart';
import 'screens/signup.screens/signup.screen.1.dart';
import 'screens/signup.screens/signup.screen.2.dart';
import 'animations/slide.page.animation.dart';

Route generateAppRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreenOne.id:
      return SlidePageRoute(
        child: const LoginScreenOne(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case LoginScreenTwo.id:
      return SlidePageRoute(
        child: const LoginScreenTwo(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case SignupScreenOne.id:
      return SlidePageRoute(
        child: const SignupScreenOne(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case SignupScreenTwo.id:
      return SlidePageRoute(
        child: const SignupScreenTwo(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case UsersSelect.id:
    default:
      return SlidePageRoute(
        child: const UsersSelect(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
  }
}
