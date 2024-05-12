import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:amplify_core/amplify_core.dart';
import 'package:inka_test/support/support_select_trainee.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Login extends StatefulWidget {
  Login({super.key, required this.title});
  final String title;

  //final TextEditingController _usernameController = TextEditingController();

  //final TextEditingController _passwordController = TextEditingController();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorMessage = '';

  // Login Authentication

  /*void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
  }*/

  /*Future<void> getUserAttributes() async {
    try {
      AuthUser user = await Amplify.Auth.getCurrentUser();
      List<AuthUserAttribute> attributes =
          await Amplify.Auth.getUserAttributes(user: user);
      // Now you can access the user attributes
      for (AuthUserAttribute attribute in attributes) {
        print(
            'Attribute: ${attribute.userAttributeKey}, Value: ${attribute.value}');
      }
    } catch (e) {
      print('Error getting user attributes: $e');
    }
  }*/

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
        _LoginButton(context),
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(75),
            child: Text(
              _errorMessage,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontFamily: 'Lexend Exa',
                  fontWeight: FontWeight.w500),
            ),
          )
      ],
    ))));
  }

  /*void _logIn(BuildContext context) async {
    try {
      print('step 1');
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('Sign in result: $result'); // Check the result object
      if (result.isSignedIn) {
        print('step 2');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          print('step 3');
          return SupportSelectTrainee(title: 'Select Trainee');
        }));
        print('step 4');
      } else {
        print('step 5');
        setState(() {
          print('step 6');
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (error) {
      print('Error signing in: $error');
      setState(() {
        if (error is AuthException) {
          _errorMessage = 'Error signing in: ${error.message}';
        } else {
          _errorMessage = 'Error signing in: $error';
        }
      });
    }
  }*/
  void _logIn(context) async {
    try {
      // Check if a user is already signed in
      var authSession = await Amplify.Auth.fetchAuthSession();
      if (authSession.isSignedIn) {
        // If a user is signed in, sign them out first
        await Amplify.Auth.signOut();
      }

      print('step 1');
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (result.isSignedIn) {
        print('step 2');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          print('step 3');
          return SupportSelectTrainee(title: 'Select Trainee');
        }));
        print('step 4');
      } else if (result.nextStep.signInStep == 'confirmSignInWithNewPassword') {
        // Handle confirmSignInWithNewPassword step
        print('step 5');

        setState(() {
          print('step 6');

          _errorMessage = 'Additional information required';
        });

        // Prompt the user to provide the required attributes (preferred username and name)
        // and call confirmSignIn method to confirm the sign-in with the new password and additional attributes
      } else {
        print('step 5');
        setState(() {
          print('step 6');

          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (error) {
      print('Error signing in: $error');
      setState(() {
        if (error is AuthException) {
          _errorMessage = 'Error signing in: ${error.message}';
        } else {
          _errorMessage = 'Error signing in: $error';
        }
      });
    }
  }

  /*void _logIn(context) async {
    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (result.isSignedIn) {
        // Get user attributes to determine role
        var user = await Amplify.Auth.getCurrentUser();
        var attributes = user.attributes;
        /*if (attributes['custom:role'] == 'admin') {
          // Redirect to admin interface
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminDashboard();
          }));
        } */
        if (attributes['custom:role'] == 'support') {
          // Redirect to support interface
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SupportSelectTrainee(title: 'Select Trainee');
          }));
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (error) {
      print('Error signing in: $error');
      setState(() {
        if (error is AuthException) {
          _errorMessage = 'Error signing in: ${error.message}';
        } else {
          _errorMessage = 'Error signing in: $error';
        }
      });
    }
  }*/

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

/* OG (keep)
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
        // Error message
        
        if (_errorMessage.isNotEmpty)
          Padding(
          padding: const EdgeInsets.all(8.0),
          Text("(_errorMessage)",
          style: TextStyle(color: Colors.red),
          ),
          ),
      */

  Widget _LoginForm() => Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username
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

          // Password
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
            obscureText: true,
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
            ),
          ),
          SizedBox(height: 30),
        ],
      ));

//Login Button
  Widget _LoginButton(context) => ElevatedButton(
        onPressed: () {
          // to change
          _logIn(context);
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

  //OG Login method here
}