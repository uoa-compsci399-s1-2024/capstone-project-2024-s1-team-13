import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_notes.dart';
import 'package:inka_test/admin/admin_edit_notes.dart';
import 'package:inka_test/items/note_item.dart';

class AdminTraineeNotes extends StatelessWidget {
  AdminTraineeNotes({Key? key, required this.title}) : super(key: key);
  final String title;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  return const AdminAddNotes(title: 'Add Note');
                }));
              },
              iconSize: 60,
              icon: Icon(Icons.add_rounded),
              padding: EdgeInsets.only(right: 30.0, bottom: 10.0),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminEditNotes(title: 'Edit Note');
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
          Padding(padding: EdgeInsets.all(25), child: _notesSearchBar(context)),
          Expanded(
              child: ListView.builder(
            itemCount: mockNotes.length,
            itemBuilder: (context, index) {
              final note = mockNotes[index];
              return _NoteCard(note);
            },
          ))
        ],
      )),
    );
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

// Mock Data
  final List<NoteItem> mockNotes = [
    NoteItem('Closing Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Dishes Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('General',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Toilet Breaks',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
  ];
}
