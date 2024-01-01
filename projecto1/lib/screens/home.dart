import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projecto/models/courseModel.dart';
import 'package:projecto/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:projecto/screens/categories.dart';
import 'package:projecto/screens/profile.dart';
import 'package:projecto/screens/courses.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.id});
  final int id;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int isLoaded = 0;
  List<Course> courseList = [];

  getAllCourses() async {
    try {
      courseList = [];
      isLoaded = 0;
      String path = 'http://192.168.1.105:8000/GetCourse';
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        List ResponseAfterDecode = jsonDecode(response.body);
        for (var per in ResponseAfterDecode) {
          courseList.add(Course.fromJson(per));
        }

        if (courseList.isEmpty) {
          isLoaded = 3;
        } else {
          isLoaded = 1;
          print('Course NUMBER: ${courseList.first.id}');
          print('Course Name: ${courseList.first.courseName}');
        }
      } else {
        isLoaded = 2;
      }
    } catch (e) {
      print('Error fetching data Course: $e');
      isLoaded = 2; // Set an error state if there's an exception
    }

    setState(() {});
  }

  List<Customer> usersList = [];

  getAllPersons() async {
    try {
      usersList = [];
      isLoaded = 0;
      String path = "http://192.168.1.105:8000/SingleUser/${widget.id}";
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        usersList.add(Customer.fromJson(responseData));

        if (usersList.isEmpty) {
          isLoaded = 3;
        } else {
          isLoaded = 1;
          print('Person NUMBER: ${widget.id}');
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
    getAllCourses();
    getAllPersons();
  }

  @override
  Widget build(BuildContext context) {
    String dollar = String.fromCharCodes(Runes('\u0024'));
    // List<String> categories = [
    //   'Programming',
    //   '3D Design',
    //   'HR Management',
    // ];

    List<String> categorys =
        courseList.map((course) => course.courseCategory!).toList();

    List<int> coursePrices =
        courseList.map((course) => course.coursePrice!).toList();
    List<String> categoryRedundant = categorys.toSet().toList();
    debugPrint(categoryRedundant.toString());
    debugPrint(categorys.toString());
    debugPrint(categorys.length.toString());

    List<String> courses =
        courseList.map((course) => course.courseName!).toList();
    debugPrint(courses.toString());
    debugPrint(courses.length.toString());

    // List<int> coursePrice = [28, 45, 52];
    List<double> courseRating = [4.2, 4.5, 3.1];
    List<int> courseStudents = [7399, 1277, 2990];
    int categoriesIndex = 0;
    int coursesIndex = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: isLoaded == 1
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 15, right: 15),
                        child: Text(
                          'Hi, ${usersList.isNotEmpty ? usersList.first.firstName ?? "" : ""} ${usersList.isNotEmpty ? usersList.first.lastName ?? "" : ""}!',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 26),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 25),
                        child: InkWell(
                          onTap: () {
                            // Navigate to the new screen when the avatar is tapped
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                          id: widget.id,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue, // color of the border
                                width: 1.5, // width of the border
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20.0,
                              foregroundImage: NetworkImage(usersList
                                  .first.profileImage
                                  .toString()), // profile image URL
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: Text(
                      'What would you like to learn today?',
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          showCursor: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.black38),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Categories(),
                                ));
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 9, 75, 196),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                        itemCount: categoryRedundant.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          Course course = courseList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                categoriesIndex =
                                    int.parse(course.courseCategory!);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                categoryRedundant[index],
                                style: TextStyle(
                                    color: categoriesIndex == index
                                        ? const Color.fromARGB(255, 9, 75, 196)
                                        : Colors.black38,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Courses',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Courser(),
                                ));
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 9, 75, 196),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                        itemCount: categoryRedundant.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          Course course = courseList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                coursesIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: coursesIndex == index
                                        ? Colors.teal
                                        : Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    courses[index],
                                    style: TextStyle(
                                        color: coursesIndex == index
                                            ? Colors.white
                                            : Colors.black38,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 0, right: 15),
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      // color: Colors.red,
                      child: ListView.builder(
                        itemCount: categoryRedundant.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          Course course = courseList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10, right: 10),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Image(
                                          image: NetworkImage(
                                              course.courseImagePath ?? ''),
                                          fit: BoxFit.fill),
                                      height: 150,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 10),
                                          child: Text(
                                            categorys[index],
                                            style: TextStyle(
                                                color: Colors.amber[900],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, right: 10),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.bookmark_outline,
                                                color: Colors.teal,
                                              ),
                                              onPressed: () {},
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 15, right: 10),
                                      child: Text(
                                        courses[index],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 15,
                                          bottom: 10,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            '$dollar${coursePrices[index].toString()}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 9, 75, 196),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              '|',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              '⭐ ${courseRating[index].toString()}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              '|',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              courseStudents[index].toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Icon(Icons.people)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
