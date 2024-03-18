import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';
import 'attendance_report.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  _AttendanceReportState createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  String? _selectedCourse;
  List<String> _courses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance Report',
          style: TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCourse = newValue;
                    });
                    // Navigate to TakeAttendance page when a course is selected
                    if (_selectedCourse != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceReportPage(selectedCourse: _selectedCourse!,),
                        ),
                      );
                    }
                  },
                  items: _courses.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Course',
                    labelStyle: TextStyle(color: kPrimaryColor,fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchCourses() {
    FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((querySnapshot) {
      setState(() {
        _courses = querySnapshot.docs.map((doc) => doc.id).toList();
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
    });
  }
}
