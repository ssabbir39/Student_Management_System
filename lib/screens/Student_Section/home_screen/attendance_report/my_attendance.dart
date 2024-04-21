import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';

class StudentAttendanceSummaryPage extends StatelessWidget {
  final String courseName;

  const StudentAttendanceSummaryPage({Key? key, required this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Summary',style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('courses')
              .doc(courseName)
              .collection('Attendance')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid) // Filter by logged-in student's ID
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Center(
                child: Text('No attendance data found for the student.',style: TextStyle(color: kTextBlackColor,fontSize: 16),),
              );
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                final studentName = data['name'] ?? '';
                final studentId = data['id'] ?? '';
                final presentCount = data['present'] ?? 0;
                final absentCount = data['absent'] ?? 0;
                final totalClasses = presentCount + absentCount;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      studentName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kTextWhiteColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('ID: $studentId', style: TextStyle(fontSize: 16,color: kTextWhiteColor)),
                        SizedBox(height: 4),
                        Text(
                          'Present: $presentCount | Absent: $absentCount \nTotal Classes: $totalClasses',
                          style: TextStyle(fontSize: 16,color: kTextWhiteColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
