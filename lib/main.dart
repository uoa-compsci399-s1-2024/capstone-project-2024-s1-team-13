import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inka_test/welcome/inka_welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Inka Test',
        theme: ThemeData(

            // App bar theme
            appBarTheme: const AppBarTheme(
                toolbarHeight: 100,
                elevation: 10, // No elevation?
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(
                    255, 219, 75, 72), // This red does not look the same?
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                titleTextStyle: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500)),

            // Bottom navigation bar theme
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                elevation: 10, // No elevation?

                // Theme for selected icon and labels
                selectedLabelStyle: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.pink[900]),
                selectedIconTheme: IconThemeData(
                  color: Colors.pink[900],
                  size: 50,
                ),

                // Theme for unselected icon and labels
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: Color.fromARGB(255, 193, 193, 193),
                ),
                unselectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 193, 193, 193), size: 50))),
        home: Welcome());
  }
}

// Splash screen
class Welcome extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => InkaWelcome(
                      title: "Weclome",
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset('assets/images/inka_logo.png'), color: Colors.white);
  }
}
