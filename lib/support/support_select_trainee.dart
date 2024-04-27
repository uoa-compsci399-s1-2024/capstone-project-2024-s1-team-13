import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/support/support_items/support_greeting_text.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainees.dart';

class SupportSelectTrainee extends StatelessWidget {
  const SupportSelectTrainee({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Application Bar

        appBar: AppBar(
          title: SizedBox(
            height: 250,
            child:
                SvgPicture.asset('assets/images/inka.svg', color: Colors.white),
          ),
          leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.notifications_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportNotifications(title: 'Notifications');
                }));
              }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SupportSettings(title: 'Settings');
                }));
              }, // To add functionality to settings
              iconSize: 45,
              icon: Icon(Icons.settings),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  child: SupportGreetingText()),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SupportTrainees(title: 'Trainees');
                  }));
                },
                child: Text('Select Trainee'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(500, 100),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              )
            ],
          ),
        ));
  }
}
