import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<DocumentSnapshot>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = getUsers();
  }

  Future<List<DocumentSnapshot>> getUsers() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("users").get();
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
        title: const Text("User List",style: TextStyle(color: kTextWhiteColor),),
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
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot>? users = snapshot.data;
              return ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> userData =
                  users[index].data() as Map<String, dynamic>;
                  String fullName = userData['fullName'] ?? '';
                  String email = userData['email'] ?? '';
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
                },
              );
            }
          },
        ),
      ),
    );
  }
}
