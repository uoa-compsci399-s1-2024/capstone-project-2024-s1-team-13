import 'package:flutter/material.dart';
import 'package:inka_test/support/evaluation_judgment_call.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationFeedback extends StatelessWidget {
  const EvaluationFeedback(
      {super.key, required this.evaluation, required this.trainee});
  final EvaluateItem evaluation;
  final TraineeItem trainee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(evaluation.title),
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
                  return const SupportSettings(title: 'Settings');
                }));
              },
              iconSize: 45,
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Question
              _feedbackQuestion(),
              // Feedback buttons
              const SizedBox(height: 50),
              _feedbackButtons(context),
              // Skip button
              const SizedBox(height: 50),
              _skipButton(context)
            ],
          ),
        ));
  }

  // Question
  Widget _feedbackQuestion() => const Padding(
      padding: EdgeInsets.only(left: 100, right: 100),
      child: Text('How do you feel about this task?',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 45,
              fontWeight: FontWeight.w500)));

  // Feedback Buttons  - from line 68 to 92
  Widget _feedbackButtons(context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(context, 'assets/images/very_bad_button.png'),
          _button(context, 'assets/images/bad_button.png'),
          _button(context, 'assets/images/not_so_good_button.png'),
          _button(context, 'assets/images/good_button.png'),
          _button(context, 'assets/images/very_good_button.png'),
        ],
      );

  // Helper for feedback buttons
  Widget _button(context, imagePath) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EvaluationJudgmentCall(
              evaluation: evaluation,
              trainee: trainee,
            );
          }));
        },
        child: Image.asset(imagePath,
            width: 125, height: 125, fit: BoxFit.contain),
      );

// Skip button
  Widget _skipButton(context) => TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationJudgmentCall(
              evaluation: evaluation, trainee: trainee);
        }));
      },
      child: Text(
        'Skip',
        style: TextStyle(
          fontFamily: 'Lexend Exa',
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.pink[900],
          decoration: TextDecoration.underline,
        ),
      ));
}
