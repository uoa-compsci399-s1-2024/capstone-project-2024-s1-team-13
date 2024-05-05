import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

//------------------------------------------------------------
//AMPLIFY IMPORTS --------------------------------------------
//------------------------------------------------------------
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/ModelProvider.dart';

//------------------------------------------------------------

class AdminEditSelectedTask extends StatefulWidget {
  final String title;
  final Task task;
  const AdminEditSelectedTask({super.key, required this.title, required this.task});

  @override
  _AdminEditSelectedTaskState createState() => _AdminEditSelectedTaskState();
}

class _AdminEditSelectedTaskState extends State<AdminEditSelectedTask> {

  //------------------------------------------------------------
  //GLOBAL VARIABLES -------------------------------------------
  //------------------------------------------------------------

  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _stepDescriptionController = TextEditingController();
  String? _imagePath;

  late String retTaskTitle;
  late String globalTaskId;
  late String globalAdminId;
  late String globalCoverImageUrl;
  List<String> taskSteps = [];
  List<String> taskStepImages = [];

  //------------------------------------------------------------
  //INITSTATE() ------------------------------------------------
  //------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    taskSteps = widget.task.taskStep!;
    taskStepImages = widget.task.taskStepImage!;
    globalTaskId = widget.task.id;
    globalAdminId = widget.task.adminID;
    globalCoverImageUrl = widget.task.taskCoverImage!;
    _taskTitleController = TextEditingController(text: widget.task.taskTitle);
    _stepDescriptionController = TextEditingController(text: widget.task.taskStep?[0]);
  }

  //------------------------------------------------------------
  //FUNCTIONS SECTION ------------------------------------------
  //------------------------------------------------------------

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


  Future<String?> uploadImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: false,
      withReadStream: true,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );

    if (result == null) {
      safePrint('No file selected');
      return null;
    }

    final platformFile = result.files.single;
    try {
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        key: platformFile.name,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;

      // Set the uploaded image key in the state
      setState(() {
        globalCoverImageUrl = platformFile.name;
      });

      // Return the key instead of the URL
      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }
  //UPLOADSTEPIMAGE [HAVE TO ADD]
  Future<String?> uploadStepImage(int stepNumber) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    withData: false,
    withReadStream: true,
    allowedExtensions: ['jpg', 'png', 'gif'],
  );

  if (result == null) {
    safePrint('No file selected');
    return null;
  }

  final platformFile = result.files.single;
  try {
    final uploadResult = await Amplify.Storage.uploadFile(
      localFile: AWSFile.fromStream(
        platformFile.readStream!,
        size: platformFile.size,
      ),
      key: platformFile.name,
      onProgress: (progress) {
        safePrint('Fraction completed: ${progress.fractionCompleted}');
      },
    ).result;

    final url = await getDownloadUrl(key: platformFile.name, accessLevel: StorageAccessLevel.guest);
    print('Uploaded image URL for Step $stepNumber: $url');
    
    // Return the key instead of the URL
    return platformFile.name;
  } on StorageException catch (e) {
    safePrint('Error uploading file: $e');
    rethrow;
  }
}

  
  

  Future<void> updateTask(String retTaskTitle, List<String> retTaskSteps) async {
    try {
      final updatedTask = Task(
        id: globalTaskId,
        taskTitle: retTaskTitle,
        taskStep: retTaskSteps,
        adminID: globalAdminId,
        taskCoverImage: globalCoverImageUrl, //acc not the url but the key
        taskStepImage: taskStepImages
      );

      final req = ModelMutations.update(updatedTask);
      final res = await Amplify.API.mutate(request: req).response;
      safePrint('The task has been edited!: $res');

    } catch (e) {
      safePrint('Error editing task: $e');
    }
  }

  //DELETESTEP [WIP]
  void deleteStep(int index) {
    if (index >= 0 && index < taskSteps.length) {
      setState(() {
        taskSteps.removeAt(index);
      });
    } else {
      safePrint('Invalid index!: $index');
    }   
  }

  Future<void> _refresh() async {
    setState(() {
      taskSteps = taskSteps;
    });
  }

  //------------------------------------------------------------
  //SCREEN BUILD -----------------------------------------------
  //------------------------------------------------------------

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
                saveTask();
                retTaskTitle = _taskTitleController.text;
                updateTask(retTaskTitle, taskSteps);
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: const Icon(Icons.done_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        body: RefreshIndicator(
          onRefresh: _refresh,

        // Grid View
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(padding: const EdgeInsets.all(25), child: _TaskTitle()),
            ),
            const SizedBox(height: 30),
            Expanded(
                child: ListView.builder(
              itemCount:
                  taskSteps.length, //Pending backend functionality - should increment dynamically
              itemBuilder: (context, index) {
                return _StepCard(context, taskSteps[index], index + 1);
              },
            )),
            const SizedBox(height: 20),
            _AddStepButton(),
            const SizedBox(height: 30)
          ],
        )));
  }

  // Task Title - text form field and image

  Widget _TaskTitle() => Row(
  children: [
    // Task Title
    Expanded(
      child: TextField(
        controller: _taskTitleController,
        style: const TextStyle(
          fontFamily: "Lexend Exa",
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          hintText: "Enter task name",
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
      )),
    const SizedBox(width: 20),
    InkWell(
      onTap: () async {
        // Implement image uploading functionality for title image
        String? url = await uploadImage();
        if (url != null) {
          // Update the state with the uploaded image URL
          setState(() {
            globalCoverImageUrl = url;
          });
        } else {
          // Handle the case where the upload failed
          // You may want to display a message to the user
        }
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.grey[300],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: globalCoverImageUrl != null
              ? FutureBuilder(
                  future: getDownloadUrl(key: globalCoverImageUrl!, accessLevel: StorageAccessLevel.guest),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display a loading indicator while waiting for the URL
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Display an error message if there is an error
                    } else {
                      return Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                )
              : Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: Colors.grey[600],
                  ),
                ),
        ),
      ),
    ),
  ],
);



  // Step Card
  Widget _StepCard(BuildContext context, String step, int stepNumber) {
  String? stepImageKey = taskStepImages.length >= stepNumber ? taskStepImages[stepNumber - 1] : null;
  return Card(
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    elevation: 2,
    color: Colors.white,
    child: ListTile(
      title: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 196, 155, 175),
              ),
              child: Center(
                child: Text(
                  '$stepNumber',
                  style: const TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'Step $stepNumber',
              style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
                onPressed: () {
                   _deleteStep(context, stepNumber);
                },
                icon: const Icon(Icons.remove_circle_rounded),
                iconSize: 50,
                color: Colors.red[600],
              ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _stepDesc(stepNumber, stepImageKey),
      ),
    ),
  );
}

Widget _stepDesc(int stepNumber, String? stepImageKey) {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          initialValue: taskSteps[stepNumber - 1], // Set initial value based on step text
          onChanged: (value) {
            setState(() {
              taskSteps[stepNumber - 1] = value; // Update step text in the data structure
            });
          },
          maxLines: 4,
          style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: "Enter instruction",
            hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
      InkWell(
        onTap: () async {
          // Implement image uploading functionality
          String? url = await uploadStepImage(stepNumber);
          if (url != null) {
            // Update the state with the uploaded image URL
            setState(() {
              if (taskStepImages.length >= stepNumber) {
                taskStepImages[stepNumber - 1] = url;
              } else {
                taskStepImages.add(url);
              }
            });
          } else {
            // Handle the case where the upload failed
            // You may want to display a message to the user
          }
        },
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: stepImageKey != null
                ? FutureBuilder(
                    future: getDownloadUrl(key: stepImageKey, accessLevel: StorageAccessLevel.guest),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Display a loading indicator while waiting for the URL
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Display an error message if there is an error
                      } else {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  )
                : Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
          ),
        ),
      ),
    ],
  );
}


// Add Step Button
  Widget _AddStepButton() => ElevatedButton(
        onPressed: () {
          setState(() {
            taskSteps.add('');
          });
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(800, 100),
            foregroundColor: Colors.pink[900],
            textStyle: const TextStyle(
              fontSize: 35,
              fontFamily: 'Lexend Exa',
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: const Text('+ ADD STEP'),
      );

  // Step Card Helper Widget - Step Number
  
  void saveTask() {
    String taskName = _taskTitleController.text;

    // Here you can implement your desired functionality to handle task saving,
    // whether it's storing data locally, using a different API, or any other logic.
    // For example, you can print the task details:
    print('Recipe Name: $taskName');
    print('Steps: $taskSteps');
 
    // You can also show a message to indicate successful saving:
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task saved successfully')),
    );
  }

  //Delete selected task - pending backend functionality
  void _deleteStep(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: const Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this step?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                    deleteStep(index-1);
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
