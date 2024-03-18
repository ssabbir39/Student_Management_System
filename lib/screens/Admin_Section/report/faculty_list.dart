import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';

import '../Home_Page/admin_HomeScreen.dart';

class FacultyListPage extends StatefulWidget {
  const FacultyListPage({Key? key}) : super(key: key);

  @override
  _FacultyListPageState createState() => _FacultyListPageState();
}

class _FacultyListPageState extends State<FacultyListPage> {
  late Future<List<DocumentSnapshot>> facultyFuture;

  @override
  void initState() {
    super.initState();
    facultyFuture = getUsers('faculty');
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
        title: const Text("Faculty List",style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade400],
          ),
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: facultyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot>? faculty = snapshot.data;
              return ListView.builder(
                itemCount: faculty!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> userData =
                  faculty[index].data() as Map<String, dynamic>;
                  String fullName = userData['fullName'] ?? '';
                  String email = userData['email'] ?? '';
                  return _buildUserTile(fullName, email);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserTile(String fullName, String email) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ListTile(
        title: Text(
          fullName,
          style: TextStyle(
            fontSize: 24,
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          email,
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue.shade900,
          ),
        ),
      ),
    );
  }
}