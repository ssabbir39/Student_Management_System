import 'package:flutter/material.dart';
import 'package:student_management_system/Announchment/data/announcements.dart';
import 'package:student_management_system/constants.dart';

import '../../../screens/student_login_screen/home_screen/home_screen.dart';
import '../teacher_classroom/TeacherAnnouncement_page.dart';

class WallTab extends StatefulWidget {
  const WallTab({Key? key});

  @override
  _WallTabState createState() => _WallTabState();
}

class _WallTabState extends State<WallTab> {
  @override
  Widget build(BuildContext context) {
    if (notificationList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentHomeScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios, color: kTextWhiteColor),
          ),
        ),
        backgroundColor: Colors.blueAccent, // Set background color to blue
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding),
              topRight: Radius.circular(kDefaultPadding),
            ),
            color: kOtherColor,
          ),
          child: Center(
            child: Text(
              "No notifications",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "Roboto",
                fontSize: 22,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",style: TextStyle(color: kTextWhiteColor),),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentHomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: kTextWhiteColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/Dp/cat1.jpg"),
                ),
                title: Text(
                  notificationList[index].title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: kPrimaryColor),
                ),
                subtitle: Text(
                  notificationList[index].dateTime,
                  style: TextStyle(color: Colors.grey,fontSize: 15),
                ),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
