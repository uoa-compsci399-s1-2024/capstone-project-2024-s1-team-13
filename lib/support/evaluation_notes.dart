import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Support.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationNotes extends StatefulWidget {
  const EvaluationNotes(
      {Key? key, required this.task, required this.trainee})
      : super(key: key);
  //final EvaluateItem evaluation;
  final Task task; 
  final Trainee trainee;

  @override
  _EvaluationNotesState createState() => _EvaluationNotesState();
}

class _EvaluationNotesState extends State<EvaluationNotes> {
  late final String title;
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes




  // For typing notes.
  final TextEditingController _notesController = TextEditingController();
  String notesText = "";


   @override
  void initState() {
    super.initState();
    
    fetchAllTaskNotes();
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
          title: Text(widget.task.taskTitle??''),
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
              // To add functionality to settings
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
              _notesQuestion(),
              // TextField
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  child: _notesTextBox()),
              // Buttons
              SizedBox(height: 50),
              _addNoteButton(),
              _skipButton(context)
            ],
          ),
        ));
  }

  // Question
  Widget _notesQuestion() => Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
                'What could ${widget.trainee.firstName} improve on?', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 45,
                    fontWeight: FontWeight.w500))),
      ]);

  // Textfield
  Widget _notesTextBox() => TextFormField(
        controller: _notesController,

        maxLines: 8,

        // For getting input - mock functionality
        onChanged: (value) {
          setState(() {
            _notesController.text = value.toString();
          });
        },

        style: TextStyle(
          fontFamily: "Lexend Exa",
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),

        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            hintText: "Write note here",
            hintStyle: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w300),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none)),
      );

  // Buttons
  Widget _addNoteButton() => ElevatedButton(
      onPressed: () {
        _submitNote();
        
      },
      child: Text("ADD NOTE"),
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

  Widget _skipButton(context) => TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportEvaluate(title: "Evaluation", trainee: widget.trainee, task: widget.task);
        }));
      },
      child: Text(
        'Skip',
        style: TextStyle(
          fontFamily: 'Lexend Exa',
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.pink[900],
          decoration: TextDecoration.underline,
        ),
      ));

  // Helper function for addNoteButton
  void _submitNote() async {
    String description = _notesController.text;
    if (_notesController.text.isNotEmpty) {
      // Save the note -- pending backend functionality
     await createTaskNotes(widget.task.taskTitle??'', description); // Create the task note
     await fetchAllTaskNotes();

      NoteItem newNote = NoteItem(
          "${widget.task.taskTitle} Evaluation", _notesController.text);

      // Clear the text field
      _notesController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SupportEvaluate(
                title: "Evaluation", trainee: widget.trainee, task: widget.task,)), // To change
      );
    }
  }

  // Pop-up dialog for when addNoteButton - to add
}
