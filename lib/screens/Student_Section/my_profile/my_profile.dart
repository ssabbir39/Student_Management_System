import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/profile_image_picker.dart';
import '../../../Repository_and_Authentication/services/auth.dart';
import '../../../constants.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});
  static String routeName = 'MyProfileScreen';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final AuthService _auth = AuthService();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile',style: TextStyle(
          color: kTextWhiteColor,
        ),),
        actions: [
          InkWell(
            onTap: () {
              //send report to management
            },
            child: Container(
              padding: const EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  const Icon(Icons.report_gmailerrorred_outlined),
                  kHalfWidthSizeBox,
                  Text(
                    'Report',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kTextWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          color: kOtherColor,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(kDefaultPadding * 2),
                    bottomLeft: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImagePicker(onPress: (){}),
                    kWidthSizeBox,
                    Flexible(
                      child: Text('${account?.fullName}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Text('ID: ${account?.id}',
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontSize: 14.0,
                            ),
                    ),
                    kHalfSizeBox,
                  ],
                ),
              ),
              sizeBox,
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                    title: 'Registration Number',
                    value: '${account?.reg}',
                  ),
                  ProfileDetailRow(
                    title: 'ID Number',
                    value: '${account?.id}',
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                    title: 'Semester Running',
                    value: '${account?.semester}',
                  ),
                  ProfileDetailRow(
                    title: 'Joining Year',
                    value: '${account?.join}',
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                    title: 'Department',
                    value: '${account?.dept}',
                  ),
                  ProfileDetailRow(
                    title: 'Date of Birth',
                    value: '${account?.dob}',
                  ),
                ],
              ),
              sizeBox,
              //Parents Details
               ProfileDataColumn(
                title: 'Email',
                value: '${account?.email}',
              ),
               ProfileDataColumn(
                title: 'Father Name',
                value: '${account?.fName}',
              ),
               ProfileDataColumn(
                title: 'Mother Name',
                value: '${account?.mName}',
              ),

              //Email and Phone Number
               ProfileDataColumn(
                title: 'Mobile Number',
                value: '${account?.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
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
                title,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kTextLightColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                    ),
              ),
              kHalfSizeBox,
              Text(
                value,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
          const Icon(Icons.lock_outline, size: 16.0),
        ],
      ),
    );
  }
}

class ProfileDataColumn extends StatelessWidget {
  const ProfileDataColumn(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kTextLightColor,
                      fontSize: 15.0,
                    ),
              ),
              kHalfSizeBox,
              Text(
                value,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kTextBlackColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              kHalfSizeBox,
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
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
