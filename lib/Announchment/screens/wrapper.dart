import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Repository_and_Authentication/data/accounts.dart';
import '../../Repository_and_Authentication/data/custom_user.dart';
import '../../screens/Faculty_Section/Faculty_home_screen/Faculty_home_screen.dart';
import '../../screens/Student_Section/home_screen/home_screen.dart';
import '../../screens/Student_Section/login_screen.dart';

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
