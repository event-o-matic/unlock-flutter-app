import 'package:unlock/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Logo extends StatelessWidget {
  const Logo({this.fontSize, this.iconSize});
  final double fontSize;
  final double iconSize;

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Unlock",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: fontSize ?? 45,
                fontWeight: FontWeight.bold,
                color: ThemeColors.orange,
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              "assets/infinite.svg",
              color: ThemeColors.primary,
              width: iconSize,
            ),
          ],
        ),
        InkWell(
          // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          onTap: () => _launchURL("https://pruthvipatel.com"),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColors.bodyBlack,
                  fontWeight: FontWeight.bold,
                ),
                text: "Developed By: ",
                children: [
                  TextSpan(
                    text: "Pruthvi Patel",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.normal,
                      // color: ThemeColors.orange,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
