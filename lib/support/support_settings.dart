import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_selection.dart';
import 'package:inka_test/support/support_trainees.dart';
import 'package:inka_test/welcome/inka_welcome.dart';

class SupportSettings extends StatelessWidget {
  const SupportSettings({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
          child: Column(children: [
        const SizedBox(height: 100),

        // Support Staff Avatar
        Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 196, 155, 175),
                    Color.fromARGB(255, 87, 195, 245)
                  ], // Gradient colors
                  begin: Alignment.topLeft, // Gradient begin position
                  end: Alignment.bottomRight, // Gradient end position
                )),
            child: const Center(
                child: Text(
              'S',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 100,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ))),

        const SizedBox(height: 20),

        // Text
        Text("Support Staff",
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900])),

        const SizedBox(height: 250),

        // Switch Trainee Button
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SupportTrainees(title: 'Trainees');
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
            child: const Text("Switch Trainee")),

        const SizedBox(height: 20),

        // Logout Button - pending backend functionality
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InkaWelcome(title: 'Welcome');
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
            child: const Text("Logout")),

        const SizedBox(height: 20),
        // To admin [temporary]
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminSelection(title: 'Admin Home');
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
            child: const Text("Admin"))
      ])),
    );
  }
}
