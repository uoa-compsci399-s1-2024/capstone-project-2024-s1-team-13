import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/support/support_add_notes.dart';
import 'package:inka_test/support/support_edit_notes.dart';
import 'package:inka_test/items/note_item.dart';

import '../models/TraineeNotes.dart';

class SupportTraineeNotes extends StatefulWidget {
   final String title; 

  const SupportTraineeNotes({super.key, required this.title});

  @override
  _SupportTraineeNotes createState() => _SupportTraineeNotes();
}

class _SupportTraineeNotes extends State<SupportTraineeNotes> {
  late final String title;
  final TextEditingController _searchController = TextEditingController();
  String generalNote = ''; // Placeholder for the latest trainee note text
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes

    @override
  void initState() {
    super.initState();
    title = widget.title;
    fetchLatestTraineeNote(); // Call the function to fetch the latest trainee note
    fetchAllTaskNotes(); // Call the function to fetch all task notes
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_ios),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Row(children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SupportAddNotes(title: 'Add Note');
                }));
              },
              iconSize: 60,
              icon: const Icon(Icons.add_rounded),
              padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportEditNotes(title: 'Edit Note');
                }));
              },
              iconSize: 45,
              icon: const Icon(Icons.edit_rounded),
              padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
            )
          ])
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(25), child: _notesSearchBar(context)),
          //
          Expanded(
              child: ListView.builder(
              itemCount: allTaskNotes.length + 1, // Add 1 for trainee note
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Display trainee note
                  return _NoteCard(
                    NoteItem('Trainee Note', generalNote ?? ''),
                  );
                } else {
                  // Display task notes from the database
                  final taskNoteIndex = index - 1; // Adjust index for task notes
                  final taskNote = allTaskNotes[taskNoteIndex];
                  return _NoteCard(
                    NoteItem(taskNote.taskTitle ?? '', taskNote.taskDesc ?? ''),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}

  // Search Bar
  Widget _notesSearchBar(context) => TextField(
        controller: _searchController,
        style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: const EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _searchController.clear()),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _searchController.text = "";
            },
          ),
          hintText: "Search Notes",
          hintStyle: const TextStyle(
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
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
              padding: const EdgeInsets.all(30),
              child: Text('${note.noteTitle}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ))),
          subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Text('${note.noteDescription}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[900])))));

// Mock Data
  final List<NoteItem> mockNotes = [
    NoteItem('General',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Dishes Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Closing Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Toilet Breaks',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
  ];
}
