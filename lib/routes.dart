//static String routeName = 'Wrapper';
import 'package:flutter/cupertino.dart';
import 'package:student_management_system/screens/Admin_Section/add_faculty/add_faculty.dart';
import 'package:student_management_system/screens/Admin_Section/add_student/add_student.dart';
import 'package:student_management_system/screens/Faculty_Section/Faculty_login_screen.dart';
import 'package:student_management_system/screens/Student_Section/fee_screen/fee_screen.dart';
import 'package:student_management_system/screens/Student_Section/home_screen/Credit_screen/credit_screen.dart';
import 'package:student_management_system/screens/Student_Section/home_screen/Exam_Screen/exam_routine.dart';
import 'package:student_management_system/screens/Student_Section/home_screen/Result_Screen/result.dart';
import 'package:student_management_system/screens/Student_Section/home_screen/home_screen.dart';
import 'package:student_management_system/screens/Student_Section/login_screen.dart';
import 'package:student_management_system/screens/Student_Section/my_profile/my_profile.dart';
import 'package:student_management_system/screens/splash_screen/splash_screen.dart';

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