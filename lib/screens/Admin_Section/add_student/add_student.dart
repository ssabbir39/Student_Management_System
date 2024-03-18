import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../Announchment/screens/loading.dart';
import '../../../Repository_and_Authentication/custom_buttons.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/services/accounts_db.dart';
import '../../../Repository_and_Authentication/services/auth.dart';
import '../../../Repository_and_Authentication/services/updatealldata.dart';
import '../Home_Page/admin_HomeScreen.dart';

class AddStudent extends StatefulWidget {
  static const String routeName = 'AddStudent';

  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  late CustomUser? user;
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';
  String username = '';
  String id = '';
  String fatherName = '';
  String motherName = '';
  String phoneNumber = '';
  String registration = '';
  String dob = '';
  String department = '';
  String degree = 'H.S.C';
  String faculty = 'none';
  String joined = '';
  String semester = '';

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<CustomUser?>(context);
    return loading
        ? Loading()
        : GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AdminPage()),
            );
          },
          child: const Icon(Icons.arrow_back_ios,color: kTextWhiteColor,)),
        ),
        bottomNavigationBar: Container(
          color: kDefaultIconLightColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              onPress: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  // Registering new student
                  dynamic result = await _auth.registerStudent(email, password);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Some error in Registering! Please check again';
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
                    });
                  } else {
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
                              "Successfully Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: kPrimaryColor,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 5), // Adjust the duration as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                      margin: EdgeInsets.all(20),
                    ),);
                    // After successful registration, update data in Firestore
                    await updateStudentData();
                    setState(() => loading = false);
                    // Navigate to admin page after registration
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => AdminPage()));
                  }
                }
              },
              title: 'ADMISSION DONE',
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.0,
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
                      Text(
                        'Create, ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text('Account',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 6),
                  Text(
                    'For Student',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding * 3),
                  topRight: Radius.circular(kDefaultPadding * 3),
                ),
                color: kOtherColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: kDefaultPadding),
                      buildRegField(),
                      SizedBox(height: kDefaultPadding),
                      buildIdField(),
                      SizedBox(height: kDefaultPadding),
                      buildNameField(),
                      SizedBox(height: kDefaultPadding),
                      buildFatherNameField(),
                      SizedBox(height: kDefaultPadding),
                      buildMotherNameField(),
                      SizedBox(height: kDefaultPadding),
                      buildDobField(),
                      SizedBox(height: kDefaultPadding),
                      buildPhoneNumberField(),
                      SizedBox(height: kDefaultPadding),
                      buildDepartmentField(),
                      SizedBox(height: kDefaultPadding),
                      buildSemesterField(),
                      SizedBox(height: kDefaultPadding),
                      buildAdmissionDateField(),
                      SizedBox(height: kDefaultPadding),
                      buildEmailField(),
                      SizedBox(height: kDefaultPadding),
                      buildPasswordField(),
                      SizedBox(height: kDefaultPadding),
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

  TextFormField buildSemesterField() {
    return TextFormField(
      onChanged: (val) => semester = val,
      validator: (val) => val!.isEmpty ? 'Enter semester' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'semester',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  TextFormField buildRegField() {
    return TextFormField(
      onChanged: (val) => registration = val,
      validator: (val) => val!.isEmpty ? 'Enter a Registration' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Registration',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDepartmentField() {
    return TextFormField(
      onChanged: (val) => department = val,
      validator: (val) => val!.isEmpty ? 'Enter Department' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Department',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildIdField() {
    return TextFormField(
      onChanged: (val) => id = val,
      validator: (val) => val!.isEmpty ? 'Enter an ID' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Student ID',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      onChanged: (val) => username = val,
      validator: (val) => val!.isEmpty ? 'Enter a Name' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Full Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFatherNameField() {
    return TextFormField(
      onChanged: (val) => fatherName = val,
      validator: (val) => val!.isEmpty ? 'Enter Father\'s Name' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Father\'s Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildMotherNameField() {
    return TextFormField(
      onChanged: (val) => motherName = val,
      validator: (val) => val!.isEmpty ? 'Enter Mother\'s Name' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Mother\'s Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDobField() {
    return TextFormField(
      onChanged: (val) => dob = val,
      validator: (val) => val!.isEmpty ? 'Enter Date of Birth' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAdmissionDateField() {
    return TextFormField(
      onChanged: (val) => joined = val,
      validator: (val) => val!.isEmpty ? 'Enter Admission Date' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Admission Date',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      onChanged: (val) => phoneNumber = val,
      validator: (val) => val!.isEmpty ? 'Enter Phone Number' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (val) => email = val,
      validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (val) => password = val,
      obscureText: _passwordVisible,
      validator: (val) => val!.isEmpty ? 'Enter a Password' : null,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 17.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }

  Future<void> updateStudentData() async {
    final user = Provider.of<CustomUser?>(context, listen: false);
    final AccountsDB pointer = AccountsDB(user: user!);

    await pointer.updateAccounts(
      username,
      'student',
      registration,
      id,
      fatherName,
      motherName,
      dob,
      phoneNumber,
      password,
      faculty,
      degree,
      department,
      joined,
      semester,

    );

    await updateAllData();
  }
}
