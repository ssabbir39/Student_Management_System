import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:student_management_system/constants.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../Repository_and_Authentication/services/accounts_db.dart';

class TakeAttendance extends StatefulWidget {
  final String courseName; // Add courseName parameter
  const TakeAttendance({Key? key, required this.courseName}) : super(key: key);

  @override
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  AccountsDB _accountsDB = AccountsDB();
  List<DocumentSnapshot>? _students = [];
  Map<String, bool> _attendance = {};
  Map<String, bool> _attendance2 = {};
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  void _fetchStudents() {
    setState(() => loading = true); // Move loading state update before fetching data
    if (widget.courseName != null) {
      // Use widget.courseName instead of _selectedCourse
      FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseName) // Use widget.courseName instead of _selectedCourse
          .collection('students')
          .get()
          .then((querySnapshot) {
        setState(() {
          _students = querySnapshot.docs;
          loading = false; // Update loading state after fetching data
        });
      }).catchError((error) {
        print('Error fetching students: $error');
        setState(() {
          _students = [];
          loading = false; // Update loading state in case of error
        });
      });
    } else {
      setState(() => loading = false); // Update loading state if no course is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title:  Row(
          children: [
            Text(
              'Student Attendance',
              style: TextStyle(
                color: kTextWhiteColor,
              ),
            ),
            Spacer(),
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportDownload(docid: widget.courseName, attendanceData: _attendance2),
                ),
              );
            }, icon: Icon(Icons.download_for_offline_outlined),color: kTextWhiteColor,)
          ],
        ),
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _students != null
          ? Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: ListView.builder(
          itemCount: _students!.length,
          itemBuilder: (context, index) {
            String fullName = _students![index]['fullName'] ?? '';
            String email = _students![index]['email'] ?? '';
            String studentUid = _students![index].id; // Updated to get document ID
            String studentId = _students![index]['id'] ?? '';
            bool isPresent = _attendance[studentUid] ?? false; // Use studentUid for attendance
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kTextWhiteColor,
                  ),
                ),
                subtitle: Text(
                  'ID: $studentId\nEmail: $email',
                  style: const TextStyle(fontSize: 14, color: kTextWhiteColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _toggleAttendance(studentUid, true,studentId);
                        //_toggleAttendance2(studentId, true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isPresent ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Present',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _toggleAttendance(studentUid, false,studentId); // Use studentUid
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: !isPresent ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Absent',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
          : const Center(
        child: Text('No students found'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          submitAllAttendance(widget.courseName);
        },
        label: const Text('Submit Attendance'),
        icon: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _toggleAttendance(String studentUid, bool present,String studentId) {
    setState(() {
      _attendance[studentUid] = present;
      _attendance2[studentId] = present;
    });
  }

  Future<void> submitAllAttendance(String className) async {
    try {
      // Get the collection reference for the attendance of the specific course
      CollectionReference attendanceRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(className)
          .collection('Attendance');

      // Get current date
      DateTime currentDate = DateTime.now();

      // Loop through each student's attendance
      await Future.forEach(_attendance.entries, (entry) async {
        String studentUid = entry.key;
        bool present = entry.value;

        // Get student details
        DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
            .collection('courses')
            .doc(className)
            .collection('students')
            .doc(studentUid)
            .get();
        String studentName = studentSnapshot['fullName'];
        String studentId = studentSnapshot['id'];

        // Get existing attendance data for the current date, if any
        DocumentSnapshot? existingAttendanceSnapshot = await attendanceRef.doc(studentUid).get();
        Map<String, dynamic> attendanceData = {
          'name': studentName,
          'id': studentId,
          'present': 0,
          'absent': 0,
        };

        if (existingAttendanceSnapshot.exists) {
          attendanceData = existingAttendanceSnapshot.data() as Map<String, dynamic>;
        }

        // Update attendance count
        if (present) {
          attendanceData['present'] = (attendanceData['present'] ?? 0) + 1;
        } else {
          attendanceData['absent'] = (attendanceData['absent'] ?? 0) + 1;
        }

        // Store attendance data for each student along with date, name, ID, present, and absent counts
        await attendanceRef.doc(studentUid).set({
          'date': currentDate,
          'name': studentName,
          'id': studentId,
          'present': attendanceData['present'],
          'absent': attendanceData['absent'],
          'uid': studentUid, // Store student UID along with attendance data
        });
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance submitted successfully'),
        ),
      );
    } catch (e) {
      // Handle errors
      print('Error submitting attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit attendance. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}

class ReportDownload extends StatefulWidget {
  final String docid;
  final Map<String, bool> attendanceData;
  ReportDownload({required this.docid, required this.attendanceData});

  @override
  State<ReportDownload> createState() => _ReportDownloadState(docid: docid, attendanceData: attendanceData);
}

class _ReportDownloadState extends State<ReportDownload> {
  final String docid;
  final Map<String, bool> attendanceData;
  _ReportDownloadState({required this.docid, required this.attendanceData});

  @override
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    String? _logo = await rootBundle.loadString('assets/icons/datasheet.svg');

    // Extract attendance data
    final presentStudents = attendanceData.entries.where((entry) => entry.value).toList();
    final absentStudents = attendanceData.entries.where((entry) => !entry.value).toList();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Column(
                  children: [
                    pw.SvgImage(
                      svg: _logo!,
                      height: 100,
                    ),
                    pw.Text(
                      'Attendance Report - $docid',
                      style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Divider(),
                  ],
                ),
                pw.Text(
                  'Total Students: ${presentStudents.length + absentStudents.length}',
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Present Students: ${presentStudents.length}',
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Absent Students: ${absentStudents.length}',
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Divider(),
                pw.Text('Present Students:', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                for (var entry in presentStudents)
                  pw.Text(
                    'ID: ${entry.key}',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                pw.Divider(),
                pw.Text('Absent Students:', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                for (var entry in absentStudents)
                  pw.Text(
                    'ID: ${entry.key}',
                    style: pw.TextStyle(fontSize: 18),
                  ),
              ],
            ),
          );
        },
      ),
    );

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: generateDocument,
    );
  }
}