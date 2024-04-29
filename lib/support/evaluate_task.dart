import 'package:flutter/material.dart';
import 'package:inka_test/support/evaluation_feedback.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluateTask extends StatefulWidget {
  const EvaluateTask(
      {super.key, required this.evaluation, required this.trainee});
  final EvaluateItem evaluation;
  final TraineeItem trainee;

  @override
  _EvaluateTaskState createState() => _EvaluateTaskState();
}

class _EvaluateTaskState extends State<EvaluateTask> {
  // List to track the checked state of each item
  List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list with false values (unchecked)
    _isCheckedList =
        List<bool>.filled(widget.evaluation.instructions.length, false);
  }

//Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.evaluation.title),
          leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context); // Navigates to previous screen
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SupportSettings(
                      title: 'Settings'); // Navigates to support settings
                }));
              },
              iconSize: 45,
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Body of screen
        body: Column(
          children: <Widget>[
            _buildText(),

            // Checkbox List
            Expanded(
                child: ListView.builder(
              itemCount: widget.evaluation.instructions.length,
              itemBuilder: (context, index) {
                // Checkbox - should I make this a separate widget enable to change size?
                return CheckboxListTile(
                  title: Text(widget.evaluation.instructions[index],
                      style: const TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  value: _isCheckedList[index],
                  activeColor: Colors.grey[300],
                  checkColor: Colors.pink[900],
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity:
                      const VisualDensity(horizontal: 4.0, vertical: 4.0),
                  onChanged: (value) {
                    setState(() {
                      _isCheckedList[index] = value!;
                    });
                  },
                );
              },
            )),

            // Done Button
            _buildDoneButton(),

            const SizedBox(height: 50)
          ],
        ));
  }

  // 'Task Analysis' Widget
  Widget _buildText() => const Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        'Task Analysis',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Lexend Exa',
            fontSize: 60,
            fontWeight: FontWeight.w500),
      ));

  // Done Button
  Widget _buildDoneButton() => ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationFeedback(
              evaluation: widget.evaluation, trainee: widget.trainee);
        }));
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(500, 100),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 40,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.pink[900],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text("DONE"));
}
