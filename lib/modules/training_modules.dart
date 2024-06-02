import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/modules/modules_settings.dart';
import 'package:inka_test/modules/recipes_screen.dart';
import 'package:inka_test/modules/tasks_screen.dart';

class TrainingModules extends StatefulWidget {
  const TrainingModules({super.key, required this.title});
  final String title;

  @override
  _TrainingModulesState createState() => _TrainingModulesState();
}

class _TrainingModulesState extends State<TrainingModules> {
  // Bottom Bar Navigation
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to modules dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TrainingModules(title: 'Modules')));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
  }

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
                return const ModulesSettings(title: 'Settings');
              }));
            },
            iconSize: 45,
            icon: const Icon(Icons.settings),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
                  return const TasksScreen(
                      title: 'Tasks'); // Was const -will change
                }));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(700, 250),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 45,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.pink[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text("Tasks")),
          const SizedBox(height: 40),

          // Recipes Button
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RecipesScreen(
                      title: 'Recipes'); // Was const - will change
                }));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(700, 250),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 45,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.pink[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text("Recipes")),
        ],
      )),
    );
  }
}
