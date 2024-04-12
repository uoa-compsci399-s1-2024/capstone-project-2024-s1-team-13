import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/support/evaluate_task.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';
import 'package:inka_test/support/support_items/trainee_item.dart';

class SupportEvaluate extends StatelessWidget {
  SupportEvaluate({Key? key, required this.title}) : super(key: key);
  final String title;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          // Change to notification icon once bottom bar navigation is sorted
          leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.arrow_back_ios_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
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
              icon: Icon(Icons.settings),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
          //currentIndex: _selectedIndex,
          //onTap: _onItemTapped,
        ),

        // List View of Evaluations
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(25),
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
                            builder: (context) =>
                                EvaluateTask(title: eval.title)));
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
          hintText: "Search Evaluation",
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

  // Evaluation Card
  Widget _EvalCard(eval) => Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Color.fromARGB(255, 196, 155, 175),
      child: ListTile(
          title: Padding(
              padding: EdgeInsets.only(top: 100, bottom: 100),
              child: Text('${eval.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)))));

  //Mock Data

  final List<EvaluateItem> mockEvals = [
    EvaluateItem(
        title: 'Dishes', assetImage: 'assets/images/task_placeholder.jpg'),
    EvaluateItem(
        title: 'Clear Table', assetImage: 'assets/images/task_placeholder.jpg'),
    EvaluateItem(
        title: 'Closing', assetImage: 'assets/images/task_placeholder.jpg'),
    EvaluateItem(
        title: 'Orders', assetImage: 'assets/images/task_placeholder.jpg'),
    EvaluateItem(
        title: 'Opening', assetImage: 'assets/images/task_placeholder.jpg')
  ];
}
