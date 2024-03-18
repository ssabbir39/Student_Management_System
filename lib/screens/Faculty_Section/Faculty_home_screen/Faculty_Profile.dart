import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';
import '../../../Repository_and_Authentication/profile_image_picker.dart';
import '../../../constants.dart';

class FacultyProfileScreen extends StatefulWidget {
  final CustomUser? user;

  const FacultyProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends State<FacultyProfileScreen> {
  Map<String, dynamic> userData = {};
  double behaviourRating = 0.0;
  double skillRating = 0.0;
  double lectureRating = 0.0;
  double markingRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchRatings();
  }

  // Function to fetch user data from Firebase
  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users') // Update with your collection name
              .doc(widget.user?.uid) // Use the user's UID
              .get();
      setState(() {
        userData = snapshot.data() ?? {}; // Update userData with fetched data
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void fetchRatings() async {
    try {
      // Fetch the ratings for the specific faculty member
      DocumentSnapshot ratingSnapshot = await FirebaseFirestore.instance
          .collection('faculty_ratings')
          .doc(widget.user?.uid)
          .get();
      setState(() {
        // Update the state variables with the fetched ratings
        behaviourRating = ratingSnapshot['behaviourRating'] ?? 0.0;
        skillRating = ratingSnapshot['skillRating'] ?? 0.0;
        lectureRating = ratingSnapshot['lectureRating'] ?? 0.0;
        markingRating = ratingSnapshot['markingRating'] ?? 0.0;
      });
    } catch (error) {
      print('Failed to fetch ratings: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: kTextWhiteColor,
          ),
        ),
        title: const Text(
          'Faculty Profile',
          style: TextStyle(
            color: kTextWhiteColor,
          ),
        ),
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
      body: Container(
        color: kOtherColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(kDefaultPadding * 2),
                    bottomLeft: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: Column(
                  children: [
                    ProfileImagePicker(onPress: () {}),
                    kWidthSizeBox,
                    Text(
                      '${userData["fullName"] ?? ""}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text('ID: ${userData["id"] ?? ""}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                          fontSize: 14.0,
                        )),
                    sizeBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRatingColumn("Behaviour", behaviourRating),
                        _buildRatingColumn("Skills", skillRating),
                        _buildRatingColumn("Lecture", lectureRating),
                        _buildRatingColumn("Marking", markingRating),
                      ],
                    ),
                  ],
                ),
              ),
              sizeBox,
              //University Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                    title: 'POST: ',
                    value: '${userData["post"]}',
                  ),
                  ProfileDetailRow(
                    title: 'ID Number',
                    value: '${userData["id"]}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                    title: 'Date of Joined',
                    value: '${userData["join"]}',
                  ),
                  ProfileDetailRow(
                    title: 'Highest Degree',
                    value: '${userData["degree"]}',
                  ),
                ],
              ),
              //Parents Details
              ProfileDataColumn(
                title: 'Email',
                value: '${userData["email"]}',
              ),
              //Email and Phone Number
              ProfileDataColumn(
                title: 'Mobile Number',
                value: '${userData["phone"]}',
              ),
              ProfileDataColumn(
                title: 'Password',
                value: '${userData["pass"]}',
              ),
              ProfileDataColumn(
                title: 'Father Name',
                value: '${userData["fName"]}',
              ),
              ProfileDataColumn(
                title: 'Mother Name',
                value: '${userData["mName"]}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRatingColumn(String title, double rating) {
  Color color = _getColorFromRating(rating);
  return Column(
    children: [
      CircularPercentIndicator(
        radius: 30.0,
        lineWidth: 5.0,
        percent: rating,
        center: Text(
          "${(rating * 100).toInt()}%",
          style: TextStyle(fontSize: 14),
        ),
        progressColor: color,
        backgroundColor: Colors.grey,
      ),
      kHalfSizeBox,
      Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

Color _getColorFromRating(double rating) {
  if (rating >= 0.8) {
    return Colors.green;
  } else if (rating >= 0.6) {
    return Colors.yellow;
  } else if (rating >= 0.4) {
    return Colors.orange;
  } else {
    return Colors.red;
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
          const Icon(Icons.lock_outline, size: 20.0),
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
