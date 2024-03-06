import 'package:flutter/material.dart';

import '../data/announcements.dart';
import '../screens/student_classroom/StudentAnnouncement_page.dart';

class CommentComposer extends StatefulWidget {
  final String className;

  CommentComposer(this.className, {Key? key}) : super(key: key);

  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {
  @override
  Widget build(BuildContext context) {
    List _announcementList = announcementList
        .where((i) => i.classroom.className == widget.className)
        .toList();

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _announcementList.length,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => StudentAnnouncementPage(
                  announcement: _announcementList[index],
                ))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 0.05),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        CircleAvatar(
                          // Assuming userDp is a property of Announcement's user
                          backgroundImage: AssetImage(
                              "assets/Dp/cat2.jpg"), // Use userDp if available
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _announcementList[index].user.fullName, // Access fullName directly
                              style: TextStyle(color: Colors.blueAccent,fontSize: 22),
                            ),
                            Text(
                              _announcementList[index].dateTime.toString(), // Access dateTime directly
                              style: TextStyle(color: Colors.grey,fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      margin:
                      EdgeInsets.only(left: 15, top: 5, bottom: 10),
                      child: Text(_announcementList[index].title),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
