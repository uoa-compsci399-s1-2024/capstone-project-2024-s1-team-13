import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/items/progress_item.dart';


import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/items/progress_item.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_settings.dart';

//adding trainee object required

class AdminTraineeProgress extends StatefulWidget {
  const AdminTraineeProgress(
      {super.key, required this.title, required this.trainee});
  final String title;
  final Trainee trainee;

  @override
  @override
  _AdminTraineeProgress createState() => _AdminTraineeProgress();
}

class _AdminTraineeProgress extends State<AdminTraineeProgress> {
  late List<Task> allTasks = []; // List to store all tasks
  final String title = '';
  List<CurrTask>? currentTasks = [];
  TaskNotes taskNote = TaskNotes();
  late Trainee selectedTrainee;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchAllData();

  }

   Future<void> fetchAllData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating fetch delay
    await fetchCurrentTask();
    await fetchAllTask();
    await fetchLatestTaskNote(currentTasks!);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchSelectedTrainee() async {
    try {
      final trainee = await queryTraineeById(
          widget.trainee!.id); // Query for the trainee by ID

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

  Future<void> fetchCurrentTask() async {
    try {
      final currentTask = await queryCurrTask(widget.trainee.id);
      if (currentTask.isNotEmpty) {
        setState(() {
          currentTasks = currentTask.cast<CurrTask>();
          fetchLatestTaskNote(currentTasks!); // Fetch latest task note
        });
      } else {
        safePrint('No current task found');
      }
    } catch (e) {
      print('Error fetching current task: $e');
    }
  }

  //query the current task
  Future<List<CurrTask?>> queryCurrTask(String traineeID) async {
    try {
      final request = ModelQueries.list(CurrTask.classType,
          where: CurrTask.TRAINEEID.eq(traineeID));
      final response = await Amplify.API.query(request: request).response;
      //safePrint('List of all the Task Notes:', response);
      safePrint('Testing!');

      final currTask = response.data?.items;
      safePrint(currTask);
      if (currTask == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return currTask;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<List<TaskNotes?>> queryTaskNoteListItem(
      String traineeID, CurrTask? currentTask) async {
    try {
      final request = ModelQueries.list(TaskNotes.classType,
          where: TaskNotes.TRAINEEID.eq(traineeID));
      final response = await Amplify.API.query(request: request).response;

      final taskNotes = response.data?.items;
      if (taskNotes == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return taskNotes;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  // Function to fetch the latest task note
  Future<void> fetchLatestTaskNote(List<CurrTask?> currentTasks) async {
  try {
    if (currentTasks.isNotEmpty) {
      final List<TaskNotes?> taskNotes = await queryTaskNoteListItem(widget.trainee.id, currentTasks.last!);
      if (taskNotes.isNotEmpty) {
        taskNotes.sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
        setState(() {
          taskNote = taskNotes.first!;
        });
      } else {
        safePrint('No task notes found for the current task');
      }
    } else {
      safePrint('No current tasks to fetch notes for');
    }
  } catch (e) {
    print('Error fetching task note: $e');
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

  // Function to fetch all task
  Future<void> fetchAllTask() async {
    try {
      final task = await queryTask();

      setState(() {
        allTasks = task.cast<Task>();
      });
    } catch (e) {
      print('Error fetching task: $e');
    }
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminSettings(title: 'Settings');
                }));
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    final task = allTasks[index];
                    final currTask = currentTasks?.firstWhereOrNull(
                        (currTask) => currTask.currTaskName == task.taskTitle);
                    return _ProgressCard(task, currTask);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }


  // Widgets

  // Method to build widgets for tasks
  Widget _buildTaskWidget(Task task) {
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            task.taskTitle ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          // return _ProgressCard(context, progress);        ),
        ),
      ),
    );
  }
Widget _ProgressCard(Task task, CurrTask? currTask) {
    double percentage = double.parse(currentTasks!.last.taskProgress!.replaceAll('%', ''));
  double actualPercentage = percentage / 100;
  if (currTask != null) {
    // If there is a corresponding CurrTask object
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            task.taskTitle ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${currTask.taskProgress} Completed',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              LinearProgressIndicator(
                value: actualPercentage!, // / 100,
                borderRadius: BorderRadius.circular(50),
                minHeight: 30,
                backgroundColor: Colors.grey[350],
                color: Colors.pink[900]
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Times Evaluated: ',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    TextSpan(
                      text: '${currTask.timesEvaluated}',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink[900]
                      ),
                    )
                  ]
                ),
              ),
              SizedBox(height: 20),
              // Display recent feedback here
              Text('Recent Feedback: ${currTask.taskFeeling}',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    // If there is no corresponding CurrTask object
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            task.taskTitle ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: Text('No progress available for this task.',
            style: TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}

// Mock Data

  final List<ProgressItem> mockProgress = [
    ProgressItem('Closing Evaluation', 0.45, 3, 'Good',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
    ProgressItem('Dishes Evaluation', 0.7, 2, 'Very Good',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
  ];
}