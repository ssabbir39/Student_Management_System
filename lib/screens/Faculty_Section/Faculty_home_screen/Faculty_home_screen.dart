import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/add_class.dart';
import '../../../Announchment/screens/asignedCourses.dart';
import '../../../Announchment/screens/teacher_classroom/TeacherClasses.dart';
import '../../../Announchment/screens/teacher_classroom/announcement_crud/edit_announcement.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/profile_image_picker.dart';
import '../../../Repository_and_Authentication/services/auth.dart';
import '../../../animated_route_page.dart';
import '../../../constants.dart';
import '../../Attendance_Screen/select_courses.dart';
import '../../Attendance_Screen/Attendance_page.dart';
import 'Faculty_Profile.dart';
import '../Faculty_login_screen.dart';
import 'widgets/admin_data.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({Key? key}) : super(key: key);

  @override
  _FacultyHomeScreenState createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  bool _isLoggedOut = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return WillPopScope(
      onWillPop: () async {
        if (!_isLoggedOut) {
          // If user is not logged out, log them out and prevent default back button behavior
          setState(() {
            _isLoggedOut = true;
          });
          // Add a delay to mimic a loading screen
          //await Future.delayed(Duration(seconds: 1));
          AuthService().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AdminLoginScreen(),
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
            _buildProfileSection(user),
            _buildExpandedSection(account),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileSection(CustomUser user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImagePicker(
            onPress: () {
              Navigator.of(context).push(UniquePageRoute(builder: (_) => FacultyProfileScreen(user: user)),);
            },
          ),
          kHalfSizeBox,
          FacultyName(),
          kHalfSizeBox,
          FacultyDepartment(),
          kHalfSizeBox,
          FacultyPost(),
          kHalfSizeBox,
          FacultyYear(),
        ],
      ),
    );
  }

  Widget _buildExpandedSection(var account) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kOtherColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding * 3),
              topRight: Radius.circular(kDefaultPadding * 3),
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => AttendanceReport()));
                  },
                  icon: 'assets/icons/quiz.svg',
                  title: 'Attendance\nReport',
                ),
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => AddClass()));
                  },
                  icon: 'assets/icons/assignment.svg',
                  title: 'Create Semester\nCourses',
                ),
              ),
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) =>  AttendancePage()));
                  },
                  icon: 'assets/icons/holiday.svg',
                  title: 'Attendance',
                ),
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => TeacherClassesTab(account: account)));
                  },
                  icon: 'assets/icons/datasheet.svg',
                  title: 'Make an\nAnnouncement',
                ),
              ),
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => AssignedCoursesPage()));
                  },
                  icon: 'assets/icons/resume.svg',
                  title: 'Assigned\nCourses',
                ),
                  HomeCard(
                    onPress: () {
                      AuthService().logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const AdminLoginScreen(),
                        ),
                      );
                    },
                    icon: 'assets/icons/logout.svg',
                    title: 'Logout',
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Widget leftCard, Widget rightCard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        leftCard,
        rightCard,
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding / 2),
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
