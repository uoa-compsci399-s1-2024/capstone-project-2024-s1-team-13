import 'package:flutter/material.dart';
import 'package:inka_test/welcome/inka_welcome.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 100),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Support Staff Avatar
              Column(
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 196, 155, 175),
                              Color.fromARGB(255, 87, 195, 245)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: const Center(
                          child: Text(
                        'A',
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 100,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ))),
                  const SizedBox(height: 20),
                  // Text
                  Text("Admin",
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink[900])),
                ],
              ),

              // Logout Button
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await Amplify.Auth.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return InkaWelcome(title: 'Welcome');
                      }));
                    } catch (e) {
                      print('Error signing out: $e');
                    }
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
                  child: const Text("Logout"))
            ]),
      )),
    );
  }
}
