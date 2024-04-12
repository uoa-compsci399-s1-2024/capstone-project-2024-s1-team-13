import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        Padding(padding: EdgeInsets.all(100), child: _LoginTitle()),
        _supportAdminIcon(),
        SizedBox(height: 40),
        Padding(
            padding: EdgeInsets.only(left: 150, right: 150),
            child: _LoginForm()),
        SizedBox(height: 40),
        _LoginButton(context)
      ],
    ))));
  }

  Widget _LoginTitle() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        Text(
          "Username",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _usernameController,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
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
        SizedBox(height: 30),

        // Password
        Text(
          "Password",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
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
        SizedBox(height: 30),
      ]);

//Login Button
  Widget _LoginButton(context) => ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SupportSelectTrainee(title: 'Select Trainee');
          }));
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
}
