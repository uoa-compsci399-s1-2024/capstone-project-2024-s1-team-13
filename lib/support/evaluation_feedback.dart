import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/evaluation_judgment_call.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationFeedback extends StatefulWidget {
  EvaluationFeedback(
      {Key? key, required this.task, required this.trainee, this.currentTasks})
      : super(key: key);

  //final EvaluateItem evaluation;
  final Task task;
  final Trainee trainee;
  List<CurrTask>? currentTasks = [];


  @override
  _EvaluationFeedback createState() => _EvaluationFeedback();
}

class _EvaluationFeedback extends State<EvaluationFeedback> {
  //String generalNote = '';
  List<CurrTask> CurrentTasks = [];

  @override
  void initState() {
    super.initState();
    fetchCurrentTask(); // Call the function to fetch curr task
  }

  Future<List<CurrTask>> queryCurrTask() async {
    try {
      final request = ModelQueries.list(CurrTask.classType);
      final response = await Amplify.API.query(request: request).response;

      final currTask = response.data?.items;
      if (currTask == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return currTask.cast<CurrTask>();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  // Function to fetch the current task
  Future<void> fetchCurrentTask() async {
    try {
      final currentTasks = await queryCurrTask();

      setState(() {
        CurrentTasks = currentTasks;
        //safePrint(CurrentTasks);
      });
    } catch (e) {
      print('Error fetching current task: $e');
    }
  }

  Future<void> updateTaskFeeling(
      List<CurrTask> currentTask, String newFeeling, String newTraineeID) async {
    try {
      if (currentTask.isEmpty) {
        throw Exception('No current task found');
      }

      final updatedTask = currentTask.last.copyWith(taskFeeling: newFeeling, traineeID: newTraineeID);

      final request = ModelMutations.update(updatedTask);
      final response = await Amplify.API.mutate(request: request).response;

      // Check for errors in the mutation response
      if (response.errors.isNotEmpty) {
        throw Exception('Failed to update task feeling');
      }

      // Print the response for debugging purposes
      safePrint('Update response: $response');
    } catch (e) {
      // Handle any errors
      safePrint('Error updating task feeling: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.task.taskTitle}"),
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
              _feedbackQuestion(),
              // Feedback buttons
              SizedBox(height: 50),
              _feedbackButtons(context),
              // Skip button
              SizedBox(height: 50),
              _skipButton(context)
            ],
          ),
        ));
  }

  // Question
  Widget _feedbackQuestion() => Padding(
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
          _button(context, 'assets/images/very_bad_button.png', "Very Bad"),
          _button(context, 'assets/images/bad_button.png', "Bad"),
          _button(
              context, 'assets/images/not_so_good_button.png', "Not So Good"),
          _button(context, 'assets/images/good_button.png', "Good"),
          _button(context, 'assets/images/very_good_button.png', "Very Good"),
        ],
      );

  // Helper for feedback buttons
  Widget _button(context, imagePath, feeling) => GestureDetector(
        onTap: () {
          updateTaskFeeling(CurrentTasks, feeling, widget.trainee.id);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EvaluationJudgmentCall(
              task: widget.task,
              trainee: widget.trainee,
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
            task: widget.task,
            trainee: widget.trainee,
            currentTasks: widget.currentTasks
          );
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
