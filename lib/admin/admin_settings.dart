import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_change_login.dart';
import 'package:inka_test/welcome/inka_welcome.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({Key? key, required this.title}) : super(key: key);
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
              'A',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 100,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ))),

        SizedBox(height: 20),

        // Text
        Text("Admin",
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900])),

        SizedBox(height: 250),

        // Change Login Button
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AdminChangeLogin(title: 'Change Login'); // To change
              }));
            },
            child: Text("Change Login"),
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
        ElevatedButton(
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
      ])),
    );
  }
}
