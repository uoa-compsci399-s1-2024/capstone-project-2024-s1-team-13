import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainee_notes.dart';
import 'package:inka_test/admin/admin_trainee_progress.dart';
import 'package:inka_test/admin/admin_trainees.dart';
import 'package:inka_test/items/trainee_item.dart';

class AdminTraineeProfile extends StatefulWidget {
  const AdminTraineeProfile({super.key, required this.title, required this.trainee});
  final String title;
  final TraineeItem trainee;

  @override
  _AdminTraineeProfileState createState() => _AdminTraineeProfileState();
}

class _AdminTraineeProfileState extends State<AdminTraineeProfile> {
  // Bottom Bar Navigation
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainees
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTrainees(title: 'Trainees')));
        break;
      case 1:
        // Navigate to tasks
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to recipes
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminRecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminSettings(title: 'Settings');
              }));
            },
            iconSize: 45,
            icon: const Icon(Icons.settings),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'TRAINEES',
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // Body of screen

      body: Center(
          child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(50), child: _profileDetails()),
          const SizedBox(height: 10),
          _progressButton(context),
          const SizedBox(height: 50),
          _notesButton(context)
        ],
      )),
    );
  }

  // Widgets

  Widget _profileDetails() => Row(
        children: [
          CircleAvatar(
              foregroundImage: AssetImage(widget.trainee.assetImage),
              radius: 100),
          const SizedBox(width: 50),
          Text("${widget.trainee.firstName} ${widget.trainee.lastName}",
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 50,
                  fontWeight: FontWeight.w500))
        ],
      );

  // Progress Button
  Widget _progressButton(context) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminTraineeProgress(title: 'Progress');
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 196, 155, 175),
                Color.fromARGB(255, 87, 195, 245)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          ),
          child: const Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.auto_graph_rounded, size: 70, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Progress',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      );

  // Notes Button

  Widget _notesButton(context) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminTraineeNotes(title: 'Notes');
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 196, 155, 175),
                Color.fromARGB(255, 87, 195, 245)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          ),
          child: const Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.notes_rounded, size: 70, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Notes',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      );
}
