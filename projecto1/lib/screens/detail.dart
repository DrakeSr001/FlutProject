import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecto/models/courseModel.dart';
import 'package:projecto/models/lessonModel.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class DetailedProduct extends StatefulWidget {
  const DetailedProduct({super.key, required this.id});
  final int id;

  @override
  State<DetailedProduct> createState() => _DetailedProductState();
}

class _DetailedProductState extends State<DetailedProduct> {
  int isLoaded = 0;
  List<Course> courseList = [];

// Modify the getAllBooks method to handle errors and update the isLoaded state properly
  getAllCourse() async {
    try {
      courseList = [];
      isLoaded = 0;
      String path = "http://192.168.1.105:8000/SingleBook/${widget.id}";
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        courseList.add(Course.fromJson(responseData));

        if (courseList.isEmpty) {
          isLoaded = 3;
        } else {
          isLoaded = 1;
          print('Lesson NUMBER: ${widget.id}');
          print('First Lesson Name: ${courseList.first.courseName}');
        }
      } else {
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
    getAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 235, 216, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_important)),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_basket_rounded)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (isLoaded == 1 && courseList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 135),
                child: Text(
                  '${courseList.first.courseName}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: const Color.fromARGB(255, 0, 10, 150)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 125.0),
              child: Text(
                'Etiam mollis metus non purus',
                style: TextStyle(color: const Color.fromRGBO(9, 15, 71, 0.45)),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 327,
                    height: 200,
                    child: CachedNetworkImage(
                      height: 170,
                      width: 141,
                      imageUrl: courseList.first.courseImagePath!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 175),
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: courseList.first.isAvailable == true
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                        child: Center(
                            child: Text(courseList.first.isAvailable == true
                                ? 'In Stock'
                                : 'Sold Out'))),
                    courseList.first.isAvailable == true
                        ? Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/000/350/565/small/Real_Estate__284_29.jpg',
                            width: 45,
                            height: 48,
                          )
                        : Image.network(
                            'https://assets.bigcartel.com/account_images/4050258/no+rent+logo+2020.png',
                            width: 60,
                            height: 80,
                          )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 275.0),
              child: Text(
                courseList.first.coursePrice.toString() + "\$",
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 225.0),
              child: Text(
                "Add to cart",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 265.0),
              child: Text(
                "Caramel",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              thickness: 0.7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200.0),
              child: Text(
                "Product Details",
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 320,
              child: Text(
                textAlign: TextAlign.left,
                courseList.first.courseDescription!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 320,
              child: Row(
                children: [
                  Text(
                    "Author",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    '${courseList.first.instructorName}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 320,
              child: Row(
                children: [
                  Text(
                    "Publisher",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 47,
              width: 333,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
