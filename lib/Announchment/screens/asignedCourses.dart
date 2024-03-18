import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Repository_and_Authentication/data/custom_user.dart';
import '../../Repository_and_Authentication/services/classes_db.dart';
import '../../constants.dart';


class AssignedCoursesPage extends StatelessWidget {
  const AssignedCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: kTextWhiteColor,),
        ),
        title: Text(
          'Assigned Courses',
          style: TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
          color: kOtherColor,
        ),
        child: FutureBuilder<List<Map<String, dynamic>>?>(
          future: ClassesDB(user: user).getFacultyCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError || snapshot.data == null) {
                return Center(child: Text('Error: Failed to fetch data'));
              } else {
                return _buildCoursesList(context, snapshot.data!);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, List<Map<String, dynamic>> courses) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        final uiColor = Color(int.parse(course['uiColor']));
        final studentsJoined = course['studentsJoined'] ?? 0;

        return Card(
          color: uiColor, // Set the background color of the Card
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['className'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "Courses: ${course['description']}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'Students Joined: $studentsJoined',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              // Add any functionality you want when the ListTile is tapped
            },
          ),
        );
      },
    );
  }

}
