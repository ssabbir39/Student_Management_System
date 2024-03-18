import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';
import '../../../Repository_and_Authentication/data/announcements.dart';
import '../../../Repository_and_Authentication/widgets/attachment_composer.dart';
import '../../../Repository_and_Authentication/widgets/submit_composer.dart';

class StudentAnnouncementPage extends StatefulWidget {
  final Announcement announcement;

  const StudentAnnouncementPage({Key? key, required this.announcement}) : super(key: key);

  @override
  _StudentAnnouncementPageState createState() => _StudentAnnouncementPageState();
}

class _StudentAnnouncementPageState extends State<StudentAnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.5,
        title: const Text(
          "Assigned Work",
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
      ),
      backgroundColor: kTextWhiteColor,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding),
                topRight: Radius.circular(kDefaultPadding),
              ),
              color: kOtherColor,
            ),
            padding: EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              widget.announcement.title,
              style: TextStyle(
                fontSize: 25,
                color: kPrimaryColor,
                letterSpacing: 1,
              ),
            ),
          ),
          if (widget.announcement.type == 'Assignment')
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Due " + widget.announcement.dueDate,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width - 30,
            height: 2,
            color: kPrimaryColor,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/Dp/cat1.jpg"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.announcement.user.fullName ?? '',
                          style: TextStyle(fontSize: 25,color: kPrimaryColor),
                        ),
                        Text(
                          "Last updated " + widget.announcement.dateTime,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  widget.announcement.description,
                  style: TextStyle(fontSize: 20,color: kPrimaryColor),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          if (widget.announcement.attachments.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Attachments:",
                style: TextStyle(
                  fontSize: 15,
                  color: kPrimaryColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          AttachmentComposer(widget.announcement.attachments),
          if (widget.announcement.type == "Assignment")
            SubmissionComposer(widget.announcement, widget.announcement.classroom.uiColor),
        ],
      ),
    );
  }
}
