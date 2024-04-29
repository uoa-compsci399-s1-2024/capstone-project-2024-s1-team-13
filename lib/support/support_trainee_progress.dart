import 'package:flutter/material.dart';
import 'package:inka_test/items/progress_item.dart';
import 'package:inka_test/support/support_settings.dart';

class SupportTraineeProgress extends StatelessWidget {
  SupportTraineeProgress({super.key, required this.title});
  final String title;
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
        children: [
          //
          Expanded(
              child: ListView.builder(
            itemCount: mockProgress.length,
            itemBuilder: (context, index) {
              final progress = mockProgress[index];
              return _ProgressCard(context, progress);
            },
          ))
        ],
      )),
    );
  }

  // Widgets

  Widget _ProgressCard(context, progress) => Card(
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
              padding: const EdgeInsets.all(30),
              child: Text('${progress.title}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ))),
          subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: _buildProgress(progress))));

// Build for Progress Card
  Widget _buildProgress(progress) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Container for Linear Progress Indicator
        Container(
            //decoration: BoxDecoration(color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${progress.progress * 100}% Completed',
              style: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          LinearProgressIndicator(
              value: progress.progress,
              borderRadius: BorderRadius.circular(50),
              minHeight: 30,
              backgroundColor: Colors.grey[350],
              color: Colors.pink[900])
        ])),

        const SizedBox(height: 20),

        // Container for Evaluation Count
        Container(
          //decoration: BoxDecoration(color: Colors.white),
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Times Evaluated: ',
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            TextSpan(
              text: '${progress.evaluationCount}',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink[900]),
            )
          ])),
        ),

        const SizedBox(height: 20),

        // Container for Recent Feedback
        Container(
          //decoration: BoxDecoration(color: Colors.white),
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Recent Feedback: ',
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            TextSpan(
              text: '${progress.feedback}',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink[900]),
            )
          ])),
        ),

        const SizedBox(height: 20),

        // Container for Notes
        Container(
            //decoration: BoxDecoration(color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Notes: ',
              style: TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          Text(
            '${progress.notes}',
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]),
          )
        ])),
      ]);

// Mock Data

  final List<ProgressItem> mockProgress = [
    ProgressItem('Closing Evaluation', 0.45, 3, 'Good',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
    ProgressItem('Dishes Evaluation', 0.7, 2, 'Very Good',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
  ];
}
