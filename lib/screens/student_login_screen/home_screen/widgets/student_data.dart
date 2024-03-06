import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Announchment/data/accounts.dart';
import '../../../../Announchment/data/custom_user.dart';
import '../../../../Announchment/services/auth.dart';
import '../../../../constants.dart';

//name
class StudentName extends StatefulWidget {
  const StudentName({super.key});

  @override
  State<StudentName> createState() => _StudentNameState();
}

class _StudentNameState extends State<StudentName> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Row(
      children: [
        Text(
          '${account?.fullName}',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

//class

class StudentClass extends StatefulWidget {
  const StudentClass({super.key});

  @override
  State<StudentClass> createState() => _StudentClassState();
}

class _StudentClassState extends State<StudentClass> {
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
      'ID: ${account?.id}',
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontSize: 14.0,
          ),
    );
  }
}

//year

class StudentYear extends StatelessWidget {
  const StudentYear({super.key});

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
          "${account?.join}",
          style: TextStyle(
            fontSize: 12.0,
            color: kTextBlackColor,
          ),
        ),
      ),
    );
  }
}

class StudentDataCard extends StatelessWidget {
  const StudentDataCard({super.key, required this.title, required this.onPress});
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          color: kOtherColor,
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontSize: 16.0,
                color: kTextBlackColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

