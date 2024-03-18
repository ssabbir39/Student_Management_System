import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Repository_and_Authentication/data/accounts.dart';
import '../../../Repository_and_Authentication/data/classrooms.dart';
import '../../../Repository_and_Authentication/data/custom_user.dart';


class AssignedCoursesTab extends StatefulWidget {
  final Account? account; // Define account as a parameter

  const AssignedCoursesTab({Key? key, required this.account}) : super(key: key);

  @override
  _AssignedCoursesTabState createState() => _AssignedCoursesTabState();
}

class _AssignedCoursesTabState extends State<AssignedCoursesTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = widget.account;
    List _classRoomList =
    classRoomList.where((i) => i.creator == account).toList(); // Use account directly

    return ListView.builder(
      itemCount: _classRoomList.length,
      itemBuilder: (context, int index) {
        return Stack(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: _classRoomList[index].uiColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 30),
              width: 220,
              child: Text(
                _classRoomList[index].className,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 58, left: 30),
              child: Text(
                _classRoomList[index].description,
                style: TextStyle(
                    fontSize: 14, color: Colors.white, letterSpacing: 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 30),
              child: Text(
                _classRoomList[index].creator.fullName! +
                    " " +
                    _classRoomList[index].creator.email, // Fix concatenation
                style: const TextStyle(
                    fontSize: 12, color: Colors.white54, letterSpacing: 1),
              ),
            )
          ],
        );
      },
    );
  }
}
