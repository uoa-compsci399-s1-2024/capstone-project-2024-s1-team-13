import 'package:flutter/material.dart';

class AdminAddNotes extends StatefulWidget {
  const AdminAddNotes({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AdminAddNotesState createState() => _AdminAddNotesState();
}

class _AdminAddNotesState extends State<AdminAddNotes> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _notesTitleController = TextEditingController();
  String notesText = "";
  String notesTitleText = "";

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
  void _addNote() {
    // Get the title and description from the text controllers
    String title = _notesTitleController.text;
    String description = _notesController.text;

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
