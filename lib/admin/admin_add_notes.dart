import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Admin.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/models/TaskNotes.dart';

class AdminAddNotes extends StatefulWidget {
  final String title;

  const AdminAddNotes(
      {super.key, required this.title, required this.trainee});
  final Trainee trainee;

  @override
  _AdminAddNotesState createState() => _AdminAddNotesState();
}

class _AdminAddNotesState extends State<AdminAddNotes> {
  late Trainee selectedTrainee;

  late final String title;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _notesTitleController = TextEditingController();
  String notesText = "";
  String notesTitleText = "";
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  late String traineeID = widget.trainee.id; // Get the selected trainee's ID

  @override
  void initState() {
    super.initState();
    title = widget.title;
    traineeID = widget.trainee.id;
    fetchAllTaskNotes(); // Call the function to fetch all task notes
    fetchSelectedTrainee();
  }

  //BACKEND ADDED

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

  // Function to fetch all task notes
  Future<void> fetchAllTaskNotes() async {
    try {
      final taskNotes = await queryTaskNotes();

      setState(() {
        allTaskNotes = taskNotes;
      });
    } catch (e) {
      print('Error fetching task notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<TaskNotes>> queryTaskNotes() async {
    try {
      final request = ModelQueries.list(TaskNotes.classType);
      final response = await Amplify.API.query(request: request).response;

      final taskNotes = response.data?.items;

      if (taskNotes == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return taskNotes
          .cast<TaskNotes>(); // Cast the task notes to the TaskNotes class
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  //query all of the task notes
  Future<List<TaskNotes?>> queryListItems() async {
    try {
      final request = ModelQueries.list(TaskNotes.classType);
      final response = await Amplify.API.query(request: request).response;
      //safePrint('List of all the Task Notes:', response);
      safePrint('Testing!');

      final taskNotes = response.data?.items;
      safePrint(taskNotes);
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

  Future<Support?> queryItem(Support queriedSupport) async {
    try {
      final request = ModelQueries.get(
        Support.classType,
        queriedSupport.modelIdentifier,
      );
      final response = await Amplify.API.query(request: request).response;
      final taskNotes = response.data;
      if (taskNotes == null) {
        safePrint('errors: ${response.errors}');
      }
      return taskNotes;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  //createTaskNotes section
  Future<void> createTaskNotes(String taskTitle, String taskDesc) async {
    try {
      final String traineeID =
          widget.trainee.id; // Get the selected trainee's ID
      final aTaskNote = TaskNotes(
        taskTitle: taskTitle,
        taskDesc: taskDesc,
        traineeID: traineeID,
         // Assign the trainee's ID to the task note
      );
      final req = ModelMutations.create(aTaskNote);
      final res = await Amplify.API.mutate(request: req).response;

      final createdTaskNote = res.data;
      if (createdTaskNote == null) {
        safePrint('errors: ${res.errors}');
        return;
      }
      safePrint('Mutation result: ${createdTaskNote.taskTitle}');
    } on ApiException catch (e) {
      safePrint('Mutation Failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              _addNote(); // Dummy functionality
            },
            iconSize: 50,
            icon: Icon(Icons.done_rounded),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 75, left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
                controller: _notesTitleController,
                style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "Enter title",
                  hintStyle: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400]),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                )),
            SizedBox(height: 20),
            TextFormField(
                controller: _notesController,
                maxLines: 18,
                style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "Write note here",
                  hintStyle: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400]),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                ))
          ],
        ),
      ),
    );
  }

  // Dummy add function - pending backend functionality
  void _addNote() async {
    // Get the title and description from the text controllers
    String title = _notesTitleController.text;
    String description = _notesController.text;
    //final String traineeID = widget.trainee.id; // Get the selected trainee's ID
    //Trainee traineeTaskNote  = widget.trainee; // Assign the trainee's ID to the task note

    await createTaskNotes(title, description); // Create the task note
    await fetchAllTaskNotes();

    // Validate input - pending backend functionality
    if (title.isNotEmpty && description.isNotEmpty) {
      // Navigate back to the previous screen and pass the new note data
      Navigator.pop(context, {'title': title, 'description': description});
    } else {
      // Show an error message if input is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            elevation: 10,
            content: Text(
              'Please fill in both title and description',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink[900]),
            )),
      );
    }
  }
}