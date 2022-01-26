import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threshold_native/components/logo.dart';
import 'package:threshold_native/signup/bloc/signup_bloc.dart';
import 'package:threshold_native/signup/views/signup_form.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:threshold_native/constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as AuthType;
    final role = getRoleFromEnum(arguments.role)[0].toUpperCase() +
        getRoleFromEnum(arguments.role).substring(1);
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignupBloc(
            authenticationRepository: arguments.authenticationRepository,
          ),
          child: VStack(
            [
              Logo(title: '$role Signup'),
              "Welcome,"
                  .text
                  .xl5
                  .extraBold
                  .color(AppColors.primaryTextColor)
                  .make(),
              "username".text.xl3.color(AppColors.secondaryTextColor).make(),
              SignupForm(
                authType: arguments,
              ),
            ],
          ).centered().pOnly(left: 50),
        ),
      ),
    );
  }
}
