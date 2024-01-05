import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projecto/models/courseModel.dart';
import 'package:projecto/models/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  @override
  void initState() {
    super.initState();
    getAllCourses();
  }

  @override
  Widget build(BuildContext context) {
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

    List<String> imagesList = [
      'https://media.gcflearnfree.org/content/5e31ca08bc7eff08e4063776_01_29_2020/ProgrammingIllustration.png',
      'https://img.freepik.com/free-psd/3d-rendering-graphic-design_23-2149667482.jpg',
      'https://i.ibb.co/T89fV9K/DALL-E-2024-01-05-18-05-49-A-professional-and-modern-Human-Resource-Management-HRM-concept-image-dep.png',
    ];

    int categoriesIndex = 0;
    int coursesIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'All Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
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
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of items in a row
              crossAxisSpacing:
                  8.0, // Set the spacing between items horizontally
              mainAxisSpacing: 15.0, // Set the spacing between items vertically
            ),
            itemCount: categoryRedundant.length,
            shrinkWrap: true,
            scrollDirection:
                Axis.vertical, // Set the scroll direction to vertical
            itemBuilder: (BuildContext context, index) {
              Course course = courseList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    categoriesIndex = int.parse(course.courseCategory!);
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                        width: 180,
                        height: 120,
                        child: Image(
                          image: NetworkImage(imagesList[index]),
                          fit: BoxFit.fill,
                        )),
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        categoryRedundant[index],
                        style: TextStyle(
                          color: categoriesIndex == index
                              ? const Color.fromARGB(255, 9, 75, 196)
                              : Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
