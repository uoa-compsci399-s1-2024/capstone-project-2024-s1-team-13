import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_trainee.dart';
import 'package:inka_test/admin/admin_edit_trainees.dart';
import 'package:inka_test/admin/admin_notifications.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainee_profile.dart';
import 'package:inka_test/items/trainee_item.dart';

class AdminTrainees extends StatefulWidget {
  AdminTrainees({super.key, required this.title});
  final String title;

  @override
  _AdminTraineesState createState() => _AdminTraineesState();
}

class _AdminTraineesState extends State<AdminTrainees> {
  final TextEditingController _textController = TextEditingController();

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
                builder: (context) => AdminTrainees(title: 'Trainees')));
        break;
      case 1:
        // Navigate to tasks
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminTasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to recipes
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminRecipesScreen(title: 'Recipes')));
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
              icon: Icon(Icons.notifications_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminNotifications(title: 'Notifications');
                }));
              }),
          actions: [
            Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminAddTrainee(title: 'Add Trainee');
                  }));
                },
                // To add functionality to settings
                iconSize: 60,
                icon: Icon(Icons.add_rounded),
                padding: EdgeInsets.only(right: 30.0, bottom: 10.0),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminEditTrainees(title: 'Edit Trainees');
                  }));
                },
                // To add functionality to settings
                iconSize: 45,
                icon: Icon(Icons.edit_rounded),
                padding: EdgeInsets.only(right: 30.0, bottom: 10.0),
              )
            ])
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
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(25),
                child: _buildTraineeSearchBar(context)),
            Expanded(
                child: ListView.builder(
              itemCount: mockTrainees.length,
              itemBuilder: (context, index) {
                final trainee = mockTrainees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminTraineeProfile(
                                title: 'Profile', trainee: trainee)));
                  },
                  child: _TraineeCard(trainee),
                );
              },
            ))
          ],
        ));
  }

  // Search Bar
  Widget _buildTraineeSearchBar(context) => TextField(
        controller: _textController,
        style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Trainees",
          hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
        ),
      );

  // Trainee Card
  Widget _TraineeCard(trainee) => Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(

          // Avatar containg image - set as leading for Card instance, needs fixing
          leading: CircleAvatar(
              foregroundImage: AssetImage(trainee.assetImage), radius: 50),
          title: Padding(
              padding: EdgeInsets.only(top: 100, bottom: 100),
              child: Text('${trainee.firstName} ${trainee.lastName}',
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 40,
                      fontWeight: FontWeight.w500)))));

  //Mock Data
  final List<TraineeItem> mockTrainees = [
    TraineeItem(
        firstName: 'John',
        lastName: 'Doe',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Tom',
        lastName: 'Stevens',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Clark',
        lastName: 'Johnson',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Sam',
        lastName: 'Wood',
        assetImage: 'assets/images/trainee_placeholder.jpeg')
  ];
}
