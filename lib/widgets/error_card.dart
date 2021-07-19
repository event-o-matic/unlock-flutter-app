import 'package:flutter/material.dart';
import 'package:unlock/utils/colors.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({this.error, this.onClose});
  final String error;
  final Function onClose;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        height: height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: ThemeColors.errorRed,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "ERROR",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    if (onClose != null)
                      IconButton(
                        onPressed: onClose,
                        icon: Icon(Icons.close, color: Colors.white),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  error,
                  style: TextStyle(color: ThemeColors.bodyBlack, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
