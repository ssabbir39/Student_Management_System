import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/profile_image_picker.dart';
import '../../../Repository_and_Authentication/services/auth.dart';
import '../../../animated_route_page.dart';
import '../../../constants.dart';
import '../../Faculty_Section/Faculty_home_screen/widgets/admin_data.dart';
import '../../Faculty_Section/Faculty_login_screen.dart';
import '../../Rating/teacher_rating.dart';
import '../Total_users/tota_users.dart';
import '../add_faculty/add_faculty.dart';
import '../add_student/add_student.dart';
import '../report/student_list.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  static String routeName = 'AdminPage';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _isLoggedOut = false;

  @override
  void initState() {
    super.initState();
  }

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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileImagePicker(
                    onPress: () {},
                  ),
                ],
              ),
            ),
            Expanded(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => FacultyListPage()));
                            },
                            icon: 'assets/icons/quiz.svg',
                            title: 'Faculty Report',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => StudentListPage()));

                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Student Report',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => AddFaculty()));
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Add Faculty',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => AddStudent()));

                            },
                            icon: 'assets/icons/assignment.svg',
                            title: 'Add Student',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => UserListPage()));

                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Total\nreport',
                          ),
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/ask.svg',
                            title: 'Prediction',
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
                                  builder: (context) =>  const AdminLoginScreen(),
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
