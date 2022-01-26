import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:threshold_native/components/logo.dart';
import 'package:threshold_native/constants.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:threshold_native/login/login.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Roles role = Roles.student;
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
                    primary: role == Roles.student
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {
                          role = Roles.student,
                        })
                  },
                  icon: role == Roles.student
                      ? const Icon(Icons.arrow_forward_ios)
                      : Container(),
                  label: "Student".text.xl2.make(),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: role == Roles.teacher
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {
                          role = Roles.teacher,
                        })
                  },
                  icon: role == Roles.teacher
                      ? const Icon(Icons.arrow_forward_ios)
                      : Container(),
                  label: "Teacher".text.xl2.make(),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: role == Roles.admin
                        ? AppColors.primaryTextColor
                        : AppColors.secondaryTextColor,
                  ),
                  onPressed: () => {
                    setState(() => {
                          role = Roles.admin,
                        })
                  },
                  icon: role == Roles.admin
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
                Navigator.pushNamed(
                  context,
                  Login.routeName,
                  arguments: role,
                ),
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
