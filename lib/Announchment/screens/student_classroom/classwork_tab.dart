import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/announcements.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/StudentAnnouncement_page.dart';

import '../teacher_classroom/TeacherAnnouncement_page.dart';

class ClassWork extends StatefulWidget {
  final String className;

  const ClassWork(this.className, {super.key});

  @override
  _ClassWorkState createState() => _ClassWorkState();
}

class _ClassWorkState extends State<ClassWork> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    List _classWorkList = announcementList.where((i) => i.type == "Assignment" && i.classroom.className == widget.className).toList();

    return ListView.builder(
        itemCount: _classWorkList.length,
        itemBuilder: (context, int index) {
          return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => StudentAnnouncementPage(
                announcement: _classWorkList[index]
              ))),
            child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _classWorkList[index].classroom.uiColor),
                        child: Icon(
                          Icons.assignment,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _classWorkList[index].title,
                            style: TextStyle(letterSpacing: 1,fontSize: 24),
                          ),
                          Text(
                            "Due " + _classWorkList[index].dueDate,
                            style: TextStyle(color: Colors.grey,fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            )
          );
        }
    );
  }
}
