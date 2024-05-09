import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/support/support_select_trainee.dart';

class Login extends StatelessWidget {
  Login({super.key, required this.title});
  final String title;

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Login Authentication
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Form(
                child: Column(
      children: [
        Padding(padding: const EdgeInsets.all(100), child: _LoginTitle()),
        _supportAdminIcon(),
        const SizedBox(height: 40),
        Padding(
            padding: const EdgeInsets.only(left: 150, right: 150),
            child: _LoginForm()),
        const SizedBox(height: 40),
        _LoginButton(context)
      ],
    ))));
  }

  Widget _LoginTitle() =>
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text("LOG IN",
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 60,
                  fontWeight: FontWeight.w800)),
          Icon(Icons.login_rounded, size: 80, color: Colors.black)
        ]),
        Text("Please login to continue",
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 219, 75, 72)))
      ]);

  Widget _supportAdminIcon() => Column(children: [
        Icon(Icons.group_rounded, size: 200, color: Colors.pink[900]),
        Text("Support Staff | Admin",
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]))
      ]);

  Widget _LoginForm() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Username
        const Text(
          "Username",
          style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
            controller: _usernameController,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter username",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
        const SizedBox(height: 30),

        // Password
        const Text(
          "Password",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter password",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
        const SizedBox(height: 30),
      ]);

//Login Button
  //Widget _LoginButton(context) => ElevatedButton(
        //onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) {
            //return const SupportSelectTrainee(title: 'Select Trainee');
          //}));
        //},
        //style: ElevatedButton.styleFrom(
            //minimumSize: const Size(400, 80),
            //foregroundColor: Colors.white,
            //textStyle: const TextStyle(
              //fontSize: 30,
              //fontFamily: 'Lexend Exa',
              //fontWeight: FontWeight.w500,
            //),
            //backgroundColor: Colors.pink[900],
            //elevation: 2,
            //shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(50))),
        //child: const Text('Login'),
      //);


//with auth:

  //Login Button
  Widget _LoginButton(context) => ElevatedButton(
        onPressed: () {
          // to change
          _LogIn(context);
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(400, 80),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 30,
              fontFamily: 'Lexend Exa',
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.pink[900],
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
      );





    // Mock Functionality
  void _LogIn(context) async {
    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      if (result.isSignedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportSelectTrainee(title: 'Select Trainee');
        }));
      }
      if (result != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportSelectTrainee(title: 'Select Trainee');
        }));
      } else
        (print("eRRRRRROR !!!!"));
      // User is signed in
    } catch (error) {
      print('Error signing in: $error');
    }
  }
}
