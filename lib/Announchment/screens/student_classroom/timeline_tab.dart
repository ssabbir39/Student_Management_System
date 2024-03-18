import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/announcements.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../teacher_classroom/TeacherAnnouncement_page.dart';

class TimelineTab extends StatefulWidget {
  const TimelineTab({super.key});

  @override
  _TimelineTabState createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    List classWorkList = announcementList.where((i) => i.type == "Assignment" && i.classroom.students.contains(account)).toList();

    return ListView.builder(
        itemCount: classWorkList.length,
        itemBuilder: (context, int index) {
          return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TeacherAnnouncementPage(
                  announcement:  classWorkList[index]
              ))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: classWorkList[index].classroom.uiColor),
                    child: Icon(
                      Icons.assignment,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classWorkList[index].title,
                        style: TextStyle(letterSpacing: 1),
                      ),
                      Text(
                        classWorkList[index].classroom.className,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Due " + classWorkList[index].dueDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
        });
  }
}