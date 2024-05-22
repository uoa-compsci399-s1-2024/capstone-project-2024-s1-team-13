import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:inka_test/admin/admin_selection.dart';
import 'package:inka_test/welcome/reset_password.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({super.key, required this.title});
  final String title;

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorMessage = '';
  bool _isPasswordVisible = false; // For toggling password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      IconButton(
                          iconSize: 50,
                          color: Colors.grey[500],
                          icon: const Icon(Icons.arrow_back_ios),
                          padding: const EdgeInsets.only(
                              left: 30.0, bottom: 10.0, top: 10.0),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        "Login Type",
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 150, top: 60, bottom: 50),
                  child: _LoginTitle(),
                ),
                _adminIcon(),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(left: 150, right: 150),
                  child: _LoginForm(),
                ),
                SizedBox(height: 10),
                _LoginButton(context),
                _forgotPasswordButton(context),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 75, right: 75),
                    child: Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'Lexend Exa',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logIn(BuildContext context) async {
    try {
      var authSession = await Amplify.Auth.fetchAuthSession();
      if (authSession.isSignedIn) {
        await Amplify.Auth.signOut();
      }

      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result.isSignedIn) {
        List<AuthUserAttribute> attributes =
            await Amplify.Auth.fetchUserAttributes();
        String role = attributes
            .firstWhere(
                (attribute) => attribute.userAttributeKey.key == 'custom:role')
            .value;

        if (role == 'admin') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminSelection(title: 'Select Trainee');
          }));
        } else {
          setState(() {
            _errorMessage = 'Access denied: You are not an Admin';
            Amplify.Auth.signOut();
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (error) {
      setState(() {
        if (error is AuthException) {
          _errorMessage = 'Error signing in: ${error.message}';
        } else {
          _errorMessage = 'Error signing in: $error';
        }
      });
    }
  }

  Widget _LoginTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("LOG IN",
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 60,
                      fontWeight: FontWeight.w800)),
              Icon(Icons.login_rounded, size: 80, color: Colors.black)
            ],
          ),
          Text("Please login to continue",
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 219, 75, 72)))
        ],
      );

  Widget _adminIcon() => Column(
        children: [
          Icon(Icons.person_rounded, size: 200, color: Colors.pink[900]),
          Text("Admin",
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink[900]))
        ],
      );

  Widget _LoginForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Username",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: _usernameController,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter username",
              hintStyle: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Password",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter password",
              hintStyle: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      );

  Widget _LoginButton(context) => ElevatedButton(
        onPressed: () {
          _logIn(context);
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(530, 100),
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

  Widget _forgotPasswordButton(context) => TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PasswordResetPage()),
          );
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontFamily: 'Lexend Exa',
            fontSize: 18,
            color: Colors.red,
            decoration: TextDecoration.underline,
          ),
        ),
      );
}
