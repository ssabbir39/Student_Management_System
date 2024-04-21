import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';
import '../../../Repository_and_Authentication/data/announcements.dart';
import 'StudentAnnouncement_page.dart';

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
              Navigator.pop(context);
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
        title: Text("Notifications", style: TextStyle(color: kTextWhiteColor)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                title: Flexible(
                  child: Text(
                    '${notificationList[index].title}\n${notificationList[index].description}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                subtitle: Text(
                  notificationList[index].dateTime,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                onTap: () {
                  // Navigate to announcement details screen/widget
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentAnnouncementPage(
                        announcement: notificationList[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
