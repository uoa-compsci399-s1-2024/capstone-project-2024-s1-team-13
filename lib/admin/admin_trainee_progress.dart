import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_selected_progress.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/Session.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';

//adding trainee object required

class AdminTraineeProgress extends StatefulWidget {
  AdminTraineeProgress(
      {Key? key,
      required this.title,
      required this.trainee,
      required this.task})
      : super(key: key);
  final String title;
  final Trainee trainee;
  final Task task;

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
  late Task selectedTask;

  void initState() {
    super.initState();
    fetchAllTask(); // Call the function to fetch all task

    fetchSelectedTask();
    selectedTask = widget.task!;
  }

  Future<void> fetchSelectedTask() async {
    try {
      final task = await queryTaskByID(widget.task!.id);
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
      safePrint("Query for evaluation notes screen sucessful");
      return task;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  // Function to fetch all tasks
  Future<void> fetchAllTask() async {
    try {
      setState(() {
        isLoading = true; // Set loading state to true while fetching tasks
      });

      final task = await queryTask();

      setState(() {
        allTasks = task.cast<Task>();
        isLoading = false; // Set loading state to false after fetching tasks
        print('Fetched tasks: $allTasks');
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading state to false if an error occurs
      });
      print('Error fetching tasks: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress"),
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
                return const AdminSettings(title: 'Settings');
              }));
            },
            // To add functionality to settings
            iconSize: 45,
            icon: Icon(Icons.settings),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              // Display a loading indicator while fetching tasks
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: allTasks.length,
                      itemBuilder: (context, index) {
                        final task = allTasks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminSelectedProgress(
                                  title: task.taskTitle!,
                                  task: task,
                                  trainee: widget.trainee,
                                ),
                              ),
                            );
                          },
                          child: _ProgressCard(task),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // Widget to display progress card
  Widget _ProgressCard(Task task) => Card(
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              '${task.taskTitle}',
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
            child: _buildProgress(task),
          ),
        ),
      );

  // Widget to build progress information
  Widget _buildProgress(Task task) {
    return FutureBuilder<List<Session>?>(
      future: querySession(task.id, widget.trainee.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No progress available');
        } else {
          final sessions = snapshot.data!;
          // Sort sessions by createdAt in descending order to get the latest one
          sessions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          final latestSession = sessions.first;

          final feedback = latestSession.sessionList![0].aSess![1] ??
              'No feedback available';
          final judgementCall = latestSession.sessionList![0].aSess![2];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Judgment Call: ',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '$judgementCall',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Recent Feedback: ',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '$feedback',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink[900],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  //QUERY ALL THE SESSIONS FOR THE TRAINEE
  // QUERY ALL THE SESSIONS FOR THE TRAINEE AND SELECTED TASK
  Future<List<Session>?> querySession(String taskID, String traineeID) async {
    try {
      final request = ModelQueries.list(
        Session.classType,
        where: Session.TRAINEEID.eq(traineeID) & Session.TASKID.eq(taskID),
      );
      final response = await Amplify.API.query(request: request).response;

      final session = response.data?.items;
      if (session == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        session.sort((a, b) {
          if (a == null ||
              a.createdAt == null ||
              b == null ||
              b.createdAt == null) {
            return 0; // Handle null values
          }
          return a.createdAt!.compareTo(b.createdAt!);
        });
        // Sort sessions by createdAt in ascending order
      }

      return session?.cast<Session>();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }
}
