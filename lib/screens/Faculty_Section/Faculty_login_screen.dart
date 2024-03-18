import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Announchment/screens/loading.dart';
import '../../Repository_and_Authentication/custom_buttons.dart';
import '../../Repository_and_Authentication/services/auth.dart';
import '../../Repository_and_Authentication/services/updatealldata.dart';
import '../../animated_route_page.dart';
import '../../constants.dart';
import '../Admin_Section/Home_Page/admin_HomeScreen.dart';
import '../Attendance_Screen/pages/forgetpass.dart';
import '../Student_Section/login_screen.dart';
import 'Faculty_home_screen/Faculty_home_screen.dart';

late bool _passwordVisible;

class AdminLoginScreen extends StatefulWidget {
  static String routeName = 'AdminLoginScreen';

  const AdminLoginScreen({super.key,});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String emailController = '';
  String passwordController = '';

  bool loading = false;
  String error = '';

  void _signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() => loading = true);
        // Logging into the account
        var result = await _auth.loginStudent(emailController, passwordController);
        if (result == null) {
          setState(() {
            loading = false;
            error = 'Please check again';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Some error in logging in!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: kErrorBorderColor,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 5), // Adjust the duration as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 6,
              margin: EdgeInsets.all(20),
            ));
          });
        }
        else {
          route();
        }
      }
    } catch (e) {
      print("Sign-up failed: $e");
    }
  }

  void route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('type') == "faculty") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Login Successfully",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 5), // Adjust the duration as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6,
            margin: EdgeInsets.all(20),
          ));
          await updateAllData();
          Navigator.of(context).push(UniquePageRoute(builder: (_) => FacultyHomeScreen()));

        }
        else if (documentSnapshot.get('type') == "admin") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Logged in Successfully",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 5), // Adjust the duration as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6,
            margin: EdgeInsets.all(20),
          ));
          await updateAllData();
          Navigator.of(context).push(UniquePageRoute(builder: (_) => AdminPage()));

        }
        else {
          setState(() {
            loading = false;
            error = 'Please check again';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Some error in logging in!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: kErrorBorderColor,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 5), // Adjust the duration as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 6,
              margin: EdgeInsets.all(20),
            ));
          });
          return 'Document does not exist on the database';
        }
      } else {
        setState(() {
          loading = false;
          error = 'Please check again';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Some error in logging in!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: kErrorBorderColor,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 5), // Adjust the duration as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6,
            margin: EdgeInsets.all(20),
          ));
        });
        return 'Document does not exist on the database';
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello, ',
                          style:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w200,
                          )),
                      Text('Sir',
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 6),
                  Text(
                    'Please, Login to continue',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding * 3),
                  topRight: Radius.circular(kDefaultPadding * 3),
                ),
                color: kOtherColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          sizeBox,
                          buildEmailField(),
                          sizeBox,
                          buildPasswordField(),
                          sizeBox,
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => ResetPasswordPage()));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Forget password?",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                          sizeBox,
                          DefaultButton(
                            onPress: _signIn,
                            title: 'Login',
                          ),
                          sizeBox,
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => LoginScreen()));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Student Login?",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
        labelText: 'Faculty Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
      ),
      validator: (val) => val!.isEmpty ? 'Enter email' : null,
      onChanged: (val) {
        setState(() {
          emailController = val;
        });
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (val) => val!.isEmpty ? 'Enter password' : null,
      onChanged: (val) {
        setState(() {
          passwordController = val;
        });
      },
    );
  }
}
