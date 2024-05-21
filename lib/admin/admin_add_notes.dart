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
  //GLOBAL VARIABLES
  late Trainee selectedTrainee;
  late final String title;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _notesTitleController = TextEditingController();
  String notesText = "";
  String notesTitleText = "";
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  late String traineeID = widget.trainee.id; // Get the selected trainee's ID

  //INIT STATE
  @override
  void initState() {
    super.initState();
    title = widget.title;
    traineeID = widget.trainee.id;
    fetchAllTaskNotes();
    fetchSelectedTrainee();
  }

  //BACKEND FUNCTIONS
  Future<void> fetchSelectedTrainee() async {
    try {
      final trainee = await queryTraineeById(
          widget.trainee.id);

      setState(() {
        selectedTrainee = trainee!;
      });
    } catch (e) {
      safePrint('Error fetching selected trainee: $e');
    }
  }

  Future<Trainee?> queryTraineeById(String traineeID) async {
    try {
      final request = ModelQueries.get(
        Trainee.classType,
        TraineeModelIdentifier(id: traineeID)
      );
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
          .cast<TaskNotes>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  Future<List<TaskNotes?>> queryListItems() async {
    try {
      final request = ModelQueries.list(TaskNotes.classType);
      final response = await Amplify.API.query(request: request).response;
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

  Future<void> createTaskNotes(String taskTitle, String taskDesc) async {
    try {
      if (widget.trainee.isWorking == true) {
        final String traineeID = widget.trainee.id;
        final aTaskNote = TaskNotes(
          taskTitle: taskTitle,
          taskDesc: taskDesc,
          traineeID: traineeID,
        );

        final req = ModelMutations.create(aTaskNote);
        final res = await Amplify.API.mutate(request: req).response;

        final createdTaskNote = res.data;
        if (createdTaskNote == null) {
          safePrint('errors: ${res.errors}');
          return;
        }
        safePrint('Successfully added a new note! NOTE: ${createdTaskNote.taskTitle}');
      }
    } on ApiException catch (e) {
      safePrint('Error adding a note! ERROR: $e');
    }
  }

  //FRONTEND
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
              _addNote();
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

  void _addNote() async {
    String title = _notesTitleController.text;
    String description = _notesController.text;

    await createTaskNotes(title, description);
    await fetchAllTaskNotes();

    if (title.isNotEmpty && description.isNotEmpty && widget.trainee.isWorking == true) {
      Navigator.pop(context, {'title': title, 'description': description});
    } else if (widget.trainee.isWorking == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50))),
          elevation: 10,
          content: Text(
            'Cannot create a note for archived trainee!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]),
          )),
      );
    } else {
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