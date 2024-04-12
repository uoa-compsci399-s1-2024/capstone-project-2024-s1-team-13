import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/modules/modules_notifications.dart';
import 'package:inka_test/modules/recipes_screen.dart';
import 'package:inka_test/modules/tasks_screen.dart';
import 'package:inka_test/support/support_settings.dart';

class TrainingModules extends StatelessWidget {
  const TrainingModules({super.key, required this.title});
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
                return const ModuleNotifications(title: 'Notifications');
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'RECIPES',
          ),
        ],
        //currentIndex: _selectedIndex,
        //onTap: _onItemTapped,
      ),

      // Body of screen

      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tasks Button
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TasksScreen(title: 'Tasks'); // Was const -will change
                }));
              },
              child: Text("Tasks"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(700, 250),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.pink[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
          SizedBox(height: 40),

          // Recipes Button
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipesScreen(
                      title: 'Recipes'); // Was const - will change
                }));
              },
              child: Text("Recipes"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(700, 250),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.pink[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
        ],
      )),
    );
  }
}
