import 'package:unlock/colors.dart';
import 'package:unlock/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unlock',
      theme: ThemeData(
        primaryColor: ThemeColors.primary,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        indicatorColor: ThemeColors.primary,
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.red)),
      ),
      home: SplashScreen(),
    );
  }
}
