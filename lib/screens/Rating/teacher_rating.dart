import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'; // Import CircularPercentIndicator
import '../../constants.dart';
import 'rating_page.dart'; // Import the rating page

class FacultyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios,color: kTextWhiteColor,)),
        title: const Text('Faculty List', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'faculty').snapshots(),
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
            return ListView.builder(
              itemCount: facultyDocuments.length,
              itemBuilder: (context, index) {
                var facultyData = facultyDocuments[index].data() as Map<String, dynamic>;
                return FacultyTile(
                  facultyId: facultyDocuments[index].id,
                  facultyName: facultyData['fullName'],
                  facultyUid: facultyData['uid'],
                  onTap: () {
                    // Navigate to the rating page when faculty tile is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RatingPage(facultyId: facultyData['uid'])),
                    );
                  },
                );
              },
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
    // Fetch ratings from Firestore
    fetchRatings();
  }

  void fetchRatings() async {
    try {
      // Fetch the ratings for the specific faculty member
      DocumentSnapshot ratingSnapshot = await FirebaseFirestore.instance
          .collection('faculty_ratings')
          .doc(widget.facultyUid)
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: kPrimaryColor, // You can change the color as needed
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
            Text(
              "ID: ${widget.facultyId}",
              style: TextStyle(fontSize: 14),
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
                      progressColor: Colors.green, // Change the color as needed
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text("Behaviour",style: TextStyle(fontSize: 16),)
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
                      progressColor: Colors.green, // Change the color as needed
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text("Skills",style: TextStyle(fontSize: 16),)
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
                      progressColor: Colors.green, // Change the color as needed
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text("Lecture",style: TextStyle(fontSize: 16),)
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
                      progressColor: Colors.green, // Change the color as needed
                      backgroundColor: Colors.grey,
                    ),
                    kHalfSizeBox,
                    const Text("Marking",style: TextStyle(fontSize: 16),)
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
