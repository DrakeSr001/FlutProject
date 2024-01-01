import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:projecto/models/userModel.dart';
import 'package:projecto/screens/categories.dart';
import 'package:projecto/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:email_otp/email_otp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isNumber(String value) {
    final numberRegex = r'^-?[0-9]+$';
    final match = RegExp(numberRegex).hasMatch(value);
    return match;
  }

  int isLoaded = 0;
  List<Customer> usersList = [];

  getAllUsers() async {
    try {
      usersList = [];
      isLoaded = 0;
      String path = 'http://192.168.1.105:8000/GetUser';
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        // print('Response Body: ${response.body}');
        List ResponseAfterDecode = jsonDecode(response.body);
        // print('Decoded JSON: $ResponseAfterDecode');
        for (var per in ResponseAfterDecode) {
          usersList.add(Customer.fromJson(per));
        }

        // if (usersList.isEmpty) {
        //   isLoaded = 3;
        // } else {
        //   isLoaded = 1;
        // }
      } else {
        print('Error Status Code: ${response.statusCode}');
        print('Error Response Body: ${response.body}');
        isLoaded = 2;
      }
    } catch (e) {
      print('Error fetching data: $e');
      isLoaded = 2; // Set an error state if there's an exception
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllUsers(); // Call _initData in initState
  }

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> authUser(LoginData data) async {
    debugPrint('Username: ${data.name}, Password: ${data.password}');

    await getAllUsers(); // Fetch user data

    Customer? user = usersList.firstWhere(
      (user) => user.email == data.name,
      orElse: () => Customer(email: '', password: ''),
    );

    if (usersList.isEmpty) {
      // Users list is empty, indicating an issue fetching data
      return 'Error fetching user data';
    }
    LoginMessages(flushbarTitleError: "Test");

    if (user.email != data.name) {
      debugPrint('Username: ${user.email}, Password: ${user.password}');
      return 'User does not exist';
    } else if (user.password != data.password) {
      debugPrint('Username: ${data.name}, Password: ${data.password}');
      return 'Password does not match';
    }

    // Authentication successful
    return Future.value(null);
  }

  Future<int?> getUserID(LoginData data) async {
    // Call authUser to get the user ID
    String? userId =
        await authUser(LoginData(name: data.name, password: data.password));

    if (userId == null) {
      Customer? user = usersList.firstWhere(
        (user) => user.email == data.name,
        orElse: () => Customer(email: '', password: ''),
      );
      // User ID is not null, you can use it here
      debugPrint('User ID from GetUserID trigger: ${user.id}');
      return Future.value(user.id);
    } else {
      // Handle the case where authUser returned null or an error occurred
      return null; // Provide a default value or throw an exception here
    }
  }

  Future<String?> signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');

    if (data.name == null ||
        data.password == null ||
        data.additionalSignupData == null) {
      // Users list is empty, indicating an issue fetching data
      return 'Error adding user, empty list';
    }
    return Future.delayed(loginTime).then((_) {
      addUser(
          data.additionalSignupData!['Username']!,
          data.additionalSignupData!['Firstname']!,
          data.additionalSignupData!['Lastname']!,
          data.name!,
          data.additionalSignupData!['Phone']!,
          data.password!,
          context);

      return null;
    });
  }

  Future<String> navigateToLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
    return 'Successful Registeration';
  }

  EmailOTP myAuth = EmailOTP();

  Future<String?> recoverPassword(String name) async {
    debugPrint('Name: $name');

    try {
      await getAllUsers();

      Customer? user = usersList.firstWhere(
        (user) => user.email == name,
        orElse: () => Customer(email: '', password: ''),
      );

      if (user.email != name) {
        debugPrint('Signup Name: ${user.email}, Used Email: $name');
        return 'User doesn\'t exist';
      } else {
        myAuth.setConfig(
            appEmail: "me@rohitchouhan.com",
            appName: "Recovery Email",
            userEmail: name,
            otpLength: 6,
            otpType: OTPType.digitsOnly);
        await myAuth.sendOTP();
        return null;
      }
    } catch (e) {
      print('Error during password recovery: $e');
      return 'An unexpected error occurred';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      additionalSignupFields: [
        UserFormField(
          keyName: 'Username',
          fieldValidator: (value) {
            if (value!.isEmpty) {
              return "Please enter your Username";
            } else if (value.length < 5) {
              return "Username must be more than 5 characters";
            }
            ;
          },
        ),
        UserFormField(
          keyName: 'Firstname',
          displayName: 'First Name',
          icon: Icon(Icons.person_sharp),
          fieldValidator: (value) {
            if (value!.isEmpty) {
              return "Please enter your first name.";
            } else if (value.length < 2) {
              return "First Name must be more than 1 character";
            } else if (isNumber(value)) {
              return "First name can not contain numbers";
            }
          },
        ),
        UserFormField(
            keyName: 'Lastname',
            displayName: 'Last Name',
            icon: Icon(Icons.person),
            fieldValidator: (value) {
              if (value!.isEmpty) {
                return "Please enter your last name.";
              } else if (value.length < 2) {
                return "First Name must be more than 1 character";
              } else if (isNumber(value)) {
                return "First name can not contain numbers";
              }
            }),
        UserFormField(
          keyName: 'Phone',
          displayName: 'Phone Number',
          icon: Icon(Icons.phone),
          fieldValidator: (value) {
            if (value!.isEmpty) {
              return "Please enter your phone number.";
            } else if (!value.startsWith('+20')) {
              return "Number must start with '+20XXXXXXXXX'";
            } else if (value.length < 5) {
              return "Phone Number must be more than 3 digits";
            }
          },
        ),
      ],
      title: 'Login',
      theme: LoginTheme(primaryColor: Colors.blue),
      logo: const AssetImage('assets/login.png'),
      onLogin: authUser,
      onSignup: signupUser,
      loginAfterSignUp: false,
      onRecoverPassword: recoverPassword,
      onSubmitAnimationCompleted: () async {
        try {
          String? authResult = await authUser(LoginData(
              name: usersList.first.email!,
              password: usersList.first.password!));

          int? userId = await getUserID(LoginData(
              name: usersList.first.email!,
              password: usersList.first.password!));

          if (authResult == null && userId != null) {
            debugPrint('userId in onSubmitAnim: $userId');

            if (userId != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(id: userId),
                ),
              );
            } else {
              // Handle the case where parsing to int failed
              debugPrint('Error: Unable to parse userId = $userId');
            }
          } else {
            // Handle the case where authUser returned an error or user ID is null
            debugPrint('Error: $authResult');
          }
        } catch (e) {
          // Handle any exceptions that might occur
          debugPrint('Error during onSubmitAnimationCompleted: $e');
        }
      },
    );
  }
}

addUser(String username, String firstName, String lastName, String email,
    String phone, String password, context) async {
  String path = 'http://192.168.1.105:8000/AddUser';
  var body = {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phoneNumber": phone,
  };
  try {
    final response = await http.post(Uri.parse(path),
        body: jsonEncode(body),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
  } catch (e) {
    print('Error during user creation: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('An unexpected error occurred')));
  }
}
