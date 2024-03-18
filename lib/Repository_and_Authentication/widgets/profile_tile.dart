import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';

import '../data/accounts.dart';

class Profile extends StatelessWidget {
  Account user;

  Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 15),
          CircleAvatar(
            backgroundImage:
            //AssetImage("${user.userDp}"),
            AssetImage("assets/Dp/cat1.jpg"),
          ),
          SizedBox(
            width: 10,
          ),
          Text(user.fullName!,style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),)
        ],
      ),
    );
  }
}
