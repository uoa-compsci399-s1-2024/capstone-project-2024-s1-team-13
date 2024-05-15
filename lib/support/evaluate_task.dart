import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/evaluation_feedback.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluateTask extends StatefulWidget {
  const EvaluateTask({
    Key? key,
    required this.task,
    required this.trainee,
  }) : super(key: key);
  //final EvaluateItem evaluation;
  final Trainee trainee;
  final Task task;
  @override
  _EvaluateTaskState createState() => _EvaluateTaskState();
}

class _EvaluateTaskState extends State<EvaluateTask> {
  late Trainee selectedTrainee;
  late List<Task> allTasks = []; // List to store all tasks
  late String traineeID = widget.trainee.id; // Get the selected trainee's ID
  late Task selectedTask;

  @override
  void didUpdateWidget(EvaluateTask oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trainee.id != widget.trainee.id) {
      setState(() {
        traineeID = widget.trainee.id;
      });
    }
  }

  void initState() {
    super.initState();
    traineeID = widget.trainee.id;
    fetchSelectedTrainee();
    fetchSelectedTask();
    selectedTask = widget.task;
    _isCheckedList =
        List<bool>.filled(widget.task.taskStep?.length ?? 0, false);
  }

  Future<void> fetchSelectedTask() async {
    try {
      final task = await queryTaskByID(widget.task.id);
      if (task != null) {
        setState(() {
          safePrint("TASK");
          selectedTask = task;
        });
      } else {
        safePrint('Selected task not found');
      }
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
  }

  Future<Task?> queryTaskByID(String taskID) async {
    try {
      final request = ModelQueries.get(
          Task.classType,
          TaskModelIdentifier(
              id: taskID)); // Use ModelQuery.get to fetch a single task by ID
      final response = await Amplify.API.query(request: request).response;

      final task = response.data;
      if (task == null) {
        safePrint('errors: ${response.errors}');
      }
      return task;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  Future<void> fetchSelectedTrainee() async {
    try {
      final trainee = await queryTraineeById(
          widget.trainee.id); // Query for the trainee by ID

      setState(() {
        selectedTrainee = trainee!; // Store the selected trainee in the state
      });
    } catch (e) {
      safePrint('Error fetching selected trainee: $e');
    }
  }

  Future<Trainee?> queryTraineeById(String traineeID) async {
    try {
      final request = ModelQueries.get(
          Trainee.classType,
          TraineeModelIdentifier(
              id: traineeID)); // Use ModelQuery.get to fetch a single task by ID
      final response = await Amplify.API.query(request: request).response;

      final trainee = response.data;
      if (trainee == null) {
        safePrint('errors: ${response.errors}');
      }
      return trainee;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  

  Future<void> updateSelectedTask(
      List<bool> isCheckedList, String newTraineeID) async {
    try {
      int checkedStepsCount = 0;

      // Loop through each task step and increment checkedStepsCount if it's checked
      for (int i = 0; i < isCheckedList.length; i++) {
        if (isCheckedList[i]) {
          checkedStepsCount++;
        }
      }

      final updatedTask = selectedTask.copyWith(
          checkedStepsCount: checkedStepsCount, traineeID: widget.trainee.id);

      // Perform the update mutation
      final request = ModelMutations.update(updatedTask);
      final response = await Amplify.API.mutate(request: request).response;

      // Check for errors in the mutation response
      if (response.errors.isNotEmpty) {
        throw Exception('Failed to update');
      }

      // Print the response for debugging purposes
      safePrint("Selected Task updated!");
      safePrint("Checked Steps Count: $checkedStepsCount");
      safePrint('Update response: $response');
    } catch (e) {
      // Handle any errors
      safePrint('Error updating selected task steps count and trainee ID: $e');
    }
  }

  // Function to fetch all task
  Future<void> fetchAllTask() async {
    try {
      final task = await queryTask();

      setState(() {
        allTasks = task.cast<Task>();
      });
    } catch (e) {
      print('Error fetching task notes: $e');
    }
  }

  

  // Function to query all task
  Future<List<Task>> queryTask() async {
    try {
      final request = ModelQueries.list(Task.classType);
      final response = await Amplify.API.query(request: request).response;

      final task = response.data?.items;
      if (task == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return task.cast<Task>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  // List to track the checked state of each item
  List<bool> _isCheckedList = [];

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
            Navigator.pop(context); // Navigates to previous screen
          },
        ),
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
      body: Column(
        children: <Widget>[
          _buildText(),

          // Checkbox List
          Expanded(
            child: ListView.builder(
              itemCount: widget.task.taskStep?.length ?? 0,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    widget.task.taskStep![index],
                    style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: _isCheckedList[index],
                  activeColor: Colors.grey[300],
                  checkColor: Colors.pink[900],
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity:
                      const VisualDensity(horizontal: 4.0, vertical: 4.0),
                  onChanged: (value) async {
                    setState(() {
                      _isCheckedList[index] = value!;
                    });

                    await updateSelectedTask(_isCheckedList, widget.trainee.id);
                  },
                );
              },
            ),
          ),

          // Done Button
          _buildDoneButton(),

          SizedBox(height: 50),
        ],
      ),
    );
  }

  // 'Task Analysis' Widget
  Widget _buildText() => Padding(
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
          return EvaluationFeedback(task: widget.task, trainee: widget.trainee);
        }));
      },
      child: Text("DONE"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(500, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 40,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.pink[900],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
}