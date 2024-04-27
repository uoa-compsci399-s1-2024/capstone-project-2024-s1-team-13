import 'package:flutter/material.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluateTask extends StatelessWidget {
  const EvaluateTask({
    Key? key,
    required this.title,
    /*required this.evaluation*/
  }) : super(key: key);
  final String title;
  //final EvaluateItem evaluation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: Icon(Icons.arrow_back_ios),
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
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }

  // Widget for checklist
  //Widget _buildCheckList () =>
}
