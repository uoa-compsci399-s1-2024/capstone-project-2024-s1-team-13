import 'package:flutter/material.dart';
import 'package:inka_test/items/note_item.dart';

class SupportEditNotes extends StatelessWidget {
  SupportEditNotes({Key? key, required this.title}) : super(key: key);
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
      ),
      body: Center(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.all(25), child: _notesSearchBar(context)),
          //
          Expanded(
              child: ListView.builder(
            itemCount: mockNotes.length,
            itemBuilder: (context, index) {
              final note = mockNotes[index];
              return _NoteCard(context, note);
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
  Widget _NoteCard(context, note) => Card(
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
              onPressed: () => _deleteNote(context, mockNotes.indexOf(note)),
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

// Mock Data
  final List<NoteItem> mockNotes = [
    NoteItem('Closing Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Dishes Evaluation',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('General',
        'Lorem ipsum dolor sit amet, consectetur adipisc  ing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
    NoteItem('Toilet Breaks',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '),
  ];

// Mock Functions

/*Edit selected note
  void _editNote(BuildContext context, NoteItem note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSelectedNote(title: 'Edit Note', note: note),
      ),
    );
  }*/

//Delete selected note - pending backend functionality
  void _deleteNote(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this note?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 35,
                      fontWeight: FontWeight.w500))),
          actionsPadding: EdgeInsets.only(bottom: 60),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  child: Text("NO"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 100),
                      textStyle: TextStyle(
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
                  }),
              SizedBox(width: 20),
              ElevatedButton(
                  child: Text("YES"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 100),
                      textStyle: TextStyle(
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
                    // Remove the note from the list
                    mockNotes.remove(mockNotes[index]);
                    Navigator.of(context).pop(); // Close the dialog
                  })
            ])
          ],
        );
      },
    );
  }
}
