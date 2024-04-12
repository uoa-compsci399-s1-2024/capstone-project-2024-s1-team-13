import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inka_test/welcome/login.dart';
import 'package:inka_test/modules/training_modules.dart';

class InkaWelcome extends StatelessWidget {
  const InkaWelcome({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 50),

        _buildLogo(),
        SizedBox(height: 20),

        _buildTitle(),
        SizedBox(height: 50),

        _buildImage(),
        SizedBox(height: 50),

        // Buttons
        Container(
            width: 500,
            height: 220,
            child: Column(
              children: [
                // Training Modules Button
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TrainingModules(title: 'Modules');
                      }));
                    },
                    child: Text("Training Modules"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(700, 100),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lexend Exa',
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.pink[900],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)))),
                SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Login(title: 'Login');
                      }));
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(700, 100),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lexend Exa',
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.pink[900],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)))),
              ],
            ))
      ],
    )));
  }

// Welcome Logo
  Widget _buildLogo() => Container(
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/inka_logo.png'),
        )),
      );

// Welome Title Widget
  Widget _buildTitle() => Text(
        "Welcome to Te Tuhi Café",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Lexend Exa',
            fontSize: 45,
            fontWeight: FontWeight.w500),
      );

// Welcome Image Widget

  Widget _buildImage() => Container(
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/te_tuhi_cafe.png'),
                fit: BoxFit.cover)),
      );
}
