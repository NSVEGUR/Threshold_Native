import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threshold_native/components/logo.dart';
import 'package:threshold_native/signup/bloc/signup_bloc.dart';
import 'package:threshold_native/signup/views/register_form.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:threshold_native/constants.dart';

class ResgisterScreen extends StatelessWidget {
  const ResgisterScreen({Key? key}) : super(key: key);

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
              Logo(title: '$role Signup').pOnly(left: 50),
              "Hey again,"
                  .text
                  .xl5
                  .extraBold
                  .color(AppColors.primaryTextColor)
                  .make()
                  .pOnly(left: 50),
              "lets introduce."
                  .text
                  .xl3
                  .color(AppColors.secondaryTextColor)
                  .make()
                  .pOnly(left: 50),
              RegisterForm(
                authType: arguments,
              ),
            ],
          ).centered(),
        ),
      ),
    );
  }
}
