//static String routeName = 'Wrapper';

import 'package:flutter/cupertino.dart';
import 'package:student_management_system/screens/Faculty_login_screen/Faculty_login_screen.dart';
import 'package:student_management_system/screens/admin_Screen/add_faculty/add_faculty.dart';
import 'package:student_management_system/screens/admin_Screen/add_student/add_student.dart';
import 'package:student_management_system/screens/splash_screen/splash_screen.dart';
import 'package:student_management_system/screens/student_login_screen/fee_screen/fee_screen.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/Credit_screen/credit_screen.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/Exam_Screen/exam_routine.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/Result_Screen/result.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/home_screen.dart';
import 'package:student_management_system/screens/student_login_screen/login_screen.dart';
import 'package:student_management_system/screens/student_login_screen/my_profile/my_profile.dart';

import 'Announchment/screens/wrapper.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) =>  SplashScreen(),
  LoginScreen.routeName : (context) =>  LoginScreen(),
  StudentHomeScreen.routeName : (context) =>  StudentHomeScreen(),
  MyProfileScreen.routeName : (context) =>  MyProfileScreen(),
  FeeScreen.routeName : (context) =>  FeeScreen(),
  AdminLoginScreen.routeName : (context) =>  AdminLoginScreen(),
  CreditScreen.routeName : (context) =>  CreditScreen(),
  AddStudent.routeName : (context) =>  AddStudent(),
  AddFaculty.routeName : (context) =>  AddFaculty(),
  ExamScreen.routeName : (context) =>  ExamScreen(),
  ResultScreen.routeName : (context) =>  ResultScreen(),
  Wrapper.routeName : (context) =>  Wrapper(),

};