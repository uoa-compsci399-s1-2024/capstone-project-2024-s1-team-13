import 'package:flutter/material.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeProfile extends StatelessWidget {
  const SupportTraineeProfile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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

      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SupportTraineeProgress(title: 'Progress');
            }));
          },
          child: const Text('Progress'),
        ),
      ),
    );
  }
}
