import 'package:flutter/material.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/student_work_page.dart';

import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/widgets/profile_tile.dart';


class PeopleTab extends StatefulWidget {
  ClassRooms classRoom;
  Color uiColor;

  PeopleTab({super.key, required this.classRoom, required this.uiColor});

  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
          child: Text(
            "Students",
            style: TextStyle(
                fontSize: 30, color: widget.uiColor, letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: widget.uiColor,
        ),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.classRoom.students.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StudentWorkPage(
                              student:  widget.classRoom.students[index],
                              classRoom: widget.classRoom
                          ))),
                      child: Profile(
                          user: widget.classRoom.students[index]
                      ));
                })
        )
      ],
    );
  }
}
