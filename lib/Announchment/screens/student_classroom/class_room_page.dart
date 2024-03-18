import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/people_tab.dart';
import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../constants.dart';
import '../student_classroom/classwork_tab.dart';
import '../student_classroom/stream_tab.dart';

class ClassRoomPage extends StatefulWidget {
  ClassRooms classRoom;
  Color uiColor;

  ClassRoomPage({required this.classRoom, required this.uiColor});

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    String className = widget.classRoom.className;
    Color uiColor = widget.uiColor;

    final tabs = [
      StreamTab(
        className: className,
        uiColor: uiColor
      ),
      ClassWork(className),
      PeopleTab(
          classRoom: widget.classRoom,
          uiColor: uiColor
      )
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          className,
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
      ),
      backgroundColor: kTextWhiteColor,
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
        selectedItemColor: uiColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
