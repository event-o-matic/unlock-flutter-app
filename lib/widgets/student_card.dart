import 'package:unlock/models/student.dart';
import 'package:flutter/material.dart';
import 'package:unlock/utils/extentions.dart';
import 'package:unlock/utils/colors.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({Key key, this.student, this.isLoading, this.onReload})
      : super(key: key);
  final Student student;
  final bool isLoading;
  final Function(Student) onReload;

  @override
  Widget build(BuildContext context) {
    print(student.consentStatus);
    return AspectRatio(
      aspectRatio: 11 / 16,
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
                        fontSize: 20,
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
                        radius: 60,
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID: ${student?.id}",
                      style: TextStyle(fontSize: 18),
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
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            ": ${student?.program}",
                            style: TextStyle(fontSize: 16),
                          )),
                        ]),
                        if (student?.branch != null &&
                            student.branch.isNotEmpty)
                          TableRow(children: [
                            TableCell(
                                child: Text(
                              "Branch",
                              style: TextStyle(fontSize: 16),
                            )),
                            TableCell(
                                child: Text(
                              ": ${student?.branch}",
                              style: TextStyle(fontSize: 16),
                            )),
                          ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "Year",
                            style: TextStyle(fontSize: 16),
                          )),
                          TableCell(
                            child: Text(
                              ": " + int.tryParse(student?.year).ordinal(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "Semester",
                            style: TextStyle(fontSize: 16),
                          )),
                          TableCell(
                            child: Text(
                              ": Sem - " +
                                  int.tryParse(student?.semester).toRoman(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Spacer(flex: 2),
                    MaterialButton(
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
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Reload Status",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
            style: TextStyle(color: Colors.green, fontSize: 16))
        : Text("Consent is not submitted!",
            style: TextStyle(color: Colors.red, fontSize: 16));
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
}
