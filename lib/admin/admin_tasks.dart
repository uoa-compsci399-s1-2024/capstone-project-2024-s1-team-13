import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_edit_tasks.dart';
import 'package:inka_test/admin/admin_notifications.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_trainees.dart';
import 'package:inka_test/modules/module_items/task_item.dart';
import 'package:inka_test/modules/selected_task.dart';

class AdminTasksScreen extends StatefulWidget {
  const AdminTasksScreen({super.key, required this.title});
  final String title;

  @override
  _AdminTasksScreenState createState() => _AdminTasksScreenState();
}

class _AdminTasksScreenState extends State<AdminTasksScreen> {
  final TextEditingController _textController = TextEditingController();

  // Bottom Bar Navigation
  int _selectedIndex = 1;
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
                builder: (context) => const AdminTrainees(title: 'Trainees')));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to profile screen
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
              icon: const Icon(Icons.notifications_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminNotifications(title: 'Notifications');
                }));
              }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminEditTasks(title: 'Edit Tasks');
                }));
              },
              iconSize: 45,
              icon: const Icon(Icons.edit_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Bottom Navigation Bar -- needs working
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

        // Search

        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(25), child: _buildTaskSearchBar(context)),
          Expanded(
              child: GridView.builder(
                  itemCount:
                      mockTasks.length, //Placeholder list - backend pending.
                  itemBuilder: (context, index) {
                    final task =
                        mockTasks[index]; //Placeholder list - backend pending.
                    return GestureDetector(
                        onTap: () {
                          // Navigate to the desired screen when a task card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedTask(title: task.title, taskId: ""),
                            ),
                          );
                        },
                        child: _buildTaskCard(task));
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //crossAxisSpacing: 5,
                    //mainAxisSpacing: 5,
                  ),
                  scrollDirection: Axis.vertical))
        ]));
  }

  // Search Bar
  Widget _buildTaskSearchBar(context) => TextField(
        controller: _textController,
        style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: const EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Tasks",
          hintStyle: const TextStyle(
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

  // Task Card
  Widget _buildTaskCard(task) => Card(
      margin: const EdgeInsets.all(20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Image.asset(task.assetImage, fit: BoxFit.fill)),
          ),
          const SizedBox(height: 30),
          Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                task.title,
                style: const TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ))
        ],
      ));

  //Mock Data
  final List<TaskItem> mockTasks = [
    TaskItem(title: 'Dishes', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(
        title: 'Clear Table', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(
        title: 'Closing', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(title: 'Orders', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(title: 'Opening', assetImage: 'assets/images/task_placeholder.jpg')
  ];
}
