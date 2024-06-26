import 'package:flutter/material.dart';

class SupportGreetingText extends StatefulWidget {
  const SupportGreetingText({super.key});

  @override
  _GreetingTextState createState() => _GreetingTextState();
}

class _GreetingTextState extends State<SupportGreetingText> {
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
      'Good $_greeting, Support!',
      style: const TextStyle(
        fontFamily: "Lexend Exa",
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
    ));
  }
}
