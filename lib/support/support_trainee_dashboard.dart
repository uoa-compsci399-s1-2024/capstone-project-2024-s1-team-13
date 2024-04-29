import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:inka_test/items/progress_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_trainee_notes.dart';
import 'package:inka_test/support/support_trainee_profile.dart';
import 'package:inka_test/support/support_trainee_progress.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeDashboard extends StatefulWidget {
  const SupportTraineeDashboard({super.key, required this.trainee});
  final TraineeItem trainee;

  @override
  _SupportTraineeDashboardState createState() =>
      _SupportTraineeDashboardState();
}

class _SupportTraineeDashboardState extends State<SupportTraineeDashboard> {
// Bottom Bar Navigation
  int _selectedIndex = 0;
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
                    SupportTraineeDashboard(trainee: widget.trainee)));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportEvaluate(
                      title: "Evaluate",
                      trainee: widget.trainee,
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
        title: SizedBox(
          height: 250,
          child:
              SvgPicture.asset('assets/images/inka.svg', color: Colors.white),
        ),
        leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.notifications_rounded),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
            icon: const Icon(Icons.settings),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),

      // Bottom Bar
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

      // Body of the screen - Title text should not be center-aligned, not sure what has happened here.

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(50),
              child: Text(
                "${widget.trainee.firstName}'s Summary",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 55,
                    fontWeight: FontWeight.w500),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 10),
              child: Text(
                "Progress",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.pink[900]),
              )),
          _buildProgressCard(context, recentProgress),
          const SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 10),
              child: Text(
                "Notes",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.pink[900]),
              )),
          _buildNotesCard(context, recentNote),
        ],
      ),
    );
  }

  // Recent Notes
  Widget _buildNotesCard(context, note) => Center(
          child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SupportTraineeNotes(title: 'Notes');
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${note.noteTitle}',
                      style: const TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${note.noteDescription}',
                      maxLines: 4,
                      style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink[900],
                      ),
                    ),
                  ])),
        ),
      ));

  // Recent Progress
  Widget _buildProgressCard(context, progress) => Center(
          child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SupportTraineeProgress(title: 'Progress');
          }));
        },
        child: Container(
          width: 750,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            //color: Color.fromARGB(255, 196, 155, 175),
            // Placeholder image - to be changed once backend integrated.
            image: const DecorationImage(
                image: AssetImage('assets/images/task_placeholder.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(130, 0, 0, 0), BlendMode.multiply)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${progress.title}',
                      style: const TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    _circularProgress(progress)
                  ])),
        ),
      ));

  // Circular Progress Indicator
  Widget _circularProgress(progress) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 175,
            height: 175,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              strokeCap: StrokeCap.round,
              value: progress.progress,
              color: Colors.pink[900],
              backgroundColor: Colors.grey[300],
            ),
          ),
        ),
        Center(
            child: Text(
          '${progress.progress * 100}%',
          style: const TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        )),
      ],
    );
  }

  // Mock Data (temporary)

  final NoteItem recentNote = NoteItem('General',
      'Maecenas malesuada, mi vitae placerat rhoncus, quam risus condimentum enim, id feugiat quam turpis ultrices turpis.');

  final ProgressItem recentProgress =
      ProgressItem('Dishes', 0.7, 3, 'Bad', 'null');
}
