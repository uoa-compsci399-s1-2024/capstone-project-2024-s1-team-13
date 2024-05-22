// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/support/support_trainee_notes.dart';
import 'package:inka_test/support/support_trainee_profile.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

//will get rid of selected task after

class SupportTraineeDashboard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables

  SupportTraineeDashboard({super.key, required this.trainee, this.task});
  Trainee trainee;
  final Task? task;

  @override
  _SupportTraineeDashboardState createState() =>
      _SupportTraineeDashboardState();
}

class _SupportTraineeDashboardState extends State<SupportTraineeDashboard> {
  final TextEditingController _traineeNotesController = TextEditingController();

  bool isEditing = false;

  Task? selectedTask;

  String generalNote = '';
  late Trainee selectedTrainee;

  // Provide a default task if widget.task is null;
  List<CurrTask>? currentTasks = [];
  TaskNotes taskNote = TaskNotes();
  bool isLoading = true;
  late List<Task> allTasks = []; // List to store all tasks

  @override
  void initState() {
    selectedTask = widget.task ??
        Task(
            adminID:
                "e7bd6941-2f8f-4949-a4ed-6803cd2ab42b"); // Provide a default task if widget.task is null
    super.initState();
    fetchAllData();
    fetchLatestTaskForTrainee();
    _traineeNotesController.text = widget.trainee.traineeNote ?? '';
  }

  // Function to fetch all task
  Future<void> fetchAllData() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating fetch delay
    await fetchAllTask();
    //await fetchSelectedTask();
    await fetchLatestTaskForTrainee(); // Fetch the most recently accessed task
    await fetchLatestTaskNote(allTasks!);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchLatestTaskForTrainee() async {
    try {
      // Query latest task for the trainee
      final Task? latestTask =
          await queryLatestTaskForTrainee(widget.trainee.id);
      if (latestTask != null) {
        // Update selectedTask with the latest task
        setState(() {
          selectedTask = latestTask;
          safePrint("selected task set");
          safePrint(selectedTask);
        });
      } else {
        // Handle case where no task is found
        safePrint('Latest task for trainee not found');
      }
    } catch (e) {
      // Handle any errors
      safePrint('Error fetching latest task for trainee: $e');
    }
  }

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

  Future<Task?> queryLatestTaskForTrainee(String traineeID) async {
    try {
      final request = ModelQueries.list(Task.classType,
          where: Task.TRAINEEID.eq(traineeID));
      final response = await Amplify.API.query(request: request).response;

      final tasks = response.data?.items;
      if (tasks == null || tasks.isEmpty) {
        // Handle case where no tasks are found
        safePrint('No tasks found for trainee: $traineeID');
        return null;
      }

      // Sort tasks based on updated time date in descending order
      tasks.sort((a, b) {
        final updatedAtA = (a as Task).updatedAt;
        final updatedAtB = (b as Task).updatedAt;
        if (updatedAtA == null || updatedAtB == null) {
          return 0;
        }

        return updatedAtB.compareTo(updatedAtA);
      });

      // Return the first (most recent) task
      return tasks.first as Task;
    } catch (e) {
      // Handle any errors
      safePrint('Query failed: $e');
      return null;
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
      safePrint("Query for dashboard screen sucessful");
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

  Future<List<TaskNotes?>> queryTaskNoteListItem(String traineeID) async {
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
  Future<void> fetchLatestTaskNote(List<Task?> allTasks) async {
    try {
      if (selectedTask != null) {
        final List<TaskNotes?> taskNotes =
            await queryTaskNoteListItem(widget.trainee.id);
        if (taskNotes.isNotEmpty) {
          taskNotes.sort((a, b) => b!.createdAt!
              .compareTo(a!.createdAt!)); //to show latest task note
          setState(() {
            taskNote = taskNotes.first!;
          });
        }
      }
    } catch (e) {
      safePrint("Error fetching task notes");
      // Handle any errors
    }
  }

// Bottom Bar Navigation
  int _selectedIndex = 0;
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
                      trainee: widget.trainee,
                      task: selectedTask,
                    )));
        break;
      case 1:
        final updatedTask = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SupportEvaluate(
              title: "Evaluate ${widget.trainee.firstName}",
              trainee: widget.trainee,
              task: selectedTask!,
            ),
          ),
        );

        if (updatedTask != null) {
          setState(() {
            selectedTask = updatedTask;
          });
        }
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
    if (selectedTask == null || isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 250,
            child:
                SvgPicture.asset('assets/images/inka.svg', color: Colors.white),
          ),
          automaticallyImplyLeading: false,
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
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(), // Add this line to enable scrolling even when there's not enough content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 45, left: 50, right: 50, bottom: 10),
                  child: Text(
                    "${widget.trainee.firstName}'s Summary",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, bottom: 10),
                  child: Text(
                    "Progress",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[900],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 20, bottom: 20),
                  child: _buildProgressCard(
                    context,
                    selectedTask != null ? selectedTask!.taskProgress : '0.0',
                    selectedTask != null
                        ? selectedTask!.taskTitle ?? "No Current Task"
                        : "No Current Task",
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "Notes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[900],
                    ),
                  ),
                ),
                _traineeNoteCard(context, "Trainee Note"),
                SizedBox(height: 15),
                _taskNotes(context, generalNote),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> _refreshData() async {
    //await fetchSelectedTask();
    await fetchLatestTaskForTrainee();
    // If current task is available, fetch task note based on it
    if (selectedTask != null) {
      await fetchLatestTaskNote(allTasks);
    }
    await fetchSelectedTrainee();
  }

  // Trainee Notes Card
  Widget _traineeNoteCard(BuildContext context, String title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: isEditing
                            ? Icon(Icons.check,
                                size: 35) // Change to tick icon in edit mode
                            : Icon(
                                Icons.edit,
                                size: 35,
                              ), // Default to edit icon
                        onPressed: () async {
                          if (isEditing) {
                            setState(() {
                              isEditing = false; // Exit editing mode
                              // Update trainee note in widget
                              widget.trainee = widget.trainee.copyWith(
                                traineeNote: _traineeNotesController.text,
                              );
                            });
                            // Update the UI immediately with the edited note
                            await updateTraineeNote(
                                _traineeNotesController.text);
                          } else {
                            setState(() {
                              isEditing = true; // Enter editing mode
                              // Populate the text field with existing note if not empty
                              _traineeNotesController.text =
                                  widget.trainee.traineeNote ?? '';
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: isEditing
                        ? TextField(
                            controller: _traineeNotesController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter your note...',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Lexend Exa',
                                fontWeight: FontWeight.w500,
                                color: Colors.pink[900]),
                          )
                        : Text(
                            // Display the trainee note if available, otherwise show default text
                            widget.trainee.traineeNote != null &&
                                    widget.trainee.traineeNote!.isNotEmpty
                                ? widget.trainee.traineeNote!
                                : 'Enter your note...',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend Exa',
                              fontWeight: FontWeight.w500,
                              color: Colors.pink[900],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateTraineeNote(String trainee_note) async {
    final originalTraineeNote = widget.trainee.traineeNote;
    final updatedTraineeNote =
        trainee_note.isNotEmpty ? trainee_note : originalTraineeNote;

    final updatedTrainee = widget.trainee.copyWith(
      traineeNote: updatedTraineeNote,
    );

    final request =
        ModelMutations.update(updatedTrainee); // Pass updatedTrainee here
    try {
      final response = await Amplify.API.mutate(request: request).response;
      print('Response: $response');
    } catch (e) {
      print('Error updating trainee note: $e');
    }
  }

  // Recent Notes
  Widget _taskNotes(BuildContext context, note) => Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SupportTraineeNotes(
                title: 'Notes',
                trainee: widget.trainee,
              );
            }));
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 190, // Start with a fixed height
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 50, right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Notes',
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          "Latest Note: ${taskNote.taskTitle != null ? '${taskNote.taskTitle}\n' : ''}${taskNote.taskDesc ?? 'No Note'}", // Display the fetched note here
                          style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink[900],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

  // Recent Progress
  // Inside _buildProgressCard method -- NOT USING PROGRESS
  Widget _buildProgressCard(BuildContext context, progress, currentTaskTitle) =>
      Center(
        child: GestureDetector(
          onTap: () {
            if (selectedTask != null && selectedTask!.taskCoverImage != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SupportTraineeProgress(
                    title: 'Progress',
                    trainee: widget.trainee,
                    task: selectedTask!);
              }));
            }
          },
          child: selectedTask != null && selectedTask!.taskCoverImage != null
              ? FutureBuilder<String>(
                  future: getDownloadUrl(
                    key: selectedTask!.taskCoverImage!,
                    accessLevel: StorageAccessLevel.guest,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        // Return a container with a loading indicator
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                            //child: CircularProgressIndicator(),
                            ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Color.fromARGB(130, 0, 0, 0),
                              BlendMode.multiply,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              '$currentTaskTitle',
                              textAlign:
                                  TextAlign.center, // Center-align the text
                              style: TextStyle(
                                fontFamily: 'Lexend Exa',
                                fontSize: 39,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Return an empty container if no data is available yet
                    }
                  },
                )
              : Container(),
        ),
      );
}
