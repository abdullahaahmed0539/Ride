import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/DisputeGuidelines.dart';
import 'package:frontend/screens/Home.dart';
import 'package:frontend/screens/Login.dart';
import 'package:frontend/screens/PublishDispute.dart';
import 'package:frontend/screens/Rating.dart';
import 'package:frontend/screens/Verification.dart';
import 'package:frontend/screens/Register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 134, 64, 232),
        backgroundColor: const Color(0xFF202124),
        fontFamily: 'SF-Pro-Rounded',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'SF-Pro-Rounded',
                  fontWeight: FontWeight.bold),
              titleMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Rounded',
                  fontWeight: FontWeight.bold),
              titleSmall: const TextStyle(
                color: Color(0xffA0A0A0),
                fontSize: 15,
                fontFamily: 'SF-Pro-Rounded',
              ),
              bodyMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Rounded',
                  fontWeight: FontWeight.normal),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'SF-Pro-Rounded',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
          backgroundColor: Color.fromARGB(255, 134, 64, 232),
        ),
      ),
      initialRoute: Login.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        Login.routeName: (context) => const Login(),
        Register.routeName:(context) => Register(),
        Verification.routeName: (context) => const Verification(),
        Rating.routeName: (context) => const Rating(),
        DisputeGuidelines.routeName: (context) => const DisputeGuidelines(),
        PublishDispute.routeName:(context) => const PublishDispute(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
