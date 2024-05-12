import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:inka_test/support/support_select_trainee.dart';
import 'package:inka_test/support/support_trainees.dart';
import 'package:inka_test/welcome/inka_welcome.dart';

class SupportSettings extends StatelessWidget {
  const SupportSettings({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
          child: Column(children: [
        SizedBox(height: 100),

        // Support Staff Avatar
        Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 196, 155, 175),
                    const Color.fromARGB(255, 87, 195, 245)
                  ], // Gradient colors
                  begin: Alignment.topLeft, // Gradient begin position
                  end: Alignment.bottomRight, // Gradient end position
                )),
            child: Center(
                child: Text(
              'S',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 100,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ))),

        /*
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 150,
          child: Text(
            'S',
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 100,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),*/

        SizedBox(height: 20),

        // Text
        Text("Support Staff",
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900])),

        SizedBox(height: 250),

        // Switch Trainee Button
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SupportTrainees(title: 'Trainees');
              }));
            },
            child: Text("Switch Trainee"),
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

        // Logout Button - pending backend functionality
        /*ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InkaWelcome(title: 'Welcome');
              }));
            },
            child: Text("Logout"),
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
                    borderRadius: BorderRadius.circular(50))))
      ])),*/
        // Logout Button - pending backend functionality
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
            child: Text("Logout"),
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
                    borderRadius: BorderRadius.circular(50))))
      ])),
    );
  }
}