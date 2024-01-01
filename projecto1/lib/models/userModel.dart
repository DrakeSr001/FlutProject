class Customer {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? profileImage;
  String? phoneNumber;
  List<int>? enrolledCourses;

  Customer(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.profileImage,
      this.phoneNumber,
      this.enrolledCourses});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    enrolledCourses = json['enrolledCourses'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profileImage'] = this.profileImage;
    data['phoneNumber'] = this.phoneNumber;
    data['enrolledCourses'] = this.enrolledCourses;
    return data;
  }
}
