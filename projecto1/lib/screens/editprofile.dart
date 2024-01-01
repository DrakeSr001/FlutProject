import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projecto/models/userModel.dart';
import 'package:projecto/screens/profile.dart';

class EditProfileScreen extends StatefulWidget {
  final Customer user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController profileImgController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    passwordController = TextEditingController(text: widget.user.password);
    profileImgController =
        TextEditingController(text: widget.user.profileImage);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
  }

  updateUser(String username, String firstName, String lastName, String email,
      String phone, String password, context) async {
    String path =
        'http://192.168.1.105:8000/UpdateUser/${widget.user.id}/update/';
    var body = {
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "phoneNumber": phone,
    };
    try {
      final response = await http.put(Uri.parse(path),
          body: jsonEncode(body),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });

      debugPrint('User Profile Update Complete!');
      debugPrint(widget.user.id.toString());
      debugPrint(response.body);
    } catch (e) {
      print('Error during user creation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred')));
    }
  }

  @override
  void dispose() {
    // clean controllers
    usernameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    profileImgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  controller: firstNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  controller: lastNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  controller: phoneNumberController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Profile image URL'),
                  controller: profileImgController,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back without saving changes
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          updateUser(
                            usernameController.text,
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            phoneNumberController.text,
                            passwordController.text,
                            context,
                          );

                          // Introduce a small delay (e.g., 500 milliseconds) before navigating
                          await Future.delayed(Duration(milliseconds: 500));

                          // Check if the widget is still mounted before navigating
                          if (mounted) {
                            print('Save changes pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(id: widget.user.id!),
                              ),
                            );
                            setState(() {});
                          }
                        } catch (e) {
                          // Handle any errors that occurred during the update or navigation
                          print('Error during save changes: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('An unexpected error occurred')),
                          );
                        }
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
