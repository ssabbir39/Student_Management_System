import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';
import 'attendance_report.dart';

class SelectCoursesPage extends StatefulWidget {
  const SelectCoursesPage({super.key});

  @override
  _SelectCoursesPageState createState() => _SelectCoursesPageState();
}

class _SelectCoursesPageState extends State<SelectCoursesPage> {
  String? selectedCourses;
  List<String> coursesList = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('courses').get();

      List<String> courses = [];

      querySnapshot.docs.forEach((doc) {
        String courseName = doc['className'];
        courses.add(courseName);
      });

      setState(() {
        coursesList = courses;
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Courses',style: TextStyle(
          color: kTextWhiteColor,
        ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Choice a Course",style: TextStyle(color: kPrimaryColor,fontSize: 20),),
              DropdownButton<String>(
                value: selectedCourses,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCourses = newValue;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceReportPage(selectedCourse: newValue!,),
                    ),
                  );
                },
                items: coursesList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                // Customize the dropdown button's appearance
                style: TextStyle(
                  color: Colors.blue, // Change the text color
                  fontSize: 18.0, // Change the text size
                ),
                icon: Icon(
                  Icons.arrow_downward, // Change the dropdown icon
                  color: Colors.blue, // Change the icon color
                ),
                // Customize the dropdown menu's appearance
                dropdownColor: Colors.white, // Change the dropdown menu's background color
                elevation: 4, // Change the shadow elevation
                // Add a border to the dropdown menu
                underline: Container(
                  height: 2,
                  color: Colors.blue, // Change the underline color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
