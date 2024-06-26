import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/admin/admin_items/admin_greeting_text.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainees.dart';

class AdminSelection extends StatelessWidget {
  const AdminSelection({super.key, required this.title});
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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminSettings(title: 'Settings');
                }));
              }, // To add functionality to settings
              iconSize: 45,
              icon: const Icon(Icons.settings),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  child: AdminGreetingText()),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdminTrainees(title: 'Trainees');
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                child: const Text('Trainees'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdminTasksScreen(title: 'Tasks');
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                child: const Text('Tasks'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdminRecipesScreen(title: 'Recipes');
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 125),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Lexend Exa',
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.pink[900],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                child: const Text('Recipes'),
              )
            ],
          ),
        ));
  }
}
