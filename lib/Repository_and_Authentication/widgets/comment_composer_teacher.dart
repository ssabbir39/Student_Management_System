import 'package:flutter/material.dart';
import '../../Announchment/screens/student_classroom/StudentAnnouncement_page.dart';
import '../data/announcements.dart';

class CommentComposer extends StatefulWidget {
  String className;

  CommentComposer(this.className, {super.key});

  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {
  @override
  Widget build(BuildContext context) {
    List _announcementList = announcementList.where((i) => i.classroom.className == widget.className).toList();

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: _announcementList.length,
            itemBuilder: (context, int index) {
              return InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentAnnouncementPage(
                            announcement:  _announcementList[index]
                        ),
                      )).then((_) => setState(() {})),

                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 0.05)
                          ]),
                      child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                        backgroundImage:
                                        AssetImage("${_announcementList[index].user.userDp}"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _announcementList[index].user.firstName + " " + _announcementList[index].user.lastName,
                                              style: TextStyle(),
                                            ),
                                            Text(
                                              _announcementList[index].dateTime,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ]),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 40,
                                  margin:
                                  EdgeInsets.only(left: 15, top: 5, bottom: 10),
                                  child: Text(_announcementList[index].title)
                              )
                            ],
                          )
                      )
                  )
              );
            })
    );
  }
}
