import 'package:flutter/material.dart';
import 'package:threshold_native/components/logo.component.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants.dart';
import 'signup.screen.2.dart';

class SignupScreenOne extends StatefulWidget {
  static const String id = 'signup.screen.1';
  const SignupScreenOne({Key? key}) : super(key: key);

  @override
  _SignupScreenOneState createState() => _SignupScreenOneState();
}

class _SignupScreenOneState extends State<SignupScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VStack(
          [
            const Logo(title: 'Role'),
            "Hello!"
                .text
                .xl5
                .extraBold
                .color(AppColors.primaryTextColor)
                .make(),
            "lets introduce"
                .text
                .xl3
                .color(AppColors.secondaryTextColor)
                .make(),
            TextFormField(
              cursorColor: AppColors.primayColor,
              decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
                hintText: 'Enter your username',
              ),
            ).py12(),
            TextFormField(
              obscureText: true,
              cursorColor: AppColors.primayColor,
              decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
                hintText: 'Create a password',
              ),
            ).py12(),
            TextFormField(
              obscureText: true,
              cursorColor: AppColors.primayColor,
              decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
                hintText: 'Confirm your password',
              ),
            ).py12(),
            HStack([
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
                  Navigator.pushNamed(context, SignupScreenTwo.id);
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
            ]).pOnly(top: 20),
          ],
        ).centered().pOnly(left: 50),
      ),
    );
  }
}
