import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../home_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  static String routeName = 'ResultScreen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final List<Map<String, String>> reportData = [
    {
      'subject': 'CSE 4111',
      'grade': 'A+',
      'teacher': 'Md Mehedi Hasan',
      'date': 'April 12, 2024'
    },
    {
      'subject': 'MAT 1367',
      'grade': 'A',
      'teacher': 'Md Abdullah Bin Masud',
      'date': 'April 10, 2024'
    },
    {
      'subject': 'ECO 2147',
      'grade': 'A+',
      'teacher': 'Md. Kholilur Rahman',
      'date': 'April 8, 2024'
    },
    {
      'subject': 'ECS 1001',
      'grade': 'A',
      'teacher': 'Bonita Yeasmin',
      'date': 'April 5, 2024'
    },
    {
      'subject': 'CSE 2337',
      'grade': 'A+',
      'teacher': 'Sazzad Hossain Bhuiyan',
      'date': 'April 3, 2024'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, StudentHomeScreen.routeName);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text('Semester Result',style: TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: reportData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reportData[index]['subject']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Grade: ${reportData[index]['grade']}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Teacher: ${reportData[index]['teacher']}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  reportData[index]['date']!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
