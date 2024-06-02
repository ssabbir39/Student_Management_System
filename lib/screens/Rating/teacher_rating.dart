import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../constants.dart';
import 'rating_page.dart';

class FacultyListPage extends StatefulWidget {
  const FacultyListPage({Key? key}) : super(key: key);

  @override
  State<FacultyListPage> createState() => _FacultyListPageState();
}

class _FacultyListPageState extends State<FacultyListPage> {
  String totalFaculty = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kTextWhiteColor,
          ),
        ),
        title: Text(
          'Faculty Report',
          style: TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('type', isEqualTo: 'faculty')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<DocumentSnapshot> facultyDocuments = snapshot.data!.docs;
            totalFaculty = facultyDocuments.length.toString();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.topRight,
                      width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: kPrimaryColor,
                        ),
                        child: Center(child: Text(totalFaculty,style: TextStyle(fontSize: 16,color: kTextWhiteColor),))),
                  ),
                ),
                SizedBox(height: 20), // Add some space between app bar and list
                Expanded(
                  child: ListView.builder(
                    itemCount: facultyDocuments.length,
                    itemBuilder: (context, index) {
                      var facultyData =
                      facultyDocuments[index].data() as Map<String, dynamic>;
                      return FacultyTile(
                        facultyId: facultyDocuments[index].id,
                        facultyName: facultyData['fullName'],
                        facultyUid: facultyData['uid'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingPage(facultyId: facultyData['uid']),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FacultyTile extends StatefulWidget {
  final String facultyId;
  final String facultyName;
  final String facultyUid;
  final VoidCallback onTap;

  const FacultyTile({
    Key? key,
    required this.facultyId,
    required this.facultyName,
    required this.facultyUid,
    required this.onTap,
  }) : super(key: key);

  @override
  _FacultyTileState createState() => _FacultyTileState();
}

class _FacultyTileState extends State<FacultyTile> {
  double behaviourRating = 0.0;
  double skillRating = 0.0;
  double lectureRating = 0.0;
  double markingRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  void fetchRatings() async {
    try {
      DocumentSnapshot ratingSnapshot = await FirebaseFirestore.instance
          .collection('faculty_ratings')
          .doc(widget.facultyUid)
          .get();
      setState(() {
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${widget.facultyName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: behaviourRating,
                      center: Text(
                        "${(behaviourRating * 100).toInt()}%",
                        style: TextStyle(fontSize: 14),
                      ),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text(
                      "Behaviour",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: skillRating,
                      center: Text(
                        "${(skillRating * 100).toInt()}%",
                        style: TextStyle(fontSize: 14),
                      ),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text(
                      "Skills",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: lectureRating,
                      center: Text(
                        "${(lectureRating * 100).toInt()}%",
                        style: TextStyle(fontSize: 14),
                      ),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text(
                      "Lecture",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: markingRating,
                      center: Text(
                        "${(markingRating * 100).toInt()}%",
                        style: TextStyle(fontSize: 14),
                      ),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text(
                      "Marking",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
