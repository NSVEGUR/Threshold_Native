import 'package:flutter/material.dart';
import 'package:threshold_native/components/logo.component.dart';
import 'package:threshold_native/screens/login.screens/login.screen.2.dart';
import 'package:threshold_native/screens/signup.screens/signup.screen.1.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants.dart';

class LoginScreenOne extends StatefulWidget {
  static const String id = 'login.screen.1';
  const LoginScreenOne({Key? key}) : super(key: key);

  @override
  _LoginScreenOneState createState() => _LoginScreenOneState();
}

class _LoginScreenOneState extends State<LoginScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: VStack(
        [
          const Logo(title: 'Role').pOnly(left: 50),
          "Hey!"
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
          TextFormField(
            cursorColor: AppColors.primayColor,
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              hintText: 'Enter your username',
            ),
          ).py12().pOnly(left: 50),
          TextFormField(
            obscureText: true,
            cursorColor: AppColors.primayColor,
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              hintText: 'Enter your password',
            ),
          ).py12().pOnly(left: 50),
          HStack(
            [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.west_rounded,
                  color: AppColors.secondaryTextColor,
                ),
              ).pOnly(right: 5),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreenTwo.id);
                },
                icon: const Icon(
                  Icons.east_rounded,
                  color: Colors.white,
                ),
              )
                  .px20()
                  .box
                  .color(
                    AppColors.primayColor,
                  )
                  .withRounded(value: 5)
                  .make()
            ],
          ).pOnly(top: 20, left: 50),
          HStack(
            [
              GestureDetector(
                child: "Forgot Password?".text.make(),
              ),
              GestureDetector(
                child: "Create Account.".text.make(),
                onTap: () {
                  Navigator.pushNamed(context, SignupScreenOne.id);
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
      ).centered()),
    );
  }
}
