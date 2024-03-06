import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';

import '../home_screen.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  static String routeName = 'ExamScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: kTextWhiteColor,),
          ),
          title: const Text(
            'Exams Schedule',
            style: TextStyle(
              fontSize: 25,
              color: kTextWhiteColor
            ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '  Upcoming Exams',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: kPrimaryColor),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 120.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                    children: [
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                width: 220.0,
                                margin: const EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.blue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Data Structure',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Date: 16 May 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        'Time: 10:00 AM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                                            ),
                              ),
                              Container(
                        width: 220.0,
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.blue,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Object Oriented Programming',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                'Date: 16 May 2024',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'Time: 12:00 PM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                              Container(
                                width: 220.0,
                                margin: const EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.blue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Algorithm',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Date: 17 May 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        'Time: 10:00 AM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 220.0,
                                margin: const EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.blue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Cloude Computing',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Date: 18 May 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        'Time: 10:00 AM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 220.0,
                                margin: const EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.blue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Machine Learning',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Date: 20 May 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        'Time: 10:00 AM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                '  Recent Exams',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: kPrimaryColor),
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: const [
                    Card(
                      elevation: 2.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.book, color: Colors.white),
                        ),
                        title: Text('C Programming',style: TextStyle(fontSize: 20),),
                        subtitle: Text('12 May 2024, 9:00 AM',style: TextStyle(fontSize: 20),),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 2.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.book, color: Colors.white),
                        ),
                        title: Text('Object Oriented Programming',style: TextStyle(fontSize: 20),),
                        subtitle: Text('12 May 2024, 9:00 AM',style: TextStyle(fontSize: 20),),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
