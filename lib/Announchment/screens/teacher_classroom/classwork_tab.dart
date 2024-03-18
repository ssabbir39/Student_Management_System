import 'package:flutter/material.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/TeacherAnnouncement_page.dart';
import '../../../Repository_and_Authentication/data/announcements.dart';

class ClassWorkTab extends StatefulWidget {
  final String className;
  const ClassWorkTab({super.key, required this.className,});

  @override
  _ClassWorkTabState createState() => _ClassWorkTabState();
}

class _ClassWorkTabState extends State<ClassWorkTab> {
  @override
  Widget build(BuildContext context) {
    List _classWorkList = announcementList.where((i) => i.type == "Assignment" && i.classroom.className == widget.className).toList();

    return ListView.builder(
        itemCount: _classWorkList.length,
        itemBuilder: (context, int index) {
          return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TeacherAnnouncementPage(
                announcement: _classWorkList[index]
              ))),
            child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _classWorkList[index].classroom.uiColor),
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
                            _classWorkList[index].title,
                            style: TextStyle(letterSpacing: 1),
                          ),
                          Text(
                            "Due " + _classWorkList[index].dueDate,
                            style: TextStyle(color: Colors.grey),
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
