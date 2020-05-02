import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const API_URL = "https://eventomatic-api.herokuapp.com";

class QRScanner extends StatefulWidget {
  final String util;

  const QRScanner({Key key, @required this.util}) : super(key: key);
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String error;
  String text;
  Color textColor = Colors.black;

  Future _scanQR() async {
    setState(() {
      text = "Scanning...";
      textColor = Colors.black;
      error = null;
    });
    try {
      String qrResult = await BarcodeScanner.scan();
      final result = await http.post(
        "$API_URL/tickets/check/${widget.util}",
        body: jsonEncode({"id": qrResult}),
        headers: {"Content-type": "Application/json"},
      );

      Map<String, dynamic> decodedResult = jsonDecode(result.body);
      print(decodedResult);
      if (result.statusCode != 200 || !decodedResult["success"]) {
        print("error called");
        throw HttpException(decodedResult["error"]);
      }

      setState(() {
        text = "Success: ${decodedResult["msg"]}";
        textColor = Colors.green;
      });
    } on PlatformException catch (ex) {
      error = ex.code == BarcodeScanner.CameraAccessDenied
          ? "Camera permission was denied"
          : "Unknown Error $ex";
    } on HttpException catch (e) {
      error = e.message;
    } on FormatException catch (e) {
      print(e);
      if (e.message == "Invalid envelope")
        error = "You pressed the back button before scanning anything!";
      else
        error = e.message;
    } catch (ex) {
      error = "Unknown Error $ex";
    } finally {
      if (error != null) {
        setState(() {
          text = "Error: $error";
          textColor = Colors.red;
        });
      }
    }
  }

  @override
  void initState() {
    text = "Scan QR code for ${widget.util}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR code for ${widget.util}"),
      ),
      body: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
