import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';

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
        title: const Text(
          'Student Attendance',
          style: TextStyle(
            color: kTextWhiteColor,
          ),
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
                        _toggleAttendance(studentUid, true); // Use studentUid
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
                        _toggleAttendance(studentUid, false); // Use studentUid
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

  void _toggleAttendance(String studentUid, bool present) {
    setState(() {
      _attendance[studentUid] = present;
    });
  }

  Future<void> submitAllAttendance(String className) async {
    try {
      // Get the collection reference for the attendance of the specific course
      CollectionReference attendanceRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(className)
          .collection('Attendance');

      // Loop through each student's attendance
      await Future.forEach(_attendance.entries, (entry) async {
        String studentUid = entry.key;
        bool present = entry.value;

        // Store attendance data for each student
        await attendanceRef.doc(studentUid).set({
          'date': Timestamp.now(),
          'present': present,
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
