class Enrollment {
  int? id;
  String? enrollmentDate;
  int? course;
  int? user;

  Enrollment({this.id, this.enrollmentDate, this.course, this.user});

  Enrollment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enrollmentDate = json['enrollmentDate'];
    course = json['course'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enrollmentDate'] = this.enrollmentDate;
    data['course'] = this.course;
    data['user'] = this.user;
    return data;
  }
}
