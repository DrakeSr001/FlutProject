class Course {
  int? id;
  String? courseName;
  String? courseDescription;
  String? courseImagePath;
  int? coursePrice;
  String? instructorName;
  String? courseCategory;
  String? courseReleaseDate;
  bool? isEnrollable;
  bool? isAvailable;

  Course(
      {this.id,
      this.courseName,
      this.courseDescription,
      this.courseImagePath,
      this.coursePrice,
      this.instructorName,
      this.courseCategory,
      this.courseReleaseDate,
      this.isEnrollable,
      this.isAvailable});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
    courseDescription = json['courseDescription'];
    courseImagePath = json['courseImagePath'];
    coursePrice = json['coursePrice'];
    instructorName = json['instructorName'];
    courseCategory = json['courseCategory'];
    courseReleaseDate = json['courseReleaseDate'];
    isEnrollable = json['isEnrollable'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseName'] = this.courseName;
    data['courseDescription'] = this.courseDescription;
    data['courseImagePath'] = this.courseImagePath;
    data['coursePrice'] = this.coursePrice;
    data['instructorName'] = this.instructorName;
    data['courseCategory'] = this.courseCategory;
    data['courseReleaseDate'] = this.courseReleaseDate;
    data['isEnrollable'] = this.isEnrollable;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
