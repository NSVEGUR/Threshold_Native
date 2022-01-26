import 'package:flutter/material.dart';
import 'package:threshold_native/animations/slide.page.animation.dart';
import 'package:threshold_native/home/home.dart';
import 'package:threshold_native/login/login.dart';
import 'package:threshold_native/signup/signup.dart';

Route generateAppRoute(RouteSettings settings) {
  switch (settings.name) {
    case Login.routeName:
      return SlidePageRoute(
        child: const Login(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case Signup.routeName:
      return SlidePageRoute(
        child: const Signup(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case Home.routeName:
    default:
      return SlidePageRoute(
        child: const Home(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
  }
}
