class Lesson {
  int? id;
  String? lessonTitle;
  String? lessonDescription;
  String? videoUrl;
  String? lessonReleaseDate;
  bool? isAvailable;
  int? course;

  Lesson(
      {this.id,
      this.lessonTitle,
      this.lessonDescription,
      this.videoUrl,
      this.lessonReleaseDate,
      this.isAvailable,
      this.course});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonTitle = json['lessonTitle'];
    lessonDescription = json['lessonDescription'];
    videoUrl = json['videoUrl'];
    lessonReleaseDate = json['lessonReleaseDate'];
    isAvailable = json['isAvailable'];
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lessonTitle'] = this.lessonTitle;
    data['lessonDescription'] = this.lessonDescription;
    data['videoUrl'] = this.videoUrl;
    data['lessonReleaseDate'] = this.lessonReleaseDate;
    data['isAvailable'] = this.isAvailable;
    data['course'] = this.course;
    return data;
  }
}
