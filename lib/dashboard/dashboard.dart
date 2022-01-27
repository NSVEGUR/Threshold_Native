import 'package:flutter/material.dart';
import 'package:threshold_native/constants.dart';
import 'package:threshold_native/home/home.dart';
import 'package:velocity_x/velocity_x.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png').p12(),
        title: const Text(
          'Threshold',
        ),
        backgroundColor: AppColors.primayColor,
        centerTitle: false,
      ),
      body: VStack([
        'DashBoard'.text.xl3.make().centered(),
        InkWell(
          onTap: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(
                Home.routeName,
              ),
            );
          },
          child: const Icon(
            Icons.home,
            color: Colors.white,
          )
              .py12()
              .px20()
              .box
              .color(
                AppColors.primayColor,
              )
              .withRounded(
                value: 5,
              )
              .make(),
        ).centered().py16(),
      ]).centered(),
    );
  }
}
