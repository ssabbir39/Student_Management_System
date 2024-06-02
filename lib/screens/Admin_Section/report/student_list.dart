import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';

import '../Home_Page/admin_HomeScreen.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<DocumentSnapshot>> studentsFuture;
  String totalStudent = '0';

  @override
  void initState() {
    super.initState();
    studentsFuture = getUsers('student');
  }

  Future<List<DocumentSnapshot>> getUsers(String userType) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where('type', isEqualTo: userType)
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text("Student Report",style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: studentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot>? students = snapshot.data;
              totalStudent = students!.length.toString();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          alignment: Alignment.topRight,
                          width: 50,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: kPrimaryColor,
                          ),
                          child: Center(child: Text(totalStudent,style: TextStyle(fontSize: 16,color: kTextWhiteColor),))),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userData =
                        students[index].data() as Map<String, dynamic>;
                        String fullName = userData['fullName'] ?? '';
                        String email = userData['email'] ?? '';
                        return _buildUserTile(fullName, email);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserTile(String fullName, String email) {
    return Card(
      color: kPrimaryColor,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ListTile(
        title: Text(
          fullName,
          style: TextStyle(
            fontSize: 24,
            color: kTextWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          email,
          style: TextStyle(
            fontSize: 16,
            color: kTextWhiteColor,
          ),
        ),
      ),
    );
  }
}
