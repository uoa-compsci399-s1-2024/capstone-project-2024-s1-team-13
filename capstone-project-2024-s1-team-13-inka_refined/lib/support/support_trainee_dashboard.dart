import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeDashboard extends StatelessWidget {
  const SupportTraineeDashboard({super.key, required this.traineeName});
  final String traineeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return const SupportNotifications(title: 'Notifications');
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'EVALUATE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'PROFILE',
          ),
        ],
        //currentIndex: _selectedIndex,
        //onTap: _onItemTapped,
      ),

      // Body of screen

      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "$traineeName's Summary",
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 50,
                    fontWeight: FontWeight.w600),
              )),

          // Temporary Navigation to Evaluate Page
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportEvaluate(title: 'Evaluate');
                }));
              },
              child: Text("To Evaluate"),
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
        ],
      ),
    );
  }
}
