import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';

import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/widgets/profile_tile.dart';

class PeopleTab extends StatefulWidget {
  ClassRooms classRoom;
  Color uiColor;

  PeopleTab({super.key, required this.classRoom, required this.uiColor});

  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
            child: Text(
              "Teachers",
              style: TextStyle(
                  fontSize: 20, color: kPrimaryColor, letterSpacing: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width - 30,
            height: 2,
            color: kPrimaryColor,
          ),
          Profile(
            user: widget.classRoom.creator,
          ),
          SizedBox(width: 30),
          Container(
            padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
            child: Text(
              "Classmates",
              style: TextStyle(
                  fontSize: 20, color: kPrimaryColor, letterSpacing: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width - 30,
            height: 2,
            color: widget.uiColor,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.classRoom.students.length,
                  itemBuilder: (context, int index) {
                    return Profile(
                      user: widget.classRoom.students[index]
                    );
                  }))
        ],
      ),
    );
  }
}
