import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';
import '../../data/classrooms.dart';
import '../student_classroom/people_tab.dart';
import '../teacher_classroom/classwork_tab.dart';
import '../teacher_classroom/stream_tab.dart';
import 'announcement_crud/add_announcement.dart';

class TeacherClassRoomPage extends StatefulWidget {
  final ClassRooms classRoom;
  final Color uiColor;

  const TeacherClassRoomPage({
    Key? key,
    required this.classRoom,
    required this.uiColor,
  }) : super(key: key);

  @override
  _TeacherClassRoomPageState createState() => _TeacherClassRoomPageState();
}

class _TeacherClassRoomPageState extends State<TeacherClassRoomPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      StreamTab(
        className: widget.classRoom.className,
        uiColor: widget.uiColor,
      ),
      ClassWorkTab(className: widget.classRoom.className),
      PeopleTab(
        classRoom: widget.classRoom,
        uiColor: widget.uiColor,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: kTextWhiteColor,
        ),
        backgroundColor: widget.uiColor,
        elevation: 0.5,
        title: Text(
          widget.classRoom.className,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontSize: 22,
          ),
        ),
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Stream",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Classwork',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: widget.uiColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddAnnouncement(classRoom: widget.classRoom),
            ),
          ).then((_) => setState(() {}));
        },
        backgroundColor: widget.uiColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
