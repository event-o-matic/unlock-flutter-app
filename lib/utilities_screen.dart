import 'package:flutter/material.dart';
import 'package:eventomatic/qr_scanner.dart';

const allowedUtils = [
  "checkin",
  "regkit",
  "breakfast",
  "lunch",
  "dinner",
  "prize",
  "certificate",
];

class UtilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Utility to scan QR Code"),
      ),
      body: Center(
        child: GridView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: allowedUtils
              .map((util) => RaisedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScanner(util: util),
                      ),
                    ),
                    child: Text(
                      util,
                      style: TextStyle(fontSize: 18),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
