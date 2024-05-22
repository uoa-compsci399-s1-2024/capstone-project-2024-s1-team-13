import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inka_test/welcome/admin_login.dart';
import 'package:inka_test/welcome/support_login.dart';

class SelectLoginType extends StatefulWidget {
  SelectLoginType({super.key, required this.title});
  final String title;

  @override
  SelectLoginTypeState createState() => SelectLoginTypeState();
}

class SelectLoginTypeState extends State<SelectLoginType> {
  late Gradient _gradient;
  late List<Color> _startColors;
  late List<Color> _endColors;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startColors = [
      Color.fromARGB(255, 87, 195, 245),
      Color.fromARGB(255, 249, 129, 187)
    ];
    _endColors = [
      Color.fromARGB(255, 249, 129, 187),
      Color.fromARGB(255, 87, 195, 245)
    ];

    _gradient = LinearGradient(colors: _startColors);

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        // Toggle between start and end colors for the gradient
        if (_gradient.colors == _startColors) {
          _gradient = LinearGradient(colors: _endColors);
        } else {
          _gradient = LinearGradient(colors: _startColors);
        }
      });
    });
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            IconButton(
                iconSize: 50,
                color: Colors.grey[500],
                icon: const Icon(Icons.arrow_back_ios),
                padding:
                    const EdgeInsets.only(left: 30.0, bottom: 10.0, top: 10.0),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text(
              "Welcome",
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            )
          ],
        ),
      ),
      Expanded(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Select Login Type",
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 55,
                  fontWeight: FontWeight.w600)),

          SizedBox(height: 75),

          // Support Login Button
          AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: _gradient,
              borderRadius: BorderRadius.circular(70),
            ),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SupportLogin(title: 'Login');
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Color.fromARGB(33, 255, 255, 255),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                child: const Text("Support")),
          ),

          SizedBox(height: 40),

          // Admin Login Button
          AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: _gradient,
              borderRadius: BorderRadius.circular(70),
            ),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminLogin(title: 'Login');
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Color.fromARGB(33, 255, 255, 255),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                child: const Text("Admin")),
          )
        ]),
      ))
    ])));
  }
}
