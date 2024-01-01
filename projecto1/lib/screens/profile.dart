import 'package:flutter/material.dart';
import 'package:projecto/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projecto/screens/editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.id});
  final int id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int isLoaded = 0;
  List<Customer> usersList = [];

  getAllPersons() async {
    try {
      usersList = [];
      isLoaded = 0;
      String path = 'http://192.168.1.105:8000/SingleUser/${widget.id}';
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        usersList.add(Customer.fromJson(responseData));

        if (usersList.isEmpty) {
          isLoaded = 3;
        } else {
          isLoaded = 1;
          print('Person NUMBER: ${usersList.first.id}');
          print('Person Name: ${usersList.first.username}');
        }
      } else {
        isLoaded = 2;
      }
    } catch (e) {
      print('Error fetching data Person: $e');
      isLoaded = 2; // Set an error state if there's an exception
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllPersons();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue, // Set the color of the border
                    width: 3.0, // Set the width of the border
                  ),
                ),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(usersList
                      .first.profileImage!), // Replace with your image path
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfileScreen(user: usersList.first),
                    ),
                  );
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 60.0),
              ProfileTextBox(
                  label: 'Username',
                  value: usersList.isNotEmpty
                      ? usersList.first.username ?? ""
                      : ""),
              ProfileTextBox(
                  label: 'Email',
                  value:
                      usersList.isNotEmpty ? usersList.first.email ?? "" : ""),
              ProfileTextBox(
                  label: 'First Name',
                  value: usersList.isNotEmpty
                      ? usersList.first.firstName ?? ""
                      : ""),
              ProfileTextBox(
                  label: 'Last Name',
                  value: usersList.isNotEmpty
                      ? usersList.first.lastName ?? ""
                      : ""),
              ProfileTextBox(
                  label: 'Phone Number',
                  value: usersList.isNotEmpty
                      ? usersList.first.phoneNumber ?? ""
                      : ""),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTextBox extends StatelessWidget {
  final String label;
  final String value;

  ProfileTextBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        initialValue: value,
      ),
    );
  }
}
