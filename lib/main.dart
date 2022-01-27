import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/routes.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primayColor,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: Home.routeName,
      onGenerateRoute: (route) => generateAppRoute(route),
    );
  }
}
