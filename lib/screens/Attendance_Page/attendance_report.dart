import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AttendanceReportPage extends StatefulWidget {
  final String selectedCourse;

  const AttendanceReportPage({Key? key, required this.selectedCourse}) : super(key: key);

  @override
  _AttendanceReportPageState createState() => _AttendanceReportPageState();
}

class _AttendanceReportPageState extends State<AttendanceReportPage> {
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .where('course', isEqualTo: widget.selectedCourse)
          .get();

      List<Map<String, dynamic>> data = [];

      querySnapshot.docs.forEach((doc) {
        String studentId = doc['studentId'];
        bool present = doc['present'];
        DateTime date = doc['date'].toDate(); // Convert Firestore timestamp to DateTime

        // Check if the student exists in the data list
        int index = data.indexWhere((element) => element['studentId'] == studentId);
        if (index != -1) {
          // If the student exists, update their attendance
          if (present) {
            data[index]['totalPresent']++;
          } else {
            data[index]['totalAbsent']++;
          }
        } else {
          // If the student does not exist, add them to the data list
          data.add({
            'studentId': studentId,
            'totalPresent': present ? 1 : 0,
            'totalAbsent': present ? 0 : 1,
          });
        }
      });

      setState(() {
        attendanceData = data;
      });
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  Future<void> _downloadPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            data: <List<String>>[
              <String>['Student ID', 'Total Present', 'Total Absent'],
              ...attendanceData.map((item) => [item['studentId'], '${item['totalPresent']}', '${item['totalAbsent']}']),
            ],
          );
        },
      ),
    );

    final String dir = (await getExternalStorageDirectory())!.path;
    final String path = '$dir/${widget.selectedCourse}_Attendance_Report.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF downloaded successfully',style: TextStyle(fontSize: 16),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses: ${widget.selectedCourse}',
          style: TextStyle(
            color: kTextWhiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _downloadPdf,
            icon: Icon(Icons.download,color: kTextWhiteColor,),
          ),
        ],
      ),
      body: attendanceData.isNotEmpty
          ? ListView.builder(
        itemCount: attendanceData.length,
        itemBuilder: (context, index) {
          // Display attendance report for each student
          String studentId = attendanceData[index]['studentId'];
          int totalPresent = attendanceData[index]['totalPresent'];
          int totalAbsent = attendanceData[index]['totalAbsent'];

          return ListTile(
            title: Text('Student ID: $studentId'),
            subtitle: Text('Total Present: $totalPresent, Total Absent: $totalAbsent'),
          );
        },
      )
          : Center(
        child: Text(
          'No attendance found',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
