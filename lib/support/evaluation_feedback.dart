import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/TaskFeeling.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/evaluation_judgment_call.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationFeedback extends StatefulWidget {
  EvaluationFeedback(
      {Key? key, required this.task, required this.trainee})
      : super(key: key);

  final Task task;
  final Trainee trainee;

  @override
  _EvaluationFeedback createState() => _EvaluationFeedback();
}

class _EvaluationFeedback extends State<EvaluationFeedback> {
  late Task selectedTask;

  @override
  void initState() {
    super.initState();
    selectedTask = widget.task!; // Provide a default task if widget.task is null
    fetchSelectedTask();
  }

  Future<void> fetchSelectedTask() async {
    try {
      final task = await querySelectedTask(widget.task!.id, widget.trainee.id);

      if (task != null) {
        setState(() {
          selectedTask = task;
        });
      } else {
        safePrint('Selected task not found');
      }
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
  }

  Future<Task?> querySelectedTask(String taskID, String traineeID) async {
    try {
      final request = ModelQueries.list(Task.classType,
          where: Task.TRAINEEID.eq(traineeID) & Task.ID.eq(taskID));
      final response = await Amplify.API.query(request: request).response;

      final tasks = response.data?.items;
      if (tasks == null || tasks.isEmpty) {
        safePrint('Task not found');
        return null;
      }

      return tasks[0];
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  Future<void> updateTaskFeeling(String newTaskFeeling, String newTraineeID) async {
    try {
      final taskFeeling = TaskFeeling(
        taskID: selectedTask.id,
        traineeID: newTraineeID,
        feeling: newTaskFeeling,
      );

      final request = ModelMutations.create(taskFeeling);
      final response = await Amplify.API.mutate(request: request).response;

      if (response.errors.isNotEmpty) {
        throw Exception('Failed to update task feeling');
      }

      safePrint("Task Feeling call updated!");
      safePrint('Update response: $response');
    } catch (e) {
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
              _feedbackQuestion(),
              SizedBox(height: 50),
              _feedbackButtons(context),
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

  
  Widget _feedbackButtons(context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(context, 'assets/images/very_bad_button.png', "Very Bad"),
          _button(context, 'assets/images/bad_button.png', "Bad"),
          _button(context, 'assets/images/not_so_good_button.png', "Not So Good"),
          _button(context, 'assets/images/good_button.png', "Good"),
          _button(context, 'assets/images/very_good_button.png', "Very Good"),
        ],
      );

  // Helper for feedback buttons
  Widget _button(context, imagePath, feeling) => GestureDetector(
    onTap: () {
      updateTaskFeeling(feeling, widget.trainee.id); // Pass widget.trainee.id as the trainee ID
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
        updateTaskFeeling("skipped", widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationJudgmentCall(
              task: widget.task,
              trainee: widget.trainee,);
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