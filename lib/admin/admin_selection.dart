import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/admin/admin_items/admin_greeting_text.dart';
import 'package:inka_test/admin/admin_notifications.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainees.dart';

class AdminSelection extends StatelessWidget {
  AdminSelection({super.key, required this.title});
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
                  return AdminNotifications(title: 'Notifications');
                }));
              }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminSettings(title: 'Settings');
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
                  child: AdminGreetingText()),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminTrainees(title: 'Trainees');
                  }));
                },
                child: Text('Trainees'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminTasksScreen(title: 'Tasks');
                  }));
                },
                child: Text('Tasks'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminRecipesScreen(title: 'Recipes');
                  }));
                },
                child: Text('Recipes'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
              )
            ],
          ),
        ));
  }
}
