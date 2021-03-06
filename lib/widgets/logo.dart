import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unlock/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({this.fontSize, this.iconSize});
  final double fontSize;
  final double iconSize;

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
                fontSize: ScreenUtil().setSp(40),
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
      ],
    );
  }
}
