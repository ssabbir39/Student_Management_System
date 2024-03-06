import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart'; // Import your custom constants here

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor, // Use your primary color from constants.dart
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Customize the color of the loading indicator
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
