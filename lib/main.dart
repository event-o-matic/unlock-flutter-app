import 'package:unlock/utils/colors.dart';
import 'package:unlock/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unlock',
        theme: ThemeData(
          primaryColor: ThemeColors.primary,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          indicatorColor: ThemeColors.primary,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.red)),
        ),
        builder: (context, widget) {
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        home: SplashScreen(),
      ),
    );
  }
}
