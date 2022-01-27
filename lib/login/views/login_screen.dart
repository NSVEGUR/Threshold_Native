import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threshold_native/login/bloc/login_bloc.dart';
import 'package:threshold_native/components/logo.dart';
import 'package:threshold_native/constants.dart';
import 'package:threshold_native/login/views/login_form.dart';
import 'package:threshold_native/signup/signup.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:authentication_repository/authentication_repository.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roles = ModalRoute.of(context)!.settings.arguments as Roles;
    final role = getRoleFromEnum(roles)[0].toUpperCase() +
        getRoleFromEnum(roles).substring(1);
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository: _authenticationRepository,
          ),
          child: VStack(
            [
              Logo(title: '$role Login').pOnly(left: 50),
              "Hello,"
                  .text
                  .xl5
                  .extraBold
                  .color(AppColors.primaryTextColor)
                  .make()
                  .pOnly(left: 50),
              "please login."
                  .text
                  .xl3
                  .color(AppColors.secondaryTextColor)
                  .make()
                  .pOnly(left: 50),
              LoginForm(
                authtype: AuthType(
                  role: roles,
                  authenticationRepository: _authenticationRepository,
                ),
              ),
              HStack(
                [
                  GestureDetector(
                    child: "Forgot Password?".text.make(),
                  ),
                  GestureDetector(
                    child: "Create Account.".text.make(),
                    onTap: () {
                      final AuthType arguments = AuthType(
                        role: roles,
                        authenticationRepository: _authenticationRepository,
                      );
                      Navigator.pushNamed(
                        context,
                        Signup.routeName,
                        arguments: arguments,
                      );
                    },
                  ),
                ],
                alignment: MainAxisAlignment.spaceEvenly,
              )
                  .pOnly(top: 20)
                  .box
                  .width(context.percentWidth * 90)
                  .make()
                  .centered(),
            ],
          ).centered(),
        ),
      ),
    );
  }
}
