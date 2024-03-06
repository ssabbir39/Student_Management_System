import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';
import '../../Announchment/services/accounts_db.dart';

class MakeAttendance extends StatefulWidget {
  const MakeAttendance({Key? key}) : super(key: key);

  @override
  _MakeAttendanceState createState() => _MakeAttendanceState();
}

class _MakeAttendanceState extends State<MakeAttendance> {
  AccountsDB _accountsDB = AccountsDB(); // Initialize AccountsDB
  List<DocumentSnapshot>? _students = []; // List of students from Firestore
  Map<String, bool> _attendance = {}; // Map to store attendance status

  @override
  void initState() {
    super.initState();
    _fetchStudents(); // Fetch student data when the page initializes
  }

  Future<void> _fetchStudents() async {
    // Retrieve list of student accounts from Firestore
    List? students = await _accountsDB.createAccountDataList();
    setState(() {
      _students = students
          ?.where((student) => student['type'] == 'student')
          .toList() as List<DocumentSnapshot>?;
      // Initialize attendance map with default values (false for absent)
      _attendance = Map.fromIterable(
        _students!,
        key: (student) => student.id,
        value: (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text('Student Attendance',style: TextStyle(
          color: kTextWhiteColor,
        ),),
      ),
      body: _students != null
          ? Container(
        decoration: BoxDecoration(
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
            String studentId = _students![index]['id'] ?? '';
            bool isPresent = _attendance[studentId] ?? false;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kTextWhiteColor,
                  ),
                ),
                subtitle: Text(
                  'ID: $studentId\nEmail: $email',
                  style: TextStyle(
                      fontSize: 14,
                      color: kTextWhiteColor
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _toggleAttendance(studentId, true);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isPresent ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Present',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _toggleAttendance(studentId, false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: !isPresent ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
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
          : Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
            child: Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitAttendance,
        label: Text('Submit Attendance'),
        icon: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _toggleAttendance(String studentId, bool present) {
    setState(() {
      _attendance[studentId] = present;
    });
  }

  Future<void> _submitAttendance() async {
    try {
      // Example: Upload attendance data to a collection named 'attendance'
      CollectionReference attendanceRef =
      FirebaseFirestore.instance.collection('attendance');
      _attendance.forEach((studentId, present) async {
        await attendanceRef.doc(studentId).set({
          'date': DateTime.now(),
          'present': present,
          // You can add more details like 'class', 'subject', etc.
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance submitted successfully'),
        ),
      );
    } catch (e) {
      print('Error submitting attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit attendance. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}