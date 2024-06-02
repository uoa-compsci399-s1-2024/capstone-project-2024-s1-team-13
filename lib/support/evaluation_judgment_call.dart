import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/support/evaluation_notes.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationJudgmentCall extends StatefulWidget {
  const EvaluationJudgmentCall(
      {Key? key, required this.trainee, this.task})
      : super(key: key);
  final Trainee trainee;
  final Task? task;
  
    @override
  _EvaluationJudgmentCall createState() => _EvaluationJudgmentCall();
}

class _EvaluationJudgmentCall extends State<EvaluationJudgmentCall> {
  late Task selectedTask;

 void initState() {
    super.initState();
    selectedTask = widget.task!; // Provide a default task if widget.task is null
    fetchSelectedTask();
  }

  //BACKEND FUNCTIONS
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

    Future<void> updateTaskProgress(String newJudgementCall, String newTraineeID) async {
      try {
        final judgementCall = JudgementCall(
          taskID: selectedTask.id,
          traineeID: newTraineeID,
          call: newJudgementCall,
        );
        final request = ModelMutations.create(judgementCall);
        final response = await Amplify.API.mutate(request: request).response;
        if (response.errors.isNotEmpty) {
          throw Exception('Failed to update task progress');
        }
        safePrint("Judgement call updated!");
        safePrint('Update response: $response');
      } catch (e) {
        safePrint('Error updating task progress: $e');
      }
    }

  //FRONTEND
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedTask.taskTitle!),
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
                '${widget.trainee.firstName} has completed the evaluation.', 
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
                "What do you think was ${widget.trainee.firstName}'s overall accuracy?", 
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 35,
                    fontWeight: FontWeight.w400)))
      ]);

  // Buttons
  Widget _buttons(context) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _IndependentButton(context),
        SizedBox(width: 15),
        _VPButton(context),
        SizedBox(width: 15),
        _GPButton(context),
        SizedBox(width: 15),
        _PPButton(context),
        SizedBox(width: 15),
        _NCButton(context)
      ]);

// Independent
  Widget _IndependentButton(context) => ElevatedButton(
      onPressed: () {
      updateTaskProgress('I', widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationNotes(
              task: widget.task!, trainee: widget.trainee); // change parameters
        }));
      },
      child: Text("I"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 35,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color.fromARGB(255, 220, 180, 200),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));

// Verbal Prompt
  Widget _VPButton(context) => ElevatedButton(
      onPressed: () {
      updateTaskProgress('VP', widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationNotes(
               task: widget.task!, trainee: widget.trainee); // change parameters
        }));
      },
      child: Text("V"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 35,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color.fromARGB(255, 220, 180, 200),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));

// Gestural Prompt
  Widget _GPButton(context) => ElevatedButton(
      onPressed: () {
        updateTaskProgress('GP', widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationNotes(
               task: widget.task!, trainee: widget.trainee); // change parameters
        }));
      },
      child: Text("G"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 35,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color.fromARGB(255, 220, 180, 200),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));

// Physical Prompt
  Widget _PPButton(context) => ElevatedButton(
      onPressed: () {
        updateTaskProgress('P', widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationNotes(
               task: widget.task!, trainee: widget.trainee); // change parameters
        }));
      },
      child: Text("P"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 35,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color.fromARGB(255, 220, 180, 200),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));

// Not Completed
  Widget _NCButton(context) => ElevatedButton(
      onPressed: () {
          updateTaskProgress('NC', widget.trainee.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EvaluationNotes(
               task: widget.task!, trainee: widget.trainee); // change parameters
        }));
      },
      child: Text("NC"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 33,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color.fromARGB(255, 220, 180, 200),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
}
