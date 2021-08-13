class Student {
  String id;
  String fullname;
  String school;
  String program;
  String branch;
  String year;
  String semester;
  bool consentStatus = false;
  String fileUrl;

  Student(this.id, this.fullname, this.school, this.program, this.branch,
      this.year, this.semester, this.consentStatus, this.fileUrl);

  Student.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.fullname = map['fullname'];
    this.school = map['school'];
    this.program = map['program'];
    this.branch = map['branch'];
    this.year = map['year'];
    // this.semester = map['semester'];
  }
}
