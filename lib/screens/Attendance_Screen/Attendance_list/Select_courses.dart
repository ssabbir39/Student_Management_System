import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Announchment/data/accounts.dart';
import '../../../Announchment/services/accounts_db.dart';

class FacultyCoursesPage extends StatefulWidget {
  final String userId;

  const FacultyCoursesPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FacultyCoursesPageState createState() => _FacultyCoursesPageState();
}

class _FacultyCoursesPageState extends State<FacultyCoursesPage> {
  AccountsDB _accountsDB = AccountsDB();
  List<DocumentSnapshot>? _facultyCourses;

  @override
  void initState() {
    super.initState();
    _fetchFacultyCourses();
  }

  Future<void> _fetchFacultyCourses() async {
    List<DocumentSnapshot>? courses =
    await _accountsDB.getFacultyCourses(widget.userId);
    setState(() {
      _facultyCourses = courses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Courses'),
      ),
      body: _facultyCourses != null
          ? ListView.builder(
        itemCount: _facultyCourses!.length,
        itemBuilder: (context, index) {
          final course = _facultyCourses![index];
          return ListTile(
            title: Text(course['courseName']),
            subtitle: Text('Course ID: ${course.id}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseStudentsPage(courseId: course.id),
                ),
              );
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CourseStudentsPage extends StatefulWidget {
  final String courseId;

  const CourseStudentsPage({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseStudentsPageState createState() => _CourseStudentsPageState();
}

class _CourseStudentsPageState extends State<CourseStudentsPage> {
  AccountsDB _accountsDB = AccountsDB();
  List<DocumentSnapshot>? _students;

  @override
  void initState() {
    super.initState();
    _fetchCourseStudents();
  }

  Future<void> _fetchCourseStudents() async {
    List<DocumentSnapshot>? students =
    await _accountsDB.getCourseStudents(widget.courseId);
    setState(() {
      _students = students;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Students'),
      ),
      body: _students != null
          ? ListView.builder(
        itemCount: _students!.length,
        itemBuilder: (context, index) {
          final student = _students![index];
          return ListTile(
            title: Text(student['fullName']),
            subtitle: Text('ID: ${student.id}'),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
