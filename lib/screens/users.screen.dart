import 'package:flutter/material.dart';
import 'package:threshold_native/screens/login.screens/login.screen.1.dart';
import 'package:velocity_x/velocity_x.dart';
import '../components/logo.component.dart';
import '../constants.dart';

class UsersSelect extends StatefulWidget {
  static const String id = 'users.screen';
  const UsersSelect({Key? key}) : super(key: key);

  @override
  _UsersSelectState createState() => _UsersSelectState();
}

class _UsersSelectState extends State<UsersSelect> {
  var selected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Logo(title: 'Threshold'),
        ZStack(
          [
            ClipOval(
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: AppColors.primayColor.withOpacity(0.5),
              ),
            )
                .box
                .height(context.percentHeight * 20)
                .width(context.percentWidth * 100)
                .make()
                .positioned(
                  bottom: -200,
                ),
            VStack(
              [
                "What suits you!?"
                    .text
                    .xl4
                    .extraBold
                    .color(AppColors.primaryTextColor)
                    .make(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: selected == 1
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {selected = 1})
                  },
                  icon: selected == 1
                      ? const Icon(Icons.arrow_forward_ios)
                      : Container(),
                  label: "Student".text.xl2.make(),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: selected == 2
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {selected = 2})
                  },
                  icon: selected == 2
                      ? const Icon(Icons.arrow_forward_ios)
                      : Container(),
                  label: "Teacher".text.xl2.make(),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: selected == 3
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {selected = 3})
                  },
                  icon: selected == 3
                      ? const Icon(Icons.arrow_forward_ios)
                      : Container(),
                  label: "Admin".text.xl2.make(),
                ),
              ],
              alignment: MainAxisAlignment.spaceEvenly,
            )
                .box
                .height(context.percentHeight * 40)
                .width(context.percentWidth * 100)
                .make()
                .positioned(
                  top: 0,
                  left: 0,
                ),
            Image.asset('assets/books.png').box.height(150).make().positioned(
                  bottom: 100,
                ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primayColor,
              ),
              onPressed: () => {
                Navigator.pushNamed(context, LoginScreenOne.id),
              },
              child: "Continue".text.xl2.make().p8(),
            ).positioned(
              bottom: 0,
            )
          ],
          alignment: Alignment.center,
        )
            .box
            .height(context.percentHeight * 70)
            .width(context.percentWidth * 100)
            .make(),
      ].vStack().py32().px16(),
    );
  }
}
