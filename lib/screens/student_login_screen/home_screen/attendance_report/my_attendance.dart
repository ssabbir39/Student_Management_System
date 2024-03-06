import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:student_management_system/constants.dart';
import '../../../../Announchment/data/custom_user.dart';
import '../../../../Announchment/services/accounts_db.dart';

class StudentAttendanceReportPage extends StatefulWidget {
  final CustomUser currentUser;

  const StudentAttendanceReportPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  _StudentAttendanceReportPageState createState() => _StudentAttendanceReportPageState();
}

class _StudentAttendanceReportPageState extends State<StudentAttendanceReportPage> {
  final AccountsDB _accountsDB = AccountsDB();
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    try {
      List<DocumentSnapshot>? courses = await _accountsDB.getFacultyCourses(widget.currentUser.uid);
      if (courses != null) {
        for (DocumentSnapshot course in courses) {
          String courseId = course.id;
          List<DocumentSnapshot>? attendance = await _accountsDB.getAttendanceByStudentAndCourse(courseId, widget.currentUser.uid);
          if (attendance != null) {
            for (DocumentSnapshot record in attendance) {
              DateTime date = record['date'].toDate();
              bool present = record['present'];
              String courseName = course['className'];
              setState(() {
                attendanceData.add({
                  'courseName': courseName,
                  'date': date,
                  'present': present,
                });
              });
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Attendance Report',style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: attendanceData.isNotEmpty
            ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding),
              topRight: Radius.circular(kDefaultPadding),
            ),
            color: kOtherColor,
          ),
              child: ListView.builder(
                      itemCount: attendanceData.length,
                      itemBuilder: (context, index) {
              String courseName = attendanceData[index]['courseName'];
              DateTime date = attendanceData[index]['date'];
              bool present = attendanceData[index]['present'];
              return ListTile(
                title: Text('Course: $courseName'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${DateFormat('yyyy-MM-dd').format(date)}'),
                    Text('Status: ${present ? 'Present' : 'Absent'}'),
                  ],
                ),
              );
                      },
                    ),
            )
            : Center(
          child: Text('No attendance found',style: TextStyle(fontSize: 16,color: kPrimaryColor),),
        ),
      ),
    );
  }
}
