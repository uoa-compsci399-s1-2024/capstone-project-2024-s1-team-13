// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';

import '../models/TraineeNotes.dart';

class SupportEditNotes extends StatefulWidget {
  late final String title;
  final Trainee trainee;

  SupportEditNotes({super.key, required this.title, required this.trainee});
  @override
  _SupportEditNotes createState() => _SupportEditNotes();
}

class _SupportEditNotes extends State<SupportEditNotes> {
  late final String title;
  final TextEditingController _searchController = TextEditingController();
  String generalNote = ''; // Placeholder for the latest trainee note text
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  late List<Trainee> allTrainees = [];
  late List<TaskNotes> searchResults = []; // For autocomplete
  TaskNotes? selectedTaskNote;

  late Future<Trainee?> _selectedTraineeFuture;

  String _selectedGroup = 'All';

  @override
  void initState() {
    super.initState();
    title = widget.title;
    _selectedTraineeFuture = fetchSelectedTrainee();
    fetchLatestTraineeNote(); // Call the function to fetch the latest trainee note
    fetchAllTaskNotes(); // Call the function to fetch all task notes
  }

  Future<Trainee?> fetchSelectedTrainee() async {
    try {
      final trainee = await queryTraineeById(widget.trainee.id);
      setState(() {
        assert(trainee != null, 'Trainee is null after fetching');
        _selectedTraineeFuture = trainee! as Future<Trainee?>;
      });
      return trainee;
    } catch (e) {
      safePrint('Error fetching selected trainee: $e');
      return null;
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

  // Autocomplete search
  void _onSearchTextChanged(String searchText) {
    setState(() {
      List<TaskNotes> notesToSearch = _selectedGroup == 'All'
          ? allTaskNotes
          : _groupTaskNotesByTitle(allTaskNotes)[_selectedGroup] ?? [];

      searchResults = notesToSearch
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

  Future<void> deleteTaskNote(String taNoId) async {
    try {
      final req = ModelMutations.deleteById(
        TaskNotes.classType,
        TaskModelIdentifier(id: taNoId),
      );

      final res = await Amplify.API.mutate(request: req).response;
      safePrint('The task note has been deleted!: $res');

      setState(() {
        allTaskNotes.removeWhere((taskNote) => taskNote.id == taNoId);
      });
    } catch (e) {
      safePrint('Error deleting task note: $e');
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
  Widget build(BuildContext context) {
    // Group task notes by title
    Map<String, List<TaskNotes>> groupedTaskNotes =
        _groupTaskNotesByTitle(allTaskNotes);

    List<TaskNotes> filteredTaskNotes = _selectedGroup == 'All'
        ? allTaskNotes
        : groupedTaskNotes[_selectedGroup] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_back_ios),
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Trainee?>(
        future: _selectedTraineeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
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
                          _onSearchTextChanged(_searchController.text);
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
                    child: _buildTaskNotesSearchBar(context),
                  ),
                  Expanded(
                    child: _searchController.text.isEmpty
                        ? ListView.builder(
                            itemCount: filteredTaskNotes.length,
                            itemBuilder: (context, index) {
                              final taskNote = filteredTaskNotes[index];
                              return _NoteCard(
                                NoteItem(
                                  taskNote.taskTitle ?? '',
                                  taskNote.taskDesc ?? '',
                                ),
                                taskNote.id ?? "",
                              );
                            },
                          )
                        : (searchResults.isEmpty
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
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final taskNote = searchResults[index];
                                  return _NoteCard(
                                    NoteItem(
                                      taskNote.taskTitle ?? '',
                                      taskNote.taskDesc ?? '',
                                    ),
                                    taskNote.id ?? "",
                                  );
                                },
                              )),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
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
        List<TaskNotes> notesToSearch = _selectedGroup == 'All'
            ? allTaskNotes
            : _groupTaskNotesByTitle(allTaskNotes)[_selectedGroup] ?? [];
        return notesToSearch.where((taskNotes) =>
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
          _searchController.text = '${selectedTaskNote.taskTitle}';
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: _searchController,
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
                  _searchController.clear();
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
  Widget _NoteCard(note, String taNoId) => Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Text('${note.noteTitle}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ))),
            IconButton(
              onPressed: () => deleteTaskNoteDialog(context, taNoId),
              icon: Icon(Icons.remove_circle_rounded),
              iconSize: 50,
              color: Colors.red[600],
            )
          ]),
          subtitle: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Text('${note.noteDescription}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[900])))));

  void deleteTaskNoteDialog(BuildContext context, String taNoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: const Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this note?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 35,
                      fontWeight: FontWeight.w500))),
          actionsPadding: const EdgeInsets.only(bottom: 60),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 100),
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lexend Exa',
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.pink[900],
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("NO")),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 100),
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lexend Exa',
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.pink[900],
                      foregroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    deleteTaskNote(taNoId);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("YES"))
            ])
          ],
        );
      },
    );
  }
}
