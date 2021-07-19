import 'package:unlock/utils/colors.dart';
import 'package:unlock/screens/qr_scanner_screen.dart';
import 'package:unlock/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String error;

  @override
  void initState() {
    wakeupServer();
    Future.delayed(Duration(seconds: 5)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QRScannerScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(
            //   "assets/scan_qr.jpg",
            //   width: mq.width * 0.6,
            // ),
            Container(
              height: mq.height * 0.3,
              child: FlareActor(
                "assets/scan_qr_2.flr",
                alignment: Alignment.center,
                sizeFromArtboard: false,
                animation: "scan",
                color: ThemeColors.orange,
              ),
            ),

            // SizedBox(height: 30),
            // Logo(),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.primary),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }

  Future wakeupServer() async {
    print("Waking up server...");
    setState(() => error = null);
    final response = await http.get("$API_URL");

    if (response.statusCode != 200) {
      return print("Error occured while waking up the server!");
    }
    print("server woke up successfully...");
  }
}
