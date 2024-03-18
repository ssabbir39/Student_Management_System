import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/announcements.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/services/classes_db.dart';
import '../../../Repository_and_Authentication/services/submissions_db.dart';
import '../../../Repository_and_Authentication/services/updatealldata.dart';
import '../../../animated_route_page.dart';
import '../../../screens/Student_Section/home_screen/home_screen.dart';
import '../loading.dart';

class JoinClass extends StatefulWidget {
  const JoinClass({Key? key}) : super(key: key);

  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  String className = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return loading
        ? Loading()
        : Scaffold(
      // appbar part
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
        elevation: 0.5,
        title: const Text(
          "Join Class",
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
      ),

      // body part
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 50.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Class Code",
                      labelStyle:
                      TextStyle(color: kTextWhiteColor, fontSize: 16),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: kPrimaryColor,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintText: "Enter class Code",
                      hintStyle:
                      TextStyle(color: kTextWhiteColor, fontSize: 20),
                    ),
                    validator: (val) =>
                    val!.isEmpty ? 'Enter a class Code' : null,
                    onChanged: (val) {
                      setState(() {
                        className = val;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ClassesDB(user: user)
                            .updateStudentClasses(className);
                        await joinCourse(className, user!);

                        for (int i = 0;
                        i < announcementList.length;
                        i++) {
                          if (announcementList[i].classroom.className ==
                              className &&
                              announcementList[i].type ==
                                  "Assignment") {
                            await SubmissionDB().addSubmissions(
                                user.uid,
                                className,
                                announcementList[i].title);
                          }
                        }

                        setState(() => loading = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.notifications_active_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Successfully Added",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(
                                seconds: 5), // Adjust the duration as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 6,
                            margin: EdgeInsets.all(20),
                          ),
                        );
                        await updateAllData();
                        loading = false;
                        Navigator.of(context).push(UniquePageRoute(
                            builder: (_) => StudentHomeScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text("Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 22,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> joinCourse(String className, CustomUser user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        var account = getAccount(user.uid); // Fetching user account
        await FirebaseFirestore.instance
            .collection('courses')
            .doc(className)
            .collection('students')
            .doc(currentUser.uid)
            .set({
          'uid': currentUser.uid,
          'fullName': account?.fullName ?? '', // Use fullName from account
          'email': user.email ?? '',
          'id': account?.id ?? '',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined $className'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (error) {
        print('Error joining course: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
            Text('Failed to join $className. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
