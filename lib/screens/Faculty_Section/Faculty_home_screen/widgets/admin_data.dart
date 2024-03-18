import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Repository_and_Authentication/data/accounts.dart';
import '../../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../../Repository_and_Authentication/services/auth.dart';
import '../../../../constants.dart';

//name
class FacultyName extends StatefulWidget {
  const FacultyName({super.key});

  @override
  State<FacultyName> createState() => _FacultyNameState();
}

class _FacultyNameState extends State<FacultyName> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Text(
      '${account?.fullName}',
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,fontSize: 20,
          ),
    );
  }
}


//department
class FacultyDepartment extends StatefulWidget {
  const FacultyDepartment({super.key});

  @override
  State<FacultyDepartment> createState() => _FacultyDepartmentState();
}

class _FacultyDepartmentState extends State<FacultyDepartment> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Text(
      'Department: ${account?.dept}',
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontSize: 14.0,
          ),
    );
  }
}

//year
class FacultyYear extends StatefulWidget {
  const FacultyYear({super.key});

  @override
  State<FacultyYear> createState() => _FacultyYearState();
}

class _FacultyYearState extends State<FacultyYear> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      width: 150,
      height: 20,
      decoration: BoxDecoration(
        color: kOtherColor,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Center(
        child: Text(
          'Joined: ${account?.join}',
          style: TextStyle(
            fontSize: 12.0,
            color: kTextBlackColor,
          ),
        ),
      ),
    );
  }
}

//post
class FacultyPost extends StatefulWidget {
  const FacultyPost({super.key});

  @override
  State<FacultyPost> createState() => _FacultyPostState();
}

class _FacultyPostState extends State<FacultyPost> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
        color: kOtherColor,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Center(
        child: Text(
          '${account?.post}',
          style: const TextStyle(
            fontSize: 12.0,
            color: kTextBlackColor,
          ),
        ),
      ),
    );
  }
}

//data card
class FacultyDataCard extends StatelessWidget {
  const FacultyDataCard(
      {super.key,
      required this.title,
      required this.value,
      required this.onPress});

  final String title;
  final String value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
          color: kOtherColor,
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16.0,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 25.0,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class Degree extends StatefulWidget {
  const Degree({super.key});

  @override
  State<Degree> createState() => _DegreeState();
}

class _DegreeState extends State<Degree> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
        top: kDefaultPadding / 2,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Highest Degree",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              Text(
                '${account?.degree}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 20.0),
        ],
      ),
    );
  }
}

//ID
class FacultyId extends StatefulWidget {
  const FacultyId({super.key});

  @override
  State<FacultyId> createState() => _FacultyIdState();
}

class _FacultyIdState extends State<FacultyId> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
        top: kDefaultPadding / 2,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Id Number",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              Text(
                '${account?.id}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 20.0),
        ],
      ),
    );
  }
}

//Department
class Department extends StatefulWidget {
  const Department({super.key});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
        top: kDefaultPadding / 2,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Department",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              Text(
                '${account?.dept}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 20.0),
        ],
      ),
    );
  }
}

//Date of Joined
class DateOfJoined extends StatefulWidget {
  const DateOfJoined({super.key});

  @override
  State<DateOfJoined> createState() => _DateOfJoinedState();
}

class _DateOfJoinedState extends State<DateOfJoined> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
        top: kDefaultPadding / 2,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Date of Joined",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              Text(
                '${account?.join}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 20.0),
        ],
      ),
    );
  }
}

//Post
class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
        top: kDefaultPadding / 2,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Post",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              Text(
                '${account?.post}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 20.0),
        ],
      ),
    );
  }
}
