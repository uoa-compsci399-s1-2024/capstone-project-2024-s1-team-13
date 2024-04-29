import 'package:flutter/material.dart';
import 'package:inka_test/support/evaluate_task.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';
import 'package:inka_test/support/support_trainee_profile.dart';

class SupportEvaluate extends StatefulWidget {
  const SupportEvaluate({super.key, required this.title, required this.trainee});
  final String title;
  final TraineeItem trainee;

  @override
  _SupportEvaluateState createState() => _SupportEvaluateState();
}

class _SupportEvaluateState extends State<SupportEvaluate> {
  final TextEditingController _textController = TextEditingController();

  // Bottom Bar Navigation
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainee dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SupportTraineeDashboard(trainee: widget.trainee)));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportEvaluate(
                      title: "Evaluate",
                      trainee: widget.trainee,
                    )));
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportTraineeProfile(
                    title: 'Profile', trainee: widget.trainee)));
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
          // Change to notification icon once bottom bar navigation is sorted
          leading: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.notifications_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
              },
              // To add functionality to settings
              iconSize: 45,
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Bottom Bar
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),

        // List View of Evaluations
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(25),
                child: _buildEvaluateSearchBar(context)),
            Expanded(
                child: ListView.builder(
              itemCount: mockEvals.length,
              itemBuilder: (context, index) {
                final eval = mockEvals[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EvaluateTask(
                                evaluation: eval, trainee: widget.trainee)));
                  },
                  child: _EvalCard(eval),
                );
              },
            ))
          ],
        ));
  }

  // Search Bar
  Widget _buildEvaluateSearchBar(context) => TextField(
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
          hintText: "Search Evaluation",
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

  // Evaluation Card
  Widget _EvalCard(eval) => Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: const Color.fromARGB(255, 196, 155, 175),
      child: ListTile(
          title: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 100),
              child: Text('${eval.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)))));

  //Mock Data

  final List<EvaluateItem> mockEvals = [
    EvaluateItem(
        title: 'Dishes',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Do the dishes', 'Do the dishes', 'Do the dishes']),
    EvaluateItem(
        title: 'Clear Table',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: [
          'Clear the table',
          'Clear the table',
          'Clear the table'
        ]),
    EvaluateItem(
        title: 'Closing',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Close the cafe', 'Close the cafe', 'Close the cafe']),
    EvaluateItem(
        title: 'Orders',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Take an order', 'Take an order', 'Take an order']),
    EvaluateItem(
        title: 'Opening',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Open the cafe', 'Open the dishes', 'Open the dishes'])
  ];
}
