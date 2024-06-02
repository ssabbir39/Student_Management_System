import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Repository_and_Authentication/data/custom_user.dart';
import 'Repository_and_Authentication/services/auth.dart';
import 'constants.dart';
import 'routes.dart';
import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCfase-bgw4-VXBgla7clfhpjyVMy3vnOk',
          appId: '1:427125638558:web:9d198beb5abd9071ba028f',
          messagingSenderId: '427125638558',
          projectId: 'student-management-33a89',
          authDomain: 'student-management-33a89.firebaseapp.com',
          storageBucket: 'student-management-33a89.appspot.com',
        ),
      );
      print('Web Firebase initialized successfully');
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDuvwntRPueTAQW_4Vv7z-fzD8nSleYn9I',
        appId: '1:427125638558:android:ca0f2cb0ef1e70b7ba028f',
        messagingSenderId: '427125638558',
        projectId: 'student-management-33a89',
        storageBucket: 'student-management-33a89.appspot.com',
      ),
    );
    print('Android Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(

      // value is the stream method declared in "services.auth.dart"
        value: AuthService().streamUser,
        initialData: null,

        // MaterialApp
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