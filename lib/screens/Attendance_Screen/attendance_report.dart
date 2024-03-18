import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

class AttendanceReportPage extends StatefulWidget {
  final String selectedCourse;

  const AttendanceReportPage({Key? key, required this.selectedCourse}) : super(key: key);

  @override
  _AttendanceReportPageState createState() => _AttendanceReportPageState();
}

class _AttendanceReportPageState extends State<AttendanceReportPage> {
  List<Map<String, dynamic>> _attendanceReport = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      // Fetch attendance data for the selected course
      QuerySnapshot attendanceSnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.selectedCourse)
          .collection('Attendance')
          .get();

      Map<String, Map<String, int>> studentAttendance = {};

      // Iterate through attendance data to calculate total attendance for each student
      attendanceSnapshot.docs.forEach((doc) {
        String studentUid = doc['uid'];
        bool isPresent = doc['present'];

        if (!studentAttendance.containsKey(studentUid)) {
          studentAttendance[studentUid] = {'present': 0, 'absent': 0};
        }

        if (isPresent) {
          studentAttendance[studentUid]!['present'] = (studentAttendance[studentUid]!['present'] ?? 0) + 1;
        } else {
          studentAttendance[studentUid]!['absent'] = (studentAttendance[studentUid]!['absent'] ?? 0) + 1;
        }
      });

      // Fetch student details from Firestore using the student UID
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('uid', whereIn: studentAttendance.keys.toList())
          .get();

      // Create attendance report with student details and total attendance
      List<Map<String, dynamic>> report = [];
      studentsSnapshot.docs.forEach((doc) {
        String studentUid = doc['uid'];
        String fullName = doc['fullName'];
        String email = doc['email'];
        int presentCount = studentAttendance[studentUid]!['present'] ?? 0;
        int absentCount = studentAttendance[studentUid]!['absent'] ?? 0;

        report.add({
          'name': fullName,
          'uid': studentUid,
          'email': email,
          'present': presentCount,
          'absent': absentCount,
        });
      });

      setState(() {
        _attendanceReport = report;
      });
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report',style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: _attendanceReport.isEmpty
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: _attendanceReport.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> student = _attendanceReport[index];
            return ListTile(
              title: Text(student['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UID: ${student['uid']}'), // Show UID instead of ID
                  Text('Email: ${student['email']}'),
                  Text('Present: ${student['present']}'),
                  Text('Absent: ${student['absent']}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
