import 'package:flutter/material.dart';
import 'package:student_management_system/Announchment/data/announcements.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/StudentClasses_tab.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/wall_tab.dart';
import 'package:student_management_system/Announchment/widgets/attachment_composer.dart';
import 'package:student_management_system/Announchment/widgets/submit_composer.dart';

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>   StudentClassesTab(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        backgroundColor: widget.announcement.classroom.uiColor,
        elevation: 0.5,
        title: const Text(
          "Join Class",
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 15, bottom: 10),
            child: Text(
              widget.announcement.title,
              style: TextStyle(
                fontSize: 25,
                color: widget.announcement.classroom.uiColor,
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
            color: widget.announcement.classroom.uiColor,
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
                          style: TextStyle(fontSize: 25,color: Colors.blue),
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
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          if (widget.announcement.attachments.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text(
                "Attachments:",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
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
