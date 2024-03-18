import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/add_class.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/StudentClasses_tab.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/timeline_tab.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/wall_tab.dart';

import '../../Repository_and_Authentication/data/accounts.dart';
import '../../Repository_and_Authentication/data/custom_user.dart';
import '../../Repository_and_Authentication/services/auth.dart';


class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    final tabs = [
      WallTab(),
      TimelineTab(),
      StudentClassesTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "Online Classroom",
          style: TextStyle(
              color: Colors.black, fontFamily: "Roboto", fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'ClassWork',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Classes",
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => JoinClass(),
              )).then((_) => setState(() {}));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
