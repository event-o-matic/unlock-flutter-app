import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unlock/utils/colors.dart';
import 'package:unlock/models/student.dart';
import 'package:unlock/utils/constants.dart';
import 'package:unlock/widgets/error_card.dart';
import 'package:unlock/widgets/student_card.dart';
import 'package:unlock/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class QRScannerScreen extends StatefulWidget {
  @override
  const QRScannerScreen();
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String text = "Click SCAN";
  String error;
  Student student;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.bgGray,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(),
            SizedBox(height: 20),
            _buildBody(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: FloatingActionButton.extended(
          icon: Icon(
            Icons.qr_code,
            size: ScreenUtil().setSp(20),
          ),
          label: Text("SCAN"),
          backgroundColor: ThemeColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: _scanQR,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildDefaultBody() {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          "assets/scan_qr.jpg",
          width: width * 0.6,
        ),
        SizedBox(height: 30),
        Text(
          text,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: ThemeColors.bodyBlack,
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: VerticalDivider(
            color: Color(0xffffa27a),
            thickness: 2.5,
            indent: 0,
          ),
        ),
        Icon(
          Icons.arrow_downward,
          size: 30,
          color: Color(0xffffa27a),
        )
      ],
    );
  }

  Widget _buildBody() {
    if (error != null) return ErrorCard(error: error, onClose: reset);

    if (student == null) return _buildDefaultBody();

    return StudentCard(
      student: student,
      isLoading: isLoading,
      onReload: (student) => _checkStatus(student),
    );
  }

  void reset() {
    setState(() {
      text = "Click SCAN";
      error = null;
      student = null;
      isLoading = false;
    });
  }

  Future _checkStatus(Student student) async {
    setState(() => isLoading = true);

    final response = await http.get(
      "$API_URL/consent_received/${student.id}",
      headers: {"Content-type": "Application/json"},
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () => throw HttpException("No response from server, please contact support team!"),
    );

    if (response.statusCode != 200) throw HttpException("${response.statusCode} - ${response.reasonPhrase}");

    final decodedResponse = jsonDecode(response.body);

    Future _createStudent() async {
      return http.post("http://27.109.7.68:8080/unlock/entry.php", body: {
        "Roll_no": student.id,
      });
    }

    /* if ((decodedResponse["error"] == null && decodedResponse["success"] == null) ||
        (decodedResponse["success"] != null && decodedResponse["data"] == null)) {
      throw "Not proper response received from the API call!";
    }
    if (decodedResponse["error"] != null) {
      throw HttpException(decodedResponse["error"]);
    } */

    if (decodedResponse['data'] == null || decodedResponse['data']['Received'] == null)
      throw "Not proper response received from the API call!";

    if (decodedResponse['data']['Received'] && decodedResponse['data']['File_name'] == null) {
      decodedResponse['data']['File_name'] = "$CONSENT_URL/${student.id}.png";
    }

    if (decodedResponse['data']['Received'] == true) {
      await _createStudent();
    }

    setState(() {
      student.consentStatus = decodedResponse['data']['Received'];
      student.fileUrl = decodedResponse['data']['File_name'];
      isLoading = false;
    });
  }

  Future _scanQR() async {
    setState(() {
      text = "Scanning...";
      error = null;
      student = null;
    });
    try {
      String qrResult = await BarcodeScanner.scan();

      setState(() {
        student = Student.fromMap(jsonDecode(qrResult));
      });

      await _checkStatus(student);
    } on PlatformException catch (e) {
      error = e.code == BarcodeScanner.CameraAccessDenied
          ? "Camera permission was denied, RETRY or go to `app settings` and accept the camera permission to continue!"
          : "Unknown Error: $e";
    } on HttpException catch (e) {
      error = "$e";
    } on FormatException catch (e) {
      if (e.message == "Invalid envelope")
        error = "You pressed the back button before scanning anything, RETRY!";
      else if ("$e".contains("${API_URL.split(RegExp(r"/+"))[1]} not found"))
        error = "Internal Client Error: Invalid `API URL`.\nPlease contact support team!";
      else
        error = "$e";
    } catch (e, trace) {
      print("Unknown Error: $e \n $trace");
      error = "Internal error occured. Please contact support team!";
    } finally {
      // reload if error occured
      if (error != null) setState(() {});
    }
  }
}
