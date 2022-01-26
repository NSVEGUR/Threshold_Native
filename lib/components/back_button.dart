import 'package:flutter/material.dart';
import 'package:threshold_native/constants.dart';
import 'package:velocity_x/velocity_x.dart';

Widget backButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.west_rounded,
      color: AppColors.secondaryTextColor,
    ),
  ).pOnly(right: 5);
}
