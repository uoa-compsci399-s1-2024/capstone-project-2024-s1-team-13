import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';
import 'package:inka_test/support/support_trainee_notes.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeProfile extends StatefulWidget {
  SupportTraineeProfile({
    super.key,
    required this.title,
    required this.trainee,
  });
  final String title;
  final Trainee trainee;
  Task task = Task(
      adminID: "e7bd6941-2f8f-4949-a4ed-6803cd2ab42b"); // Initialize task here
  @override
  _SupportTraineeProfileState createState() => _SupportTraineeProfileState();
}

class _SupportTraineeProfileState extends State<SupportTraineeProfile> {
  //late final Task task;

  // Bottom Bar Navigation
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainee dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SupportTraineeDashboard(trainee: widget.trainee, task: widget.task)));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportEvaluate(
                      title: "Evaluate",
                      trainee: widget.trainee,
                      task: widget.task,
                    )));
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportTraineeProfile(
                    title: 'Profile', trainee: widget.trainee)));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            iconSize: 40,
            icon: Icon(Icons.notifications_rounded),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SupportNotifications(title: 'Notifications');
              }));
            }),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SupportSettings(title: 'Settings');
              }));
            }, // To add functionality to settings
            iconSize: 45,
            icon: Icon(Icons.settings),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'EVALUATE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'PROFILE',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // Body of screen

      body: Center(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.all(50), child: _profileDetails()),
          SizedBox(height: 10),
          //_progressButton(context),
          _progressButton(context),
          SizedBox(height: 50),
          _notesButton(context)
        ],
      )),
    );
  }

  // Widgets

  Widget _profileDetails() => Row(
        children: [
    FutureBuilder<String>(
      future: getDownloadUrl(
        key: widget.trainee.traineePhoto!,
        accessLevel: StorageAccessLevel.guest,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: 100,
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey,
            child: Icon(Icons.error),
          );
        }
        return CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(snapshot.data!),
        );
      },
    ),
    const SizedBox(width: 50),
    Text("${widget.trainee.firstName} ${widget.trainee.lastName}",
      maxLines: 2,
      style: const TextStyle(
        fontFamily: 'Lexend Exa',
        fontSize: 45,
        fontWeight: FontWeight.w500))
  ],
      );

   Future<String> getDownloadUrl({
    required String key,
    required StorageAccessLevel accessLevel,
  }) async {
    try {
      final result = await Amplify.Storage.getUrl(
        key: key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 7),
          ),
        ),
      ).result;
      return result.url.toString();
    } on StorageException catch (e) {
      print('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }
  
  

  // Progress Button
  Widget _progressButton(context) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SupportTraineeProgress(title: 'Progress', trainee: widget.trainee,);
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 196, 155, 175),
                const Color.fromARGB(255, 87, 195, 245)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          ),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.auto_graph_rounded, size: 70, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Progress',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      );

  // Notes Button

  Widget _notesButton(context) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SupportTraineeNotes(
              title: 'Notes',
              trainee: widget.trainee,
            );
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 196, 155, 175),
                const Color.fromARGB(255, 87, 195, 245)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          ),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.notes_rounded, size: 70, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Notes',
                style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      );
}