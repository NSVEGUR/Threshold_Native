import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants.dart';

class Input extends StatelessWidget {
  final String title;
  final String hintText;
  const Input({
    Key? key,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: VStack([
      title.text.xl2.make(),
      TextFormField(
        decoration: AppTextFields.minimalTextFieldDecoration
            .copyWith(hintText: hintText),
      ),
    ]));
  }
}
