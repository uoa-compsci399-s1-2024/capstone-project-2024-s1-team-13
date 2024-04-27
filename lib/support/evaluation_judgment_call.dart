import 'package:flutter/material.dart';
import 'package:inka_test/support/evaluation_notes.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationJudgmentCall extends StatelessWidget {
  const EvaluationJudgmentCall(
      {Key? key, required this.evaluation, required this.trainee})
      : super(key: key);
  final EvaluateItem evaluation;
  final TraineeItem trainee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(evaluation.title),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Question
              _judgementQuestion(),
              // Buttons
              _buttons(context)
            ],
          ),
        ));
  }

  // Question
  Widget _judgementQuestion() => Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
                '[Name] has successfully completed the evaluation.', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 45,
                    fontWeight: FontWeight.w500))),
        Padding(
            padding:
                EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 50),
            child: Text(
                'Do you think [Name] has passed?', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 35,
                    fontWeight: FontWeight.w400)))
      ]);

  // Buttons
  Widget _buttons(context) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            child: Text("YES"),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 100),
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                backgroundColor: Colors.pink[900],
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EvaluationNotes(
                    evaluation: evaluation, trainee: trainee);
              }));
            } // Temporary navigation
            ),
        SizedBox(width: 30),
        ElevatedButton(
            child: Text("NO"),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 100),
                foregroundColor: Colors.pink[900],
                textStyle: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Lexend Exa',
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: Colors.grey[300],
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EvaluationNotes(
                    evaluation: evaluation, trainee: trainee);
              }));
            } // Temporary navigation
            )
      ]);
}
