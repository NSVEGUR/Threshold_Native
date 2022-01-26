import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.ideographic,
      children: [
        ClipOval(
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            'assets/logo.png',
          ).box.height(30).make(),
        ),
        title.text.xl2.make().px8(),
      ],
    ).box.height(50).make().py16();
  }
}
