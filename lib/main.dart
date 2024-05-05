import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inka_test/amplifyconfiguration.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/support/support_select_trainee.dart';
import 'package:inka_test/welcome/inka_welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// Please update theme as per your need if required.

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

   // Configure Amplify
  Future<void> configureAmplify() async {
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    final storage = AmplifyStorageS3();
    final auth = AmplifyAuthCognito(); 
    
    await Amplify.addPlugins([api, storage, auth]);
    

    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }

     @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      throw UnimplementedError();
    }
  }

  


  


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Inka Test',
        debugShowCheckedModeBanner: false,
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
        home: const Welcome());
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
  const Welcome({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const InkaWelcome(
                      title: "Weclome",
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset('assets/images/inka_logo.png'));
  }
}