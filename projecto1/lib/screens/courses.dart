import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projecto/models/courseModel.dart';
import 'package:projecto/models/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Courser extends StatefulWidget {
  const Courser({super.key});

  @override
  State<Courser> createState() => _CourserState();
}

class _CourserState extends State<Courser> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'All Courses',
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
        Container(
          margin: EdgeInsets.only(top: 60),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 3.5,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              Course course = courseList[index];
              return GestureDetector(
                onTap: () {
                  print('Clicked: ${course.id}');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Container(
                    height: 260,
                    width: 180,
                    decoration: BoxDecoration(
                        // color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(
                      children: [
                        Container(
                          height: 230,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: course.courseImagePath!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 20,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: course.isAvailable == true
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                    ),
                                    child: Center(
                                        child: Text(course.isAvailable == true
                                            ? 'Available'
                                            : 'Unavailable'))),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.heart_broken_sharp),
                                  color: Colors.red,
                                )
                              ],
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  course.courseName!,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Text("\$${course.coursePrice.toString()}")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: courseList.length,
          ),
          width: MediaQuery.of(context).size.width,
          height: 500,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, -2),
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
