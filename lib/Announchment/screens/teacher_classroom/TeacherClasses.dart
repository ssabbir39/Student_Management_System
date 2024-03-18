import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/class_room_page.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../constants.dart';

class TeacherClassesTab extends StatefulWidget {
  final Account? account; // Define account as a parameter

  const TeacherClassesTab({Key? key, required this.account}) : super(key: key);

  @override
  _TeacherClassesTabState createState() => _TeacherClassesTabState();
}

class _TeacherClassesTabState extends State<TeacherClassesTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = widget.account;
    List _classRoomList =
    classRoomList.where((i) => i.creator == account).toList(); // Use account directly

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Classes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: ListView.builder(
          itemCount: _classRoomList.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TeacherClassRoomPage(
                    uiColor: _classRoomList[index].uiColor,
                    classRoom: _classRoomList[index],
                  ))),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: _classRoomList[index].uiColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _classRoomList[index].className,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _classRoomList[index].description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Created by: ${_classRoomList[index].creator.fullName} (${_classRoomList[index].creator.email})',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
