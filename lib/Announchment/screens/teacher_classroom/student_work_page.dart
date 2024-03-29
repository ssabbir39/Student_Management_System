import 'package:flutter/material.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/submission_page.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/data/submissions.dart';
import '../../../Repository_and_Authentication/widgets/profile_tile.dart';



class StudentWorkPage extends StatefulWidget {
  Account student;
  ClassRooms classRoom;

  StudentWorkPage({super.key, required this.student, required this.classRoom});

  @override
  _StudentWorkPageState createState() => _StudentWorkPageState();
}

class _StudentWorkPageState extends State<StudentWorkPage> {

  @override
  Widget build(BuildContext context) {
    List assignedWork = submissionList.where((i) => i.user.uid == widget.student.uid && i.classroom.className == widget.classRoom.className && !i.submitted).toList();
    List submittedWork = submissionList.where((i) => i.user.uid == widget.student.uid && i.classroom.className == widget.classRoom.className && i.submitted).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.classRoom.uiColor,
          elevation: 0.5,
          title: Text(
            "Student Classwork",
            style: TextStyle(
                color: Colors.white, fontFamily: "Roboto", fontSize: 22),
          ),
        ),
        body: ListView(
            children: [
              Profile(
                user: widget.student,
              ),
              if (submittedWork.length > 0) Container(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                child: Text(
                  "Submitted",
                  style: TextStyle(
                      fontSize: 20,
                      color: widget.classRoom.uiColor,
                      letterSpacing: 1),
                ),
              ),
              if (submittedWork.length > 0) Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                height: 2,
                color: widget.classRoom.uiColor,
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: submittedWork.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SubmissionPage(
                                    submission:  submittedWork[index]
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
                                          color: widget.classRoom.uiColor),
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
                                          submittedWork[index].assignment.title,
                                          style: TextStyle(letterSpacing: 1),
                                        ),
                                        Text(
                                          "Submitted on" + submittedWork[index].dateTime,
                                          style: TextStyle(color: Colors.grey),
                                        ),],)
                                  ],),
                              ),
                            ));
                      })
              ),
              if (assignedWork.length > 0) Container(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                child: Text(
                  "Pending",
                  style: TextStyle(
                      fontSize: 20,
                      color: widget.classRoom.uiColor,
                      letterSpacing: 1),
                ),
              ),
              if (assignedWork.length > 0) Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                height: 2,
                color: widget.classRoom.uiColor,
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: assignedWork.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: widget.classRoom.uiColor),
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
                                      assignedWork[index].assignment.title,
                                      style: TextStyle(letterSpacing: 1),
                                    ),
                                  ])
                              ],),
                          ),
                        );
                      })
              )
            ]
        )
    );
  }
}
