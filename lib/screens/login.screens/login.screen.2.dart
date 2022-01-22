import 'package:flutter/material.dart';
import 'package:threshold_native/components/logo.component.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants.dart';

class LoginScreenTwo extends StatefulWidget {
  static const String id = 'login.screen.2';
  const LoginScreenTwo({Key? key}) : super(key: key);

  @override
  _LoginScreenTwoState createState() => _LoginScreenTwoState();
}

class _LoginScreenTwoState extends State<LoginScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VStack(
          [
            const Logo(
              title: 'Role',
            ),
            "Username"
                .text
                .xl5
                .extraBold
                .color(AppColors.primaryTextColor)
                .make(),
            "please confirm yourself."
                .text
                .xl3
                .color(AppColors.secondaryTextColor)
                .make(),
            TextFormField(
              cursorColor: AppColors.primayColor,
              decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
                hintText: 'Enter your mobile',
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
                onPressed: () {},
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
