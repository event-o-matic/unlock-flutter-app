import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:unlock/models/student.dart';
import 'package:flutter/material.dart';
import 'package:unlock/utils/constants.dart';
import 'package:unlock/utils/extentions.dart';
import 'package:unlock/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({Key key, this.student, this.isLoading, this.onReload})
      : super(key: key);
  final Student student;
  final bool isLoading;
  final Function(Student) onReload;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 16,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xFF8D3646),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Navrachana University".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider(),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.14,
                        backgroundImage: _buildStatusIcon(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: _buildStatusText(),
                      height: 25,
                    ),
                    Spacer(),
                    Text(
                      student.fullname.toLowerCase().capitalize() ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID: ${student?.id}",
                      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    ),
                    Spacer(),
                    Table(
                      defaultColumnWidth: FixedColumnWidth(100),
                      // border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Program",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(14)),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            ": ${student?.program}",
                            style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                          )),
                        ]),
                        if (student?.branch != null &&
                            student.branch.isNotEmpty)
                          TableRow(children: [
                            TableCell(
                                child: Text(
                              "Branch",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(14)),
                            )),
                            TableCell(
                                child: Text(
                              ": ${student?.branch}",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(14)),
                            )),
                          ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "Year",
                            style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                          )),
                          (student.year == "Alumni")
                              ? (TableCell(
                                  child: Text(
                                    ": ${student?.year} ",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ))
                              : (TableCell(
                                  child: Text(
                                    ": " +
                                        int.tryParse(student?.year).ordinal(),
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ))
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "Semester",
                            style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                          )),
                          (student.semester == "Alumni")
                              ? (TableCell(
                                  child: Text(
                                    ": ${student?.semester} ",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ))
                              : (TableCell(
                                  child: Text(
                                    ": Sem - ${student?.semester}",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ))
                        ]),
                      ],
                    ),
                    Spacer(flex: 2),
                    student.consentStatus
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: MaterialButton(
                                          height: ScreenUtil().setHeight(30),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: ThemeColors.primary,
                                          onPressed: () => onReload(student),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                                size: ScreenUtil().setSp(13),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Reload Status",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(10)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        height: ScreenUtil().setHeight(30),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: ThemeColors.primary,
                                        onPressed: () =>
                                            {showDialogBox(context)},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.contact_mail,
                                              color: Colors.white,
                                              size: ScreenUtil().setSp(13),
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(
                                              "View Consent",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil().setSp(10)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    height: ScreenUtil().setHeight(30),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: ThemeColors.primary,
                                    onPressed: () =>
                                        {showUserDialogBox(context)},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified_user,
                                          color: Colors.white,
                                          size: ScreenUtil().setSp(13),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          "View Photo",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(10)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        : (Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: MaterialButton(
                                  height: ScreenUtil().setHeight(30),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: ThemeColors.primary,
                                  onPressed: () => onReload(student),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                        size: ScreenUtil().setSp(13),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Reload Status",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MaterialButton(
                                height: ScreenUtil().setHeight(30),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: ThemeColors.primary,
                                onPressed: () => {showUserDialogBox(context)},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Colors.white,
                                      size: ScreenUtil().setSp(13),
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "View Photo",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(10)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    if (isLoading)
      return Container(
        alignment: Alignment.center,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.primary),
        ),
      );

    if (student.consentStatus == null) {
      return Text("ERROR",
          style: TextStyle(color: Colors.yellow, fontSize: 16));
    }

    return student.consentStatus
        ? Text("Consent Form has submitted!",
            style: TextStyle(
                color: Colors.green, fontSize: ScreenUtil().setSp(15)))
        : Text("Consent is not submitted!",
            style:
                TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(15)));
  }

  ImageProvider _buildStatusIcon() {
    if (isLoading) return AssetImage("assets/scanning.gif");

    if (student.consentStatus == null) {
      return AssetImage("assets/warning.png");
    }

    return student.consentStatus
        ? AssetImage("assets/checked.png")
        : AssetImage("assets/cancel.png");
  }

  showDialogBox(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PinchZoom(
                  maxScale: 2.5,
                  child: Image.network(
                    student.fileUrl,
                    errorBuilder: (_, __, ___) => Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 300.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Consent Form Unavailable",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  showUserDialogBox(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PinchZoom(
                  maxScale: 2.5,
                  child: Image.network(
                    '$PHOTO_URL/${student.id}.jpg',
                    errorBuilder: (_, __, ___) => Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 300.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Photo Unavailable",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
