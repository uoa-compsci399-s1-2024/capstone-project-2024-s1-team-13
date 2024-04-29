import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_edit_selected_trainee.dart';
import 'package:inka_test/items/trainee_item.dart';

class AdminEditTrainees extends StatefulWidget {
  const AdminEditTrainees({super.key, required this.title});
  final String title;

  @override
  _AdminEditTraineesState createState() => _AdminEditTraineesState();
}

class _AdminEditTraineesState extends State<AdminEditTrainees> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                //Pending backend functionality - should save edits
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: const Icon(Icons.done_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Body of screen
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(25),
                child: _buildTraineeSearchBar(context)),
            Expanded(
                child: ListView.builder(
              itemCount: mockTrainees.length,
              itemBuilder: (context, index) {
                final trainee = mockTrainees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminEditSelectedTrainee(
                                title: 'Edit Details',
                                trainee: mockTrainees[index])));
                  },
                  child: _TraineeCard(trainee),
                );
              },
            ))
          ],
        ));
  }

  // Search Bar
  Widget _buildTraineeSearchBar(context) => TextField(
        controller: _textController,
        style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: const EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Trainees",
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

  // Trainee Card
  Widget _TraineeCard(trainee) => Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(

          // Avatar containg image - set as leading for Card instance, needs fixing
          leading: CircleAvatar(
              foregroundImage: AssetImage(trainee.assetImage), radius: 50),
          title: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 100),
              child: Text('${trainee.firstName} ${trainee.lastName}',
                  style: const TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 40,
                      fontWeight: FontWeight.w500))),
          trailing: IconButton(
            onPressed: () =>
                _deleteTrainee(context, mockTrainees.indexOf(trainee)),
            icon: const Icon(Icons.remove_circle_rounded),
            iconSize: 50,
            color: Colors.red[600],
          )));

  //Mock Data
  final List<TraineeItem> mockTrainees = [
    TraineeItem(
        firstName: 'John',
        lastName: 'Doe',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Tom',
        lastName: 'Stevens',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Clark',
        lastName: 'Johnson',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Sam',
        lastName: 'Wood',
        assetImage: 'assets/images/trainee_placeholder.jpeg')
  ];

  // Mock Functionality
  //Delete selected trainee - pending backend functionality
  void _deleteTrainee(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                  'Remove ${mockTrainees[index].firstName} and his details?', // Warning: This works, but throws a NoSuchMethod Error for some reason?
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                    // Remove the trainee - pending backend functionality
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
