import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Announchment/screens/loading.dart';
import '../../Repository_and_Authentication/custom_buttons.dart';
import '../../Repository_and_Authentication/services/auth.dart';
import '../../Repository_and_Authentication/services/updatealldata.dart';
import '../../animated_route_page.dart';
import '../../constants.dart';
import '../Attendance_Screen/pages/forgetpass.dart';
import '../Faculty_Section/Faculty_login_screen.dart';
import 'home_screen/home_screen.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  const LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String emailController = '';
  String passwordController = '';
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  void _signIn() async {
    try {
        if (_formKey.currentState!.validate()) {
          setState(() => loading = true);

          // Logging into the account
          var result = await _auth.loginStudent(emailController, passwordController);
          if (result == null) {
            setState(() {
              loading = false;
              error = 'Some error in logging in! Please check again';
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        error,
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
              ),);
          }
          else {
            route();
          }
        }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Sign-In failed",
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
      ),);
      print("Sign-In failed: $e");
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
        if (documentSnapshot.get('type') == "student") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Welcome Dear Student",
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
            Navigator.of(context).push(UniquePageRoute(builder: (_) => StudentHomeScreen()));
        } else {
          setState(() {
            loading = false;
            error = 'Please check again';
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    error,
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
          ),);
          print('Document does not exist on the database');
        }
      }
    }
    );
  }
  //
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                    Text('Hi, ',
                        style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w200,
                                )),
                    Text('Student',
                        style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 6),
                Text(
                  'Login to continue',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
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
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Forget password?',
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
                            Navigator.of(context).push(UniquePageRoute(builder: (_) => AdminLoginScreen()));
                          },
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Faculty Login?",
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
        labelText: 'Student Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
      ),
      validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
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
      validator: (val) => val!.isEmpty ? 'Enter Password' : null,
      onChanged: (val) {
        setState(() {
          passwordController = val;
        });
      },
    );
  }

}
