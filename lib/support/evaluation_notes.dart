import 'package:flutter/material.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationNotes extends StatefulWidget {
  const EvaluationNotes(
      {super.key, required this.evaluation, required this.trainee});
  final EvaluateItem evaluation;
  final TraineeItem trainee;

  @override
  _EvaluationNotesState createState() => _EvaluationNotesState();
}

class _EvaluationNotesState extends State<EvaluationNotes> {
  // For typing notes.
  final TextEditingController _notesController = TextEditingController();
  String notesText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.evaluation.title),
          leading: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.arrow_back_ios),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: _notesTextBox()),
              // Buttons
              const SizedBox(height: 50),
              _addNoteButton(),
              _skipButton(context)
            ],
          ),
        ));
  }

  // Question
  Widget _notesQuestion() => const Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
                'What could [Name] improve on?', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
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

        style: const TextStyle(
          fontFamily: "Lexend Exa",
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),

        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            hintText: "Write note here",
            hintStyle: const TextStyle(
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
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(500, 100),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 40,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.pink[900],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text("ADD NOTE"));

  Widget _skipButton(context) => TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportEvaluate(title: "Evaluation", trainee: widget.trainee);
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
  void _submitNote() {
    if (_notesController.text.isNotEmpty) {
      // Save the note -- pending backend functionality
      NoteItem newNote = NoteItem(
          "${widget.evaluation.title} Evaluation", _notesController.text);

      // Clear the text field
      _notesController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SupportEvaluate(
                title: "Evaluation", trainee: widget.trainee)), // To change
      );
    }
  }

  // Pop-up dialog for when addNoteButton - to add
}
