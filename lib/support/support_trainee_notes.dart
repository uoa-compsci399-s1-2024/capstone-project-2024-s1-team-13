import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/ModelProvider.dart';
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
  final TextEditingController _textController = TextEditingController();

  late final String title;
  final TextEditingController _searchController = TextEditingController();
  String generalNote = ''; // Placeholder for the latest trainee note text
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  late List<Trainee> allTrainees = [];
  late Trainee selectedTrainee;
  late List<TaskNotes> searchResults = []; // For autocomplete

  String _selectedGroup = 'All';

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

  TaskNotes? selectedTaskNote;

  // Autocomplete logic
  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allTaskNotes
          .where((taskNote) =>
              taskNote.taskTitle!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              taskNote.taskDesc!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  // Group task notes by title
  Map<String, List<TaskNotes>> _groupTaskNotesByTitle(List<TaskNotes> notes) {
    Map<String, List<TaskNotes>> groupedNotes = {};
    for (var note in notes) {
      String title = note.taskTitle ?? 'Unknown';
      if (!groupedNotes.containsKey(title)) {
        groupedNotes[title] = [];
      }
      groupedNotes[title]!.add(note);
    }
    return groupedNotes;
  }

  @override
  Widget build(BuildContext context) {
    // Group task notes by title
    Map<String, List<TaskNotes>> groupedTaskNotes =
        _groupTaskNotesByTitle(allTaskNotes);

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
            // Dropdown Button
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 25),
              child: DropdownButtonFormField(
                value: _selectedGroup,
                items: <String>['All', ...groupedTaskNotes.keys]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGroup = newValue!;
                  });
                },
                icon: const Visibility(
                    visible: false, child: Icon(Icons.arrow_downward)),
                style: const TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down_circle_rounded,
                        color: Colors.pink[900], size: 40),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[300]),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: _buildTaskNotesSearchBar(context)),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _refreshData();
                },
                child: _textController.text.isNotEmpty && searchResults.isEmpty
                    ? Center(
                        child: Text(
                        'No task notes found',
                        style: TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ))
                    : ListView.builder(
                        itemCount: _selectedGroup == 'All'
                            ? (_textController.text.isNotEmpty
                                ? searchResults.length
                                : allTaskNotes.length)
                            : groupedTaskNotes[_selectedGroup]?.length ?? 0,
                        itemBuilder: (context, index) {
                          final taskNote = _selectedGroup == 'All'
                              ? (_textController.text.isNotEmpty
                                  ? searchResults[index]
                                  : allTaskNotes[index])
                              : groupedTaskNotes[_selectedGroup]![index];
                          return _NoteCard(
                            NoteItem(taskNote.taskTitle ?? '',
                                taskNote.taskDesc ?? ''),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await fetchLatestTraineeNote();
    await fetchAllTaskNotes();
  }

  // Search Bar with Autocomplete
  Widget _buildTaskNotesSearchBar(context) {
    final maxListHeight = MediaQuery.of(context).size.height * 0.3;
    final itemHeight = 70.0;
    final listItemWidth = MediaQuery.of(context).size.width * 0.95;

    return Autocomplete<TaskNotes>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<TaskNotes>.empty();
        }
        return allTaskNotes.where((taskNotes) =>
            taskNotes.taskTitle!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()) ||
            taskNotes.taskDesc!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (TaskNotes selectedTaskNote) {
        setState(() {
          searchResults = [selectedTaskNote];
          this.selectedTaskNote = selectedTaskNote;
          _textController.text = '${selectedTaskNote.taskTitle}';
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: _textController,
          focusNode: focusNode,
          onChanged: _onSearchTextChanged,
          style: TextStyle(
            fontSize: 27, // Adjust the font size here
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 40),
            ),
            suffixIcon: IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Icon(Icons.clear_rounded,
                      color: Colors.grey[600], size: 40),
                ),
                onPressed: () {
                  _textController.clear();
                  _onSearchTextChanged('');
                }),
            hintText: "Search ${_selectedGroup}",
            hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }

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
