import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/CurrTask.dart';
import 'package:inka_test/models/JudgementCall.dart';
import 'package:inka_test/models/Sess.dart';
import 'package:inka_test/models/Support.dart';
import 'package:inka_test/models/Session.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/TaskFeeling.dart';
import 'package:inka_test/models/TaskNotes.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_evaluate.dart';
import 'package:inka_test/support/support_items/evaluate_item.dart';
import 'package:inka_test/items/note_item.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/support/support_settings.dart';

class EvaluationNotes extends StatefulWidget {
  EvaluationNotes({Key? key, required this.task, required this.trainee})
      : super(key: key);
  //final EvaluateItem evaluation;
  final Task task;
  final Trainee trainee;
  List<CurrTask>? currentTasks = [];
  List<Task>? allTasks = []; // List to store all tasks
  List<JudgementCall> judgementCalls = [];
  List<TaskFeeling> taskFeelings = [];

  @override
  _EvaluationNotesState createState() => _EvaluationNotesState();
}

class _EvaluationNotesState extends State<EvaluationNotes> {
  late final String title;
  late List<TaskNotes> allTaskNotes = []; // List to store all task notes
  List<CurrTask> currentTasks = [];
  late Task selectedTask;
  List<Task> allTasks = []; // List to store all tasks
  List<Session> sessions = []; //List to store all of the trainee's sessions (ALL OF IT)  
  Map<String, List<Session>> taskSessionsMap = {}; //Another way to store sessions in a more efficient way


  // For typing notes.
  final TextEditingController _notesController = TextEditingController();
  String notesText = "";

  @override
  void initState() {
    super.initState();
    fetchSelectedTask();
    fetchJudgementCall(); 
    fetchTaskFeeling(); 
    querySession(widget.task.id, widget.trainee.id);
    fetchSession();
    
    selectedTask = widget.task;
  }




  Future<void> fetchSession() async {
  try {
    final session = await querySession(widget.task.id, widget.trainee.id);

    setState(() {
      sessions = session!;
    });
    fetchMatchingSessions();

    // Debug prints to check the sorted sessions
    print('Sorted sessions:');
    sessions.forEach((session) {
      print('Session ID: ${session.id}, Created At: ${session.createdAt}');
    });
    
  } catch (e) {
    print('Error fetching session: $e');
  }
}


  //QUERY ALL THE SESSIONS FOR THE TRAINEE
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
          return 0; // Handle null values
        }
        return a.createdAt!.compareTo(b.createdAt!);
      });
      // Sort sessions by createdAt in ascending order
    }

    return session?.cast<Session>();
  } on ApiException catch (e) {
    safePrint('Query failed: $e');
    return [];
  }
}

  //FILTER OUT THE SESSIONS BASED ON THE SELECTED TASK
  Future<void> fetchMatchingSessions() async {
    safePrint('TRIGGERED THE MATCHING EVENT');

    //POPULATE THE MAP
    for (Session session in sessions) {
      String currTaskID = session.taskID!;
      if (!taskSessionsMap.containsKey(currTaskID)) {
        taskSessionsMap[currTaskID] = [];
      }
      taskSessionsMap[currTaskID]!.add(session);
    }
    safePrint('MAP: $taskSessionsMap');
  }

  Future<void> fetchSelectedTask() async {
    try {
      final task = await queryTaskByID(widget.task.id);
      if (task != null) {
        setState(() {
          safePrint("TASK");
          selectedTask = task;
        });
      } else {
        safePrint('Selected task not found');
      }
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
  }

  Future<Task?> queryTaskByID(String taskID) async {
    try {
      final request = ModelQueries.get(
          Task.classType,
          TaskModelIdentifier(
              id: taskID)); // Use ModelQuery.get to fetch a single task by ID
      final response = await Amplify.API.query(request: request).response;

      final task = response.data;
      if (task == null) {
        safePrint('errors: ${response.errors}');
      }
      safePrint("Query for evaluation notes screen sucessful");
      return task;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  Future<void> fetchJudgementCall() async {
    try {
      final judgementCall = await queryJudgementCall(widget.task.id, widget.trainee.id);
      if (judgementCall != null && judgementCall.isNotEmpty) {
        setState(() {
          widget.judgementCalls = judgementCall;
        });
        
      } else {
        safePrint('Judgement call not found');
      }
    } catch (e) {
      safePrint('Error fetching judgement call: $e');
    }
  }

  Future<void> fetchTaskFeeling() async {
    try {
      final taskFeeling = await queryTaskFeeling(widget.task.id, widget.trainee.id);
      if (taskFeeling != null && taskFeeling.isNotEmpty) {
        setState(() {
          widget.taskFeelings = taskFeeling;
        });
        
      } else {
        safePrint('Task feeling not found');
      }
    } catch (e) {
      safePrint('Error fetching task feeling: $e');
    }
  }


  Future<List<JudgementCall>?> queryJudgementCall(String taskID, String traineeID) async {
    try {
      final request = ModelQueries.list(
        JudgementCall.classType,
        where: JudgementCall.TRAINEEID.eq(traineeID) & JudgementCall.TASKID.eq(taskID),
      );
      final response = await Amplify.API.query(request: request).response;

      final judgementCalls = response.data?.items;
      if (judgementCalls == null) {
        safePrint('errors: ${response.errors}');
      }

      return judgementCalls?.cast<JudgementCall>();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  Future<List<TaskFeeling>?> queryTaskFeeling(String taskID, String traineeID) async {
    try {
      final request = ModelQueries.list(
        TaskFeeling.classType,
        where: TaskFeeling.TRAINEEID.eq(traineeID) & TaskFeeling.TASKID.eq(taskID),
      );
      final response = await Amplify.API.query(request: request).response;

      final taskFeelings = response.data?.items;
      if (taskFeelings == null) {
        safePrint('errors: ${response.errors}');
      }

      return taskFeelings?.cast<TaskFeeling>();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  // Fetch latest judgment call
// Fetch latest judgement call
Future<JudgementCall?> fetchLatestJudgementCall(String taskID, String traineeID) async {
  try {
    final judgementCalls = await queryJudgementCall(taskID, traineeID);
    if (judgementCalls != null && judgementCalls.isNotEmpty) {
      // Sort judgement calls by createdAt in descending order to get the latest one
      judgementCalls.sort((a, b) {
        // Handle null values for createdAt
        final aCreatedAt = a.createdAt ?? TemporalDateTime(DateTime.now());
        final bCreatedAt = b.createdAt ?? TemporalDateTime(DateTime.now());
        return bCreatedAt.compareTo(aCreatedAt);
      });
      return judgementCalls.first;
    } else {
      safePrint('No judgement call found');
      return null;
    }
  } catch (e) {
    safePrint('Error fetching judgement call: $e');
    return null;
  }
}

Future<TaskFeeling?> fetchLatestTaskFeeling(String taskID, String traineeID) async {
  try {
    final taskFeelings = await queryTaskFeeling(taskID, traineeID);
    if (taskFeelings != null && taskFeelings.isNotEmpty) {
      // Sort judgement calls by createdAt in descending order to get the latest one
      taskFeelings.sort((a, b) {
        // Handle null values for createdAt
        final aCreatedAt = a.createdAt ?? TemporalDateTime(DateTime.now());
        final bCreatedAt = b.createdAt ?? TemporalDateTime(DateTime.now());
        return bCreatedAt.compareTo(aCreatedAt);
      });
      return taskFeelings.first;
    } else {
      safePrint('No judgement call found');
      return null;
    }
  } catch (e) {
    safePrint('Error fetching judgement call: $e');
    return null;
  }
}

  // Function to fetch all task notes
  Future<void> fetchAllTaskNotes() async {
    try {
      final taskNotes = await queryTaskNotes();

      setState(() {
        allTaskNotes = taskNotes;
      });
    } catch (e) {
      print('Error fetching task notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<TaskNotes>> queryTaskNotes() async {
    try {
      final request = ModelQueries.list(TaskNotes.classType);
      final response = await Amplify.API.query(request: request).response;

      final taskNotes = response.data?.items;

      if (taskNotes == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return taskNotes
          .cast<TaskNotes>(); // Cast the task notes to the TaskNotes class
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  //createTaskNotes section
  Future<void> createTaskNotes(String taskTitle, String taskDesc, String taskID) async {
    try {
      final String traineeID =
          widget.trainee.id; // Get the selected trainee's ID
      final aTaskNote = TaskNotes(
        taskTitle: taskTitle,
        taskDesc: taskDesc,
        traineeID: traineeID,
        taskID: taskID 
        // Assign the trainee's ID to the task note
      );
      final req = ModelMutations.create(aTaskNote);
      final res = await Amplify.API.mutate(request: req).response;

      final createdTaskNote = res.data;
      if (createdTaskNote == null) {
        safePrint('errors: ${res.errors}');
        return;
      }
      safePrint('Mutation result: ${createdTaskNote.taskTitle}');
    } on ApiException catch (e) {
      safePrint('Mutation Failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.task.taskTitle ?? ''),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SupportSettings(title: 'Settings');
                }));
              },
              // To add functionality to settings
              iconSize: 45,
              icon: Icon(Icons.settings),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Question
              _notesQuestion(),
              // TextField
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  child: _notesTextBox()),
              // Buttons
              SizedBox(height: 50),
              _addNoteButton(),
              _skipButton(context)
            ],
          ),
        ));
  }

  // Question
  Widget _notesQuestion() => Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
                'What could ${widget.trainee.firstName} improve on?', // need to insert trainee name here, may need to make a trainee class, and evaluation extends trainee.
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 45,
                    fontWeight: FontWeight.w500))),
      ]);

  // Textfield
  Widget _notesTextBox() => TextFormField(
        controller: _notesController,
        maxLines: 8,
        // For getting input - mock functionality
        onChanged: (value) {
          setState(() {
            _notesController.text = value.toString();
          });
        },

        style: TextStyle(
          fontFamily: "Lexend Exa",
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),

        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            hintText: "Write note here",
            hintStyle: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w300),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none)),
      );

  // Buttons
  Widget _addNoteButton() => ElevatedButton(
      onPressed: () async {
        await createSessionWithLatestJudgementCall(widget.trainee.id, widget.task.id);
        _submitNote();
      },
      child: Text("ADD NOTE"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(500, 100),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 40,
            fontFamily: 'Lexend Exa',
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.pink[900],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));

  Widget _skipButton(context) => TextButton(
      onPressed: () async {
        await createSessionWithLatestJudgementCall(widget.trainee.id, widget.task.id);
        _submitNote();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SupportEvaluate(
              title: "Evaluation", trainee: widget.trainee, task: widget.task);
        }));
      },
      child: Text(
        'Skip',
        style: TextStyle(
          fontFamily: 'Lexend Exa',
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.pink[900],
          decoration: TextDecoration.underline,
        ),
      ));

  // Helper function for addNoteButton
  void _submitNote() async {
    String description = _notesController.text;
    if (_notesController.text.isNotEmpty) {
      // Save the note -- pending backend functionality
      await createTaskNotes(
          widget.task.taskTitle ?? '', description, widget.task.id); // Create the task note
      await fetchAllTaskNotes();

      NoteItem newNote = NoteItem(
          "${widget.task.taskTitle} Evaluation", _notesController.text);

      // Clear the text field
      _notesController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SupportEvaluate(
                  title: "Evaluation",
                  trainee: widget.trainee,
                  task: widget.task,
                )), // To change
      );
    }
    
  }

  Future<List<CurrTask?>> queryCurrTask(String traineeID) async {
    try {
      final request = ModelQueries.list(CurrTask.classType,
          where: CurrTask.TRAINEEID.eq(traineeID));
      final response = await Amplify.API.query(request: request).response;
      safePrint('Testing!');

      final currTask = response.data?.items;
      safePrint(currTask);
      if (currTask == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return currTask;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<void> fetchCurrentTask() async {
    try {
      final currentTask = await queryCurrTask(widget.trainee.id);
      if (currentTask.isNotEmpty) {
        setState(() {
          currentTasks = currentTask.cast<CurrTask>();
        });
      } else {
        safePrint('No current task found');
      }
    } catch (e) {
      print('Error fetching current task: $e');
    }
  }

  //CREATES A NEW SESSION
  Future<void> createSessionWithLatestJudgementCall(String traineeID, String taskID) async {
  try {
    // Fetch the latest judgment call
    final latestJudgementCall = await fetchLatestJudgementCall(taskID, traineeID);
    final latestTaskFeeling = await fetchLatestTaskFeeling(taskID, traineeID);
    if (latestJudgementCall == null) {
      safePrint('No judgement call available for creating session');
      return;
    }
    if (latestTaskFeeling == null) {
      safePrint('No task feeling available for creating session');
      return;
    }

    // Create session with latest judgement call
    List<String> evals = [
      _notesController.text,
      latestTaskFeeling.feeling ?? '',
      latestJudgementCall.call ?? '',
    ];

    List<Sess> newSL = [];
    final newSession = Sess(aSess: evals);
    newSL.add(newSession);
    final session = Session(traineeID: traineeID, taskID: taskID, sessionList: newSL);

    final createReq = ModelMutations.create(session);
    final createRes = await Amplify.API.mutate(request: createReq).response;

    final createdSess = createRes.data;
    if (createdSess == null) {
      safePrint('Error creating session: ${createRes.errors}');
      return;
    }
    safePrint('Session created successfully!');
    safePrint(createdSess);
  } catch (e) {
    safePrint('Error creating a session: $e');
  }
}
  // Pop-up dialog for when addNoteButton - to add
}