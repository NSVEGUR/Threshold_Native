import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'paths.dart';
import 'screens/users.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primayColor,
        // textTheme: GoogleFonts.latoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: const LoginScreenOne(),
      initialRoute: UsersSelect.id,
      routes: appRouter(context: context),
    );
  }
}
