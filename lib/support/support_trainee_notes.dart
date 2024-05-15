import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_add_notes.dart';
import 'package:inka_test/support/support_edit_notes.dart';
import 'package:inka_test/items/note_item.dart';

import '../models/TraineeNotes.dart';

class SupportTraineeNotes extends StatefulWidget {
  late final String title;
  final Trainee trainee;

  SupportTraineeNotes({super.key, required this.title, required this.trainee});

  @override
  _SupportTraineeNotes createState() => _SupportTraineeNotes();
}

class _SupportTraineeNotes extends State<SupportTraineeNotes> {
  late final String title;
  final TextEditingController _searchController = TextEditingController();
  String generalNote = ''; // Placeholder for the latest trainee note text
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  late List<Trainee> allTrainees = [];
  late Trainee selectedTrainee;

  // To store all grouped tasks notes (grouped by name)
  late Map<String, List<TaskNotes>> groupedTaskNotes;

  late String selectedTask = groupedTaskNotes
      .keys.first; // Variable to track the currently selected task

  // Function to update the selected task
  void updateSelectedTask(String taskName) {
    setState(() {
      selectedTask = taskName;
    });
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;

    fetchSelectedTrainee();
    fetchLatestTraineeNote(); // Call the function to fetch the latest trainee note
    fetchAllTaskNotes(); // Call the function to fetch all task notes
  }

  Future<void> fetchSelectedTrainee() async {
    try {
      final trainee = await queryTraineeById(
          widget.trainee.id); // Query for the trainee by ID

      setState(() {
        assert(
            trainee != null, 'Trainee is null after fetching'); // Add assertion

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

  // Function to fetch all trainees
  Future<void> fetchAllTrainees() async {
    try {
      final trainees = await queryTrainees();

      setState(() {
        allTrainees = trainees;
        //final List<TraineeItem> traineesList = allTrainees.map((trainee) => TraineeItem.fromTrainee(trainee)).toList();
      });
    } catch (e) {
      print('Error fetching trainees: $e');
    }
  }

  // Function to query all task notes
  Future<List<Trainee>> queryTrainees() async {
    try {
      final request = ModelQueries.list(Trainee.classType);
      final response = await Amplify.API.query(request: request).response;

      final trainee = response.data?.items;
      if (trainee == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return trainee.cast<Trainee>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  // Function to fetch all task notes
  Future<void> fetchAllTaskNotes() async {
    try {
      final taskNotes = await queryTaskNotes(widget.trainee.id);
      setState(() {
        allTaskNotes = taskNotes;
      });
    } catch (e) {
      print('Error fetching task notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<TaskNotes>> queryTaskNotes(String traineeID) async {
    try {
      final request = ModelQueries.list(TaskNotes.classType,
          where: TaskNotes.TRAINEEID.eq(traineeID));
      final response = await Amplify.API.query(request: request).response;
      final taskNotes = response.data?.items;
      if (taskNotes == null) {
        print('errors: ${response.errors}');
        return [];
      }
      return taskNotes.cast<TaskNotes>();
    } catch (e) {
      print('Query failed: $e');
      return [];
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

  // Function to fetch the latest trainee note
  Future<void> fetchLatestTraineeNote() async {
    try {
      // Query all trainee notes
      final List<TraineeNotes?> traineeNotes = await queryTraineeNoteListItem();

      if (mounted && traineeNotes.isNotEmpty) {
        // If trainee notes are available, update the state with the text of the latest note
        setState(() {
          generalNote = traineeNotes.last!
              .noteDesc!; // Assuming 'noteDesc' is the field containing the note text
        });
      }
    } catch (e) {
      print('Error fetching trainee note: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    // Group task notes by some criteria (e.g., task category)
    groupedTaskNotes = groupTaskNotesByName(allTaskNotes);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Row(children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportAddNotes(
                      title: 'Add Note', trainee: selectedTrainee);
                }));
              },
              iconSize: 60,
              icon: Icon(Icons.add_rounded),
              padding: EdgeInsets.only(right: 30.0, bottom: 10.0),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportEditNotes(
                    title: 'Edit Note',
                    trainee: selectedTrainee,
                  );
                }));
              },
              iconSize: 45,
              icon: Icon(Icons.edit_rounded),
              padding: EdgeInsets.only(right: 30.0, bottom: 10.0),
            )
          ])
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: _notesSearchBar(context),
            ),
            DropdownButton<String>(
              value: selectedTask,
              hint: Text('Select Task'), // Displayed when no task is selected
              onChanged: (String? newValue) {
                if (newValue != null) {
                  updateSelectedTask(newValue);
                }
              },
              items: groupedTaskNotes.keys
                  .map<DropdownMenuItem<String>>((String taskName) {
                return DropdownMenuItem<String>(
                  value: taskName,
                  child: Text(taskName),
                );
              }).toList(),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _refreshData();
                },
                child: ListView.builder(
                  itemCount: groupedTaskNotes.length,
                  itemBuilder: (context, index) {
                    // Check if the task name matches the selected task
                    if (groupedTaskNotes.keys.elementAt(index) ==
                        selectedTask) {
                      // Extract task name and task notes list from the grouped data
                      String taskName = groupedTaskNotes.keys.elementAt(index);
                      List<TaskNotes> taskNameTaskNotes =
                          groupedTaskNotes.values.elementAt(index);

                      // Display task name as a header
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              taskName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Display task notes for the current task name
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: taskNameTaskNotes.length,
                            itemBuilder: (context, index) {
                              return _NoteCard(
                                NoteItem(
                                    taskNameTaskNotes[index].taskTitle ?? '',
                                    taskNameTaskNotes[index].taskDesc ?? ''),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      // Return an empty container for tasks that are not selected
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Group task notes by task name/title
  Map<String, List<TaskNotes>> groupTaskNotesByName(List<TaskNotes> taskNotes) {
    Map<String, List<TaskNotes>> groupedMap = {};
    for (TaskNotes note in taskNotes) {
      String taskName = note.taskTitle ?? 'Untitled'; // Default task name
      if (!groupedMap.containsKey(taskName)) {
        groupedMap[taskName] = [];
      }
      groupedMap[taskName]!.add(note);
    }
    return groupedMap;
  }

  Future<void> _refreshData() async {
    await fetchLatestTraineeNote();
    await fetchAllTaskNotes();
  }

  // Search Bar
  Widget _notesSearchBar(context) => TextField(
        controller: _searchController,
        style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _searchController.clear()),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _searchController.text = "";
            },
          ),
          hintText: "Search Notes",
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

  // Notes Card
  Widget _NoteCard(note) => Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
              padding: EdgeInsets.all(30),
              child: Text('${note.noteTitle}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ))),
          subtitle: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Text('${note.noteDescription}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[900])))));
}
