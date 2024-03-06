import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/screens/Attendance_Page/select_courses.dart';

class SelectDepartmentBatchCoursesPage extends StatefulWidget {
  @override
  _SelectDepartmentBatchCoursesPageState createState() =>
      _SelectDepartmentBatchCoursesPageState();
}

class _SelectDepartmentBatchCoursesPageState
    extends State<SelectDepartmentBatchCoursesPage> {
  String? selectedDepartment;
  List<String> departmentList = []; // List to store department names

  @override
  void initState() {
    super.initState();
    fetchDepartments(); // Fetch departments when the page initializes
  }

  Future<void> fetchDepartments() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('department').get();

      List<String> departments = [];

      querySnapshot.docs.forEach((doc) {
        String department = doc['department'];
        if (!departments.contains(department)) {
          departments.add(department);
        }
      });

      setState(() {
        departmentList = departments;
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Department, Batch, and Courses'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown for selecting department
            DropdownButton<String>(
              value: selectedDepartment,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDepartment = newValue;
                });

                // Navigate to the select courses page with the selected department
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCoursesPage(),
                  ),
                );
              },
              items: departmentList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Add dropdown for selecting batch if needed
          ],
        ),
      ),
    );
  }
}
