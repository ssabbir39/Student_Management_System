import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/firebase_options.dart';
import 'package:student_management_system/routes.dart';
import 'Announchment/data/custom_user.dart';
import 'Announchment/services/auth.dart';
import 'constants.dart';
import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Web Firebase initialized successfully');
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Android Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
        value: AuthService().streamUser,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: kPrimaryColor,
            primaryColor: kPrimaryColor,
            appBarTheme: const AppBarTheme(
              color: kPrimaryColor,
              elevation: 0,
            ),
            textTheme:
            GoogleFonts.sourceCodeProTextTheme(Theme.of(context).textTheme)
                .apply()
                .copyWith(
              bodyLarge: const TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold),
              bodyMedium: const TextStyle(
                color: kTextWhiteColor,
                fontSize: 28.0,
              ),
              titleMedium: const TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500),
              titleSmall: const TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                fontSize: 15.0,
                color: kTextLightColor,
                height: 0.5,
              ),
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: kTextBlackColor,
                height: 0.5,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kTextLightColor,
                  width: 0.7,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kTextLightColor,
                ),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kTextLightColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kErrorBorderColor, width: 1.2),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kErrorBorderColor,
                  width: 1.2,
                ),
              ),
            ),
          ),
          initialRoute: SplashScreen.routeName,
          routes: routes,));
  }
}
