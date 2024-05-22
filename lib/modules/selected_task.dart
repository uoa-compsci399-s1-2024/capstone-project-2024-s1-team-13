import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/modules/modules_settings.dart';
import 'package:inka_test/models/Task.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SelectedTask extends StatefulWidget {
  const SelectedTask({super.key, required this.title, required this.taskId});

  final String title;
  final String taskId;

  @override
  _SelectedTaskState createState() => _SelectedTaskState();
}

class _SelectedTaskState extends State<SelectedTask> {
  Task? selectedTask;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _configureTts(); // Configure TTS settings
    fetchSelectedTask();
  }

  Future<void> _configureTts() async {
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.2);
  }

  Future<void> fetchSelectedTask() async {
    try {
      final task = await queryTaskById(widget.taskId);

      setState(() {
        selectedTask = task!;
      });
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
  }

  Future<Task?> queryTaskById(String taskId) async {
    try {
      final request =
          ModelQueries.get(Task.classType, TaskModelIdentifier(id: taskId));
      final response = await Amplify.API.query(request: request).response;

      final task = response.data;
      if (task == null) {
        safePrint('errors: ${response.errors}');
      }
      return task;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

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
      safePrint('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }

  int _currentPageIndex = 0;

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
          },
        ),
      ),
      body: selectedTask != null ? buildTaskContent() : buildLoadingIndicator(),
    );
  }

  Widget buildTaskContent() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: selectedTask!.taskStep?.length ?? 0,
            itemBuilder: (context, index) {
              String description = selectedTask!.taskStep != null &&
                      selectedTask!.taskStep!.isNotEmpty
                  ? selectedTask!.taskStep![index]
                  : '';

              Future<String> url = getDownloadUrl(
                key: selectedTask!.taskStepImage![index] ?? "",
                accessLevel: StorageAccessLevel.guest,
              );

              return FutureBuilder<String>(
                future: url,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String image = snapshot.data ?? "";
                    TasksStep step = TasksStep(
                      stepNumber: index + 1,
                      description: description,
                      stepImage: image,
                    );
                    return StepScreen(step: step, flutterTts: flutterTts);
                  }
                },
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
          child: Row(
            children: [
              Expanded(
                child: selectedTask!.taskStep != null &&
                        selectedTask!.taskStep!.isNotEmpty
                    ? LinearProgressIndicator(
                        value: (_currentPageIndex + 1) /
                            selectedTask!.taskStep!.length,
                        borderRadius: BorderRadius.circular(50),
                        minHeight: 30,
                        backgroundColor: Colors.grey[350],
                        color: Colors.pink[900],
                      )
                    : LinearProgressIndicator(
                        value: 0.0,
                        borderRadius: BorderRadius.circular(50),
                        minHeight: 30,
                        backgroundColor: Colors.grey[350],
                        color: Colors.pink[900],
                      ),
              ),
              const SizedBox(width: 10),
              Text(
                selectedTask?.taskStep != null &&
                        selectedTask!.taskStep!.isNotEmpty
                    ? '${(((_currentPageIndex + 1) / selectedTask!.taskStep!.length) * 100).toInt()}%'
                    : '0%',
                style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TasksStep {
  final int stepNumber;
  final String description;
  final String stepImage;

  TasksStep({
    required this.stepNumber,
    required this.description,
    required this.stepImage,
  });
}

class StepScreen extends StatelessWidget {
  final TasksStep step;
  final FlutterTts flutterTts;

  const StepScreen({super.key, required this.step, required this.flutterTts});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 196, 155, 175),
              ),
              child: Center(
                child: Text(
                  '${step.stepNumber}',
                  style: const TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 620,
              child: Text(
                step.description,
                style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up, size: 45, color: Colors.pink[900]),
              onPressed: () async {
                await flutterTts.speak(step.description);
              },
            ),
          ],
        ),
        const SizedBox(height: 50),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Image.network(
            step.stepImage,
            width: 700,
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
