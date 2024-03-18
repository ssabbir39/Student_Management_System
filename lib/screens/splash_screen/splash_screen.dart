import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Announchment/screens/wrapper.dart';
import '../../constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String routeName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushNamedAndRemoveUntil(context,
          Wrapper.routeName, (route) => false);
    });

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    height: 250.0,
                    width: 250.0,
                  ),
                  kHalfSizeBox,
                  Text(
                    'STUDENT',
                    style: GoogleFonts.pattaya(
                      fontSize: 60.0,
                      fontStyle: FontStyle.italic,
                      color: kTextWhiteColor,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 6),
                  Text(
                    'MANAGEMENT',
                    style: GoogleFonts.pattaya(
                      fontSize: 50.0,
                      fontStyle: FontStyle.italic,
                      color: kTextWhiteColor,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
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
