import 'package:flutter/material.dart';

class AdminGreetingText extends StatefulWidget {
  @override
  _GreetingTextState createState() => _GreetingTextState();
}

class _GreetingTextState extends State<AdminGreetingText> {
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _updateGreeting();
  }

  void _updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    setState(() {
      if (hour < 12) {
        _greeting = 'Morning';
      } else if (hour < 18) {
        _greeting = 'Afternoon';
      } else {
        _greeting = 'Evening';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      textAlign: TextAlign.center,
      'Good $_greeting, Admin!',
      style: TextStyle(
        fontFamily: "Lexend Exa",
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
    ));
  }
}
