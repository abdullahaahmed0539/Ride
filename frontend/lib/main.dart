import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/providers/app.dart';
import 'package:frontend/providers/booking.dart';
import 'package:frontend/providers/driver.dart';
import 'package:frontend/providers/location.dart';
import 'package:frontend/services/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'global/configuration.dart';
import 'screens/home.dart';
import 'screens/users/login.dart';
import 'providers/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => UserProvider()),
        ChangeNotifierProvider(create:(_) => AppProvider()),
        ChangeNotifierProvider(create:(_) => LocationProvider()),
        ChangeNotifierProvider(create:(_) => DriverProvider()),
        ChangeNotifierProvider(create:(_) => BookingProvider()),
      ],
      child: MaterialApp(
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
        routes: routes(),
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => const Home()),
      ),
    );
  }
}
