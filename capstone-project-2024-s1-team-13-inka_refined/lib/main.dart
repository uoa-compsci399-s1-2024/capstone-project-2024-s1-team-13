import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:inka_test/support/support_select_trainee.dart';
import 'package:inka_test/welcome/inka_welcome.dart';
import 'amplifyconfiguration.dart';
import 'package:inka_test/welcome/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Inka Test',
        theme: ThemeData(

            // App bar theme
            appBarTheme: const AppBarTheme(
                toolbarHeight: 100,
                elevation: 10, // No elevation
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

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

//start of checking
class SignInScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn(BuildContext context) async {
    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (result.isSignedIn) {
        // User is signed in, navigate to the next screen
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportSelectTrainee(title: 'Select Trainee');
        }));
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _signIn(context),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
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
