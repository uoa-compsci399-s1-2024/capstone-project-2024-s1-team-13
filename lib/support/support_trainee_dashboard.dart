import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/models/TraineeNotes.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:inka_test/items/progress_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_trainee_notes.dart';
import 'package:inka_test/support/support_trainee_profile.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeDashboard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SupportTraineeDashboard({super.key, required this.trainee, this.task});
  final Trainee trainee;
  final Task? task;
  //final String traineeID;

  @override
  _SupportTraineeDashboardState createState() =>
      _SupportTraineeDashboardState();
}

class _SupportTraineeDashboardState extends State<SupportTraineeDashboard> {
  TextEditingController _notesController = TextEditingController(); // Step 1
  bool isEditing = false; // Step 2

  String generalNote = ''; // Placeholder for the latest trainee note text
  late Trainee selectedTrainee;
  late Task selectedTask;
  List<CurrTask>? currentTasks = [];
  TaskNotes taskNote = TaskNotes();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllData();

    selectedTask = widget.task ??
        Task(
            adminID:
                "e7bd6941-2f8f-4949-a4ed-6803cd2ab42b"); // Provide a default task if widget.task is null

    fetchLatestTraineeNote(); // Fetch the latest trainee note when the widget is initialized
    _notesController.text = '';
  }

  Future<void> fetchAllData() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating fetch delay
    //await fetchSelectedTrainee();
    await fetchCurrentTask();
    await fetchLatestTaskNote(currentTasks!);
    setState(() {
      isLoading = false;
    });
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

  Future<void> fetchSelectedTask() async {
    try {
      final task =
          await queryTaskByID(widget.task!.id); // Query for the task by ID

      setState(() {
        selectedTask = task!;
      });
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
    safePrint('Error fetching selected task');
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

  Future<List<TraineeNotes?>> queryTraineeNoteListItem() async {
    try {
      final request = ModelQueries.list(TraineeNotes.classType);
      final response = await Amplify.API.query(request: request).response;

      final traineeNotes = response.data?.items;
      if (traineeNotes == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return traineeNotes;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
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
  Future<void> fetchLatestTaskNote(List<CurrTask?> currentTasks) async {
    try {
      // Query all task notes
      final List<TaskNotes?> taskNotes =
          await queryTaskNoteListItem(widget.trainee.id);

      if (taskNotes.isNotEmpty) {
        // If task notes are available, update the state with the text of the latest note
        taskNotes.sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
        setState(() {
          taskNote = taskNotes.first!; // Update taskNote with the latest note
        });
      }
    } catch (e) {
      print('Error fetching task note: $e');
    }
  }

  // Function to fetch the latest trainee note
  Future<void> fetchLatestTraineeNote() async {
    try {
      // Query all trainee notes
      final List<TraineeNotes?> traineeNotes = await queryTraineeNoteListItem();

      if (mounted && traineeNotes.isNotEmpty) {
        final traineeGeneralNotes = traineeNotes.where(
            (note) => note!.traineeNotesTrainee?.id == widget.trainee.id);

        // Sort trainee notes by date or timestamp
        traineeNotes.sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

        // Update generalNote with the latest note
        setState(() {
          generalNote = traineeNotes.first!.noteDesc!;
        });
      }
    } catch (e) {
      print('Error fetching trainee note: $e');
    }
  }

// Bottom Bar Navigation
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainee dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SupportTraineeDashboard(trainee: widget.trainee)));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportEvaluate(
                      title: "Evaluate",
                      trainee: widget.trainee,
                      task: selectedTask,
                    )));
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
    if (isLoading) {
      return Scaffold(
        
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else{


    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 250,
          child:
              SvgPicture.asset('assets/images/inka.svg', color: Colors.white),
        ),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.notifications_rounded),
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SupportNotifications(title: 'Notifications');
            }));
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(50),
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
              _buildProgressCard(
                
                context,
                currentTasks!.isNotEmpty
                    ? currentTasks?.last?.taskProgress
                    : '0.0',
                currentTasks!.isNotEmpty
                    ? currentTasks?.last.currTaskName ?? "No Current Task"
                    : "No Current Task",
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 50, bottom: 10),
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
              //_buildNotesCard(context, generalNote),
              _buildNotesCard(context, generalNote),
              SizedBox(height: 30),

              _buildAnotherNotesWidget(context, "Trainee Note"),
            ],
          ),
        ),
      ),
    );
    }
  }

  Future<void> updateCurrentTask(
      List<CurrTask> currentTask, String? newTaskProgress) async {
    try {
      if (currentTask.isEmpty) {
        throw Exception('No current task found');
      }

      final updatedTask =
          currentTask.last.copyWith(taskProgress: newTaskProgress);

      final request = ModelMutations.update(updatedTask);
      final response = await Amplify.API.mutate(request: request).response;

      // Check for errors in the mutation response
      if (response.errors.isNotEmpty) {
        throw Exception('Failed to update');
      }

      // Print the response for debugging purposes
      safePrint("Current Task updated!");

      safePrint('Update response: $response');
    } catch (e) {
      // Handle any errors
      safePrint('Error updating current task: $e');
    }
  }

  Future<void> _refreshData() async {
    // Fetch the current task
    await fetchCurrentTask();

    // If current task is available, fetch task note based on it
    if (currentTasks != null && currentTasks!.isNotEmpty) {
      setState(() {
        updateCurrentTask(currentTasks!, "0%");
      });
      await fetchLatestTaskNote(currentTasks!);
    }

    // Fetch latest trainee note
    await fetchLatestTraineeNote();
  }

  Widget _buildAnotherNotesWidget(BuildContext context, String title) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEditing = true; // Enter editing mode when tapped
          });
        },
        child: Padding(
          padding: EdgeInsets.all(20), // Add padding here
          child: SizedBox(
            width: 750,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30), // Add left padding for the title
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
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing; // Toggle editing mode
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              30), // Use the same padding as _buildNotesCard
                      child: isEditing
                          ? TextField(
                              controller: _notesController,
                              maxLines: null,
                              onChanged: (value) {
                                setState(() {
                                  generalNote = value; // Update note text
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Edit your note...',
                                border: InputBorder.none,
                              ),
                            )
                          : Text(
                              generalNote,
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
      ),
    );
  }

  // Recent Notes
  Widget _buildNotesCard(context, note) => Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SupportTraineeNotes(
                title: 'Notes',
                trainee: widget.trainee,
              );
            }));
          },
          child: Container(
            width: 750,
            height: 190,
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
              padding: EdgeInsets.all(30),
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
                  Text(
                    "Latest Note: ${taskNote.taskTitle != null ? '${taskNote.taskTitle}\n' : ''}${taskNote.taskDesc ?? 'No Note'}", // Display the fetched note here
                    maxLines: 4,
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
  Widget _buildProgressCard(BuildContext context, progress, currentTaskTitle) => Center(
  child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SupportTraineeProgress(title: 'Progress', trainee: widget.trainee,);
      }));
    },
    child: currentTasks != null && currentTasks!.isNotEmpty
        ? FutureBuilder<String>(
            future: getDownloadUrl(
              key: currentTasks!.last.taskCoverImage!,
              accessLevel: StorageAccessLevel.guest,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container( // Return a container with a loading indicator
                  width: 750,
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
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Container(
                  width: 750,
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$currentTaskTitle',
                          style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 39,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        currentTasks != null && currentTasks!.isNotEmpty
                            ? _circularProgress(currentTasks!.last.taskProgress)
                            : Container(
                                width: 175,
                                height: 175,
                                child: Center(
                                  child: Text(
                                    '0%',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Exa',
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ],
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


// Circular Progress Indicator
Widget _circularProgress(String? progress) {
  double percentage = double.parse(progress!.replaceAll('%', ''));
  double actualPercentage = percentage / 100;
  //double progressValue = double.parse(progress);

  return Stack(
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Center(
        child: SizedBox(
          width: 175,
          height: 175,
          child: CircularProgressIndicator(
            strokeWidth: 15,
            strokeCap: StrokeCap.round,
            value: actualPercentage,
            color: Colors.pink[900],
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      Center(
          child: Text(
        progress,
        style: TextStyle(
            fontFamily: 'Lexend Exa',
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white),
      )),
    ],
  );
}

// Mock Data (temporary)

final NoteItem recentNote = NoteItem('General',
    'Maecenas malesuada, mi vitae placerat rhoncus, quam risus condimentum enim, id feugiat quam turpis ultrices turpis.');

final ProgressItem recentProgress =
    ProgressItem('Dishes', 0.7, 3, 'Bad', 'null');

}