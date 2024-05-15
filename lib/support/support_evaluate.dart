import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/support/evaluate_task.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';
import 'package:inka_test/support/support_trainee_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SupportEvaluate extends StatefulWidget {
  SupportEvaluate(
      {super.key,
      required this.title,
      required this.trainee,
      required this.task,
      this.currentTasks});
  final String title;
  final Trainee trainee;
  Task task = Task(
      adminID: "e7bd6941-2f8f-4949-a4ed-6803cd2ab42b"); // Initialize task here
  //final Task task;

  List<CurrTask>? currentTasks = [];

  @override
  _SupportEvaluateState createState() => _SupportEvaluateState();
}

class _SupportEvaluateState extends State<SupportEvaluate> {
  final TextEditingController _textController = TextEditingController();
  late List<Task> allTasks = []; // List to store all tasks
  List<CurrTask> currentTasks = [];
  late Task selectedTask;
  late int timesEvaluated;
  //Map<String, int> completedSteps = {};

  @override
  void initState() {
    super.initState();
    fetchAllTask(); // Call the function to fetch all task
    fetchSelectedTask();
    selectedTask = widget.task; // Provide a default task if widget.task is null
    timesEvaluated = 0;

    // fetchCurrentTask(); // Call the function to fetch curr task
  }

  Future<void> updateCurrentTask(
      String newTaskTitle,
      List<String>? newTaskSteps,
      String newTraineeID,
      String? newTaskProgress,
      String? newCoverImage, 
      List<Sess>? newSessionList) async {
    try {
      if (selectedTask == null) {
        throw Exception('No selected task found');
      }

      final updatedTask = selectedTask.copyWith(
        taskTitle: newTaskTitle,
        taskSteps: newTaskSteps,
        traineeID: newTraineeID,
        sessionList: newSessionList,
        taskProgress: newTaskProgress,
        taskCoverImage: newCoverImage,
      );

      final request = ModelMutations.update(updatedTask);
      final response = await Amplify.API.mutate(request: request).response;

      // Check for errors in the mutation response
      if (response.errors.isNotEmpty) {
        throw Exception('Failed to update');
      }

      // Print the response for debugging purposes
      safePrint("Selected Task updated!");

      safePrint('Update response: $response');
    } catch (e) {
      // Handle any errors
      safePrint('Error updating selected task: $e');
    }
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

  // Function to fetch the current task
  Future<void> fetchCurrentTask() async {
    try {
      final currentTask = await queryCurrTask();
      if (currentTask.isNotEmpty) {
        setState(() {
          currentTasks = currentTask.cast<CurrTask>();
        });
      } else {
        safePrint('No current task found');
      }
    } catch (e) {
      print('Error fetching current task: $e');
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

  //query the current task
  Future<List<CurrTask?>> queryCurrTask() async {
    try {
      final request = ModelQueries.list(CurrTask.classType);
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

  // Bottom Bar Navigation
  int _selectedIndex = 1;
  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainee dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportTraineeDashboard(
                    trainee: widget.trainee, task: selectedTask)));
        break;
      case 1:
        // Navigate to evaluate screen
        final recievedTimesEvaluated = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportEvaluate(
                    title: "Evaluate",
                    trainee: widget.trainee,
                    task: selectedTask)));
        setState(() {
          // Update timesEvaluated with the value received from EvaluateTask
          timesEvaluated = recievedTimesEvaluated ?? 0;
        });
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportTraineeProfile(
                    title: 'Profile', trainee: widget.trainee)));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          // Change to notification icon once bottom bar navigation is sorted
          leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.notifications_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportNotifications(title: 'Notifications');
                }));
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

        // Bottom Bar
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_rounded),
              label: 'EVALUATE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'PROFILE',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),

        // List View of Evaluations
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(25),
                child: _buildEvaluateSearchBar(context)),
            Expanded(
                child: ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                final task = allTasks[index];
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedTask = task; // Set the selected task
                      safePrint(selectedTask);
                    });
                    await updateCurrentTask(
                        //updating task attributes here
                        selectedTask.taskTitle ?? '',
                        selectedTask.taskStep,
                        widget.trainee.id,
                        selectedTask.taskProgress,
                        selectedTask.taskCoverImage, selectedTask.sessionList);


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EvaluateTask(
                                  task: selectedTask,
                                  trainee: widget.trainee,
                                )));
                  },
                  child: _EvalCard(task),
                );
              },
            ))
          ],
        ));
  }

  // Search Bar
  Widget _buildEvaluateSearchBar(context) => TextField(
        controller: _textController,
        style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Evaluation",
          hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
        ),
      );

  Future<String> getDownloadUrl({
    required String key,
    required StorageAccessLevel accessLevel,
  }) async {
    try {
      final result = await Amplify.Storage.getUrl(
        key: key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 7),
          ),
        ),
      ).result;
      return result.url.toString();
    } on StorageException catch (e) {
      safePrint('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }

  Widget _EvalCard(Task task) => Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        //color: Color.fromARGB(255, 196, 155, 175),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: task.taskCoverImage != null
                    ? FutureBuilder<String>(
                        future: getDownloadUrl(
                            key: task.taskCoverImage!,
                            accessLevel: StorageAccessLevel.guest),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final imageUrl = snapshot.data!;
                            return CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            );
                          }
                        },
                      )
                    : Image.asset(
                        'assets/images/task_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            ListTile(
              title: Padding(
                padding: EdgeInsets.only(top: 100, bottom: 100),
                child: Text(
                  '${task.taskTitle}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  final List<EvaluateItem> mockEvals = [
    EvaluateItem(
        title: 'Dishes',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Do the dishes', 'Do the dishes', 'Do the dishes']),
    EvaluateItem(
        title: 'Clear Table',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: [
          'Clear the table',
          'Clear the table',
          'Clear the table'
        ]),
    EvaluateItem(
        title: 'Closing',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Close the cafe', 'Close the cafe', 'Close the cafe']),
    EvaluateItem(
        title: 'Orders',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Take an order', 'Take an order', 'Take an order']),
    EvaluateItem(
        title: 'Opening',
        assetImage: 'assets/images/task_placeholder.jpg',
        instructions: ['Open the cafe', 'Open the dishes', 'Open the dishes'])
  ];
}