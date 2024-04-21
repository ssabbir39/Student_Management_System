import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Announchment/screens/student_classroom/add_class.dart';
import '../../../Announchment/screens/student_classroom/StudentClasses_tab.dart';
import '../../../Announchment/screens/student_classroom/registredCourses.dart';
import '../../../Announchment/screens/student_classroom/wall_tab.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/profile_image_picker.dart';
import '../../../Repository_and_Authentication/services/auth.dart';
import '../../../animated_route_page.dart';
import '../../../constants.dart';
import '../../Rating/teacher_rating.dart';
import '../fee_screen/fee_screen.dart';
import '../login_screen.dart';
import '../my_profile/my_profile.dart';
import 'Credit_screen/credit_screen.dart';
import 'Exam_Screen/exam_routine.dart';
import 'attendance_report/my_attendance.dart';
import 'attendance_report/student_attendance_report.dart';
import 'widgets/student_data.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});
  static String routeName = 'HomeScreen';

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  bool _isLoggedOut = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    return WillPopScope(
      onWillPop: () async {
        if (!_isLoggedOut) {
          // If user is not logged out, log them out and prevent default back button behavior
          setState(() {
            _isLoggedOut = true;
          });
          AuthService().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
          return false; // Prevent default back button behavior
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileImagePicker(
                    onPress: () {
                      Navigator.of(context).push(UniquePageRoute(builder: (_) => MyProfileScreen()));
                    },
                  ),
                  kHalfSizeBox,
                  StudentName(),
                  kHalfSizeBox,
                  StudentClass(),
                  kHalfSizeBox,
                  StudentYear(),
                  sizeBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StudentDataCard(
                        title: 'Attendance',
                        onPress: () {
                          // Go to Attendance Screen
                          Navigator.of(context).push(UniquePageRoute(
                            builder: (_) => StudentAttendanceReport(),
                          ));
                        },
                      ),
                      StudentDataCard(
                        title: 'Fees Due',
                        onPress: () {
                          // Go to fees screen
                          Navigator.of(context).push(UniquePageRoute(builder: (_) => FeeScreen()));
                        },
                      ),
                      StudentDataCard(
                        title: 'Credit',
                        onPress: () {
                          // Go to fees screen
                          Navigator.of(context).push(UniquePageRoute(builder: (_) => CreditScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kOtherColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding * 3),
                      topRight: Radius.circular(kDefaultPadding * 3),
                    ),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => WallTab()));
                            },
                            icon: 'assets/icons/quiz.svg',
                            title: 'Notice',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => JoinClass()));
                            },
                            icon: 'assets/icons/assignment.svg',
                            title: 'Join Courses',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => RegisteredCourses()));
                            },
                            icon: 'assets/icons/result.svg',
                            title: 'Registered\nCourses',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => StudentClassesTab()));
                            },
                            icon: 'assets/icons/timetable.svg',
                            title: 'Courses Work',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => ExamScreen()));
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Exam\nNotice',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => FacultyListPage()));
                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Faculty\nRecommendation',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              AuthService().logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            icon: 'assets/icons/logout.svg',
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
  });

  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 40.0,
              width: 40.0,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: kDefaultPadding / 3),
          ],
        ),
      ),
    );
  }
}
