import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/models/Sess.dart';
import 'package:inka_test/models/Session.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_settings.dart';

class AdminSelectedProgress extends StatefulWidget {
  final Task task;
  final Trainee trainee;
  final String title;
  
  AdminSelectedProgress({
    Key? key,
    required this.task,
    required this.trainee,
    required this.title,
  }) : super(key: key);

  @override
  _AdminSelectedProgress createState() => _AdminSelectedProgress();
}

class _AdminSelectedProgress extends State<AdminSelectedProgress> {
  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    fetchSession();
  }

  //BACKEND FUNCTIONS
  Future<void> fetchSession() async {
    try {
      final session = await querySession(widget.task.id, widget.trainee.id);
      setState(() {
        sessions = session ?? [];
        sessions.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      });
    } catch (e) {
      print('Error fetching session: $e');
    }
  }

  Future<List<Session>?> querySession(String taskID, String traineeID) async {
    try {
      final request = ModelQueries.list(
        Session.classType,
        where: Session.TRAINEEID.eq(traineeID) & Session.TASKID.eq(taskID),
      );
      final response = await Amplify.API.query(request: request).response;
      final session = response.data?.items;
      if (session == null) {
        safePrint('errors: ${response.errors}');
      } else {
        session.sort((a, b) {
          if (a == null || a.createdAt == null || b == null || b.createdAt == null) {
            return 0;
          }
          return a.createdAt!.compareTo(b.createdAt!);
        });
      }
      return session?.cast<Session>();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  //FRONTEND
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.taskTitle!),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_back_ios),
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminSettings(title: 'Settings');
              }));
            },
            iconSize: 45,
            icon: Icon(Icons.settings),
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      body: sessions.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator if sessions are being fetched
          : OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _createDataTable(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Portrait mode is not supported",
                          style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 20),
                        Icon(
                          Icons.screen_rotation_rounded,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Please rotate device",
                          style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }

  // Data Table
  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      dividerThickness: 3,
      showBottomBorder: true,
      headingTextStyle: TextStyle(
        fontFamily: 'Lexend Exa',
        fontSize: 18,
        color: Colors.pink[900],
      ),
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey[300]),
      dataTextStyle: TextStyle(
        fontFamily: 'Lexend Exa',
        fontSize: 15,
      ),
      dataRowMaxHeight: 150,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Session')),
      DataColumn(label: Text('Evaluated Date')),
      DataColumn(label: Text('Judgement Call')),
      DataColumn(label: Text('Feedback')),
      DataColumn(label: Text('Notes')),
    ];
  }

  List<DataRow> _createRows() {
    return sessions.asMap().entries.map((entry) {
      final int sessionNumber = entry.key + 1;
      final Session session = entry.value;
      if (session.sessionList != null && session.sessionList!.isNotEmpty) {
        final Sess sess = session.sessionList![0];
        String judgementCall = '';
        String feedback = '';
        String notes = '';
        String eval_date = '';
        if (sess.aSess != null && sess.aSess!.length >= 3) {
          judgementCall = sess.aSess![2] ?? ''; 
          feedback = sess.aSess![1] ?? ''; 
          notes = sess.aSess![0] ?? ''; 
          eval_date = sess.aSess![3] ?? '';
        }
        return DataRow(
          cells: [
            DataCell(Text('$sessionNumber')), 
            DataCell(Text(eval_date)),
            DataCell(Text(judgementCall)),
            DataCell(Text(feedback)),
            DataCell(
              Container(
                padding: EdgeInsets.all(20),
                width: 650,
                child: Text(notes),
              ),
            ),
          ],
        );
      } else {
        return DataRow(cells: [DataCell(Text('No data'))]); // Handle the case when sessionList is empty
      }
    }).toList();
  }
}
