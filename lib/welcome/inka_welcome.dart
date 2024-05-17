import 'package:flutter/material.dart';
import 'package:inka_test/welcome/select_login_type.dart';
import 'package:inka_test/welcome/support_login.dart';
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
        const SizedBox(height: 50),

        _buildLogo(),
        const SizedBox(height: 20),

        _buildTitle(),
        const SizedBox(height: 50),

        _buildImage(),
        const SizedBox(height: 50),

        // Buttons
        SizedBox(
            width: 500,
            height: 220,
            child: Column(
              children: [
                // Training Modules Button
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TrainingModules(title: 'Modules');
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 100),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lexend Exa',
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.pink[900],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text("Training Modules")),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SelectLoginType(title: 'Login');
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 100),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lexend Exa',
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.pink[900],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text("Login")),
              ],
            ))
      ],
    )));
  }

// Welcome Logo
  Widget _buildLogo() => Container(
        height: 100,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/inka_logo.png'),
        )),
      );

// Welome Title Widget
  Widget _buildTitle() => const Text(
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/te_tuhi_cafe.png'),
                fit: BoxFit.cover)),
      );
}
