import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/accounts.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/home_screen.dart';
import 'package:student_management_system/screens/student_login_screen/login_screen.dart';
import '../../screens/Faculty_login_screen/Faculty_home_screen/Faculty_home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key ? key}) : super(key: key);
  static String routeName = 'Wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {


    // getting user from the Stream Provider
    final user = Provider.of<CustomUser?>(context);

    // logic for if logged in
    if (user != null && accountExists(user.uid)) {
      var typeOfCurrentUser = getAccount(user.uid)!.type;
      return typeOfCurrentUser == 'student'? StudentHomeScreen() : FacultyHomeScreen();
    }


    // user isn't logged in
    else {
      return LoginScreen();
    }

  }
}
