import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/evaluation_notes.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationJudgmentCall extends StatefulWidget {
   EvaluationJudgmentCall(
      {Key? key, required this.task, required this.trainee, this.currentTasks})
      : super(key: key);
  //final EvaluateItem evaluation;
  final Task task;
  final Trainee trainee;
  List<CurrTask>? currentTasks = [];



  @override
  _EvaluationJudgmentCall createState() => _EvaluationJudgmentCall();
}

class _EvaluationJudgmentCall extends State<EvaluationJudgmentCall> {
  List<CurrTask> currentTasks = [];

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
      final currentTask = await queryCurrTask();

      setState(() {
        currentTasks = currentTask;
        //safePrint(CurrentTasks);
      });
    } catch (e) {
      print('Error fetching current task: $e');
    }
  }

  Future<void> updateTaskProgress(
      CurrTask currentTask, String newTaskProgress, String newTraineeID) async {
    final updatedTask = currentTask.copyWith(taskProgress: newTaskProgress, traineeID: newTraineeID);

    final request = ModelMutations.update(updatedTask);
    final response = await Amplify.API.mutate(request: request).response;

    // Check for errors in the mutation response

    if (response.errors.isNotEmpty) {
      throw Exception('Failed to update task progress');
    }

    // Print the response for debugging purposes
    safePrint("Current Task updated!");
    safePrint('Update response: $response');

    // Print the response for debugging purposes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.task.taskTitle ?? ''),
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
                '${widget.trainee.firstName} has successfully completed the evaluation.', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
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
                'Do you think ${widget.trainee.firstName} has passed?', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
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
              updateTaskProgress(currentTasks.last, '100%', widget.trainee.id);

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EvaluationNotes(
                    task: widget.task, trainee: widget.trainee);
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
  if (currentTasks.isNotEmpty) {
    final taskStepsCount = currentTasks.last.taskSteps!.length;
    final taskStepsCheckedCount = currentTasks.last.checkedStepsCount!;
    final newTaskProgress = '${((taskStepsCheckedCount / taskStepsCount) * 100).round()}%';

    updateTaskProgress(currentTasks.last, newTaskProgress, widget.trainee.id);
  } else {
    print('Error: currentTasks is empty.');
    // Handle the case where currentTasks is empty
  }

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return EvaluationNotes(
        task: widget.task, trainee: widget.trainee);
  }));
}
            )
      ]);
}