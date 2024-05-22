import 'package:flutter/material.dart';

//AMPLIFY IMPORTS
import 'package:inka_test/models/Admin.dart';
import 'package:inka_test/models/Task.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

//FILE UPLOAD IMPORT
import 'package:file_picker/file_picker.dart';

class AdminAddTask extends StatefulWidget {
  const AdminAddTask({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AdminAddTaskState createState() => _AdminAddTaskState();
}

class _AdminAddTaskState extends State<AdminAddTask> {
  //GLOBAL VARIABLES
  final TextEditingController _taskTitleController = TextEditingController();
  String? uploadedImageKey;
  List<String> taskSteps = [];
  List<String> taskStepImages= [];
  bool? hasInstructions;

  //BACKEND FUNCTIONS
  Future<Admin?> queryItem(Admin queriedAdmin) async {
    try {
      final request = ModelQueries.get(
        Admin.classType,
        queriedAdmin.modelIdentifier,
      );
      final response = await Amplify.API.query(request: request).response;
      final todo = response.data;
      if (todo == null) {
        safePrint('Error querying item: ${response.errors}');
      }
      return todo;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
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

      setState(() {
        uploadedImageKey = platformFile.name;
      });

      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }

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
      
      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
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

  Future<void> createTask(String taskTitle, List<String> taskStep, String imageKey, List<String> taskStepImages) async {
    try {
      final aTask = Task(
        taskTitle: taskTitle, 
        taskStep: taskStep,
        adminID: 'e7bd6941-2f8f-4949-a4ed-6803cd2ab42b',
        taskCoverImage: imageKey, 
        taskStepImage: taskStepImages,
      );

      final req = ModelMutations.create(aTask);
      final res = await Amplify.API.mutate(request: req).response;

      final createdTask = res.data;
      if (createdTask == null) {
        errorSnackbar();
        safePrint('errors: ${res.errors}');
        return;
      }
      safePrint('Successfully created a task! TASK: ${createdTask.taskTitle}');
    } on ApiException catch (e) {
      errorSnackbar();
      safePrint('Error creating a task: $e');
    }
  }

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

  //SCREEN BUILD
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
        actions: [
          IconButton(
            onPressed: () {
                if (uploadedImageKey != null && _taskTitleController.text.isNotEmpty == true && hasInstructions == true && taskSteps.isNotEmpty == true) {
                  createTask(_taskTitleController.text, taskSteps, uploadedImageKey!, taskStepImages);
                  saveTask();
                } else if (_taskTitleController.text.isEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      elevation: 10,
                      content: Text(
                        'Please add a task title!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink[900]),
                      )),
                  );
                } else if (uploadedImageKey == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    elevation: 10,
                    content: Text(
                      'Please add a task cover image!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink[900]),
                    )),
                  );
                } else if (taskSteps.isEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      elevation: 10,
                      content: Text(
                        'Please add at least 1 task step!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink[900]),
                      )),
                  );
                } else {
                  for (int i = 0; i < taskSteps.length; i++){
                    if (taskSteps[i].isEmpty == true){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          elevation: 10,
                          content: Text(
                            'No instructions in Step ${i+1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Lexend Exa',
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink[900]),
                          )),
                      );
                      hasInstructions = false;
                      break;
                    }
                    hasInstructions = true;
                  }
              }
            },
            iconSize: 50,
            icon: const Icon(Icons.done_rounded),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      body: Column(
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
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: _TaskTitle(),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: taskSteps.length, 
              itemBuilder: (context, index) {
                return _StepCard(context, taskSteps[index], index + 1);
              },
            ),
          ),
          const SizedBox(height: 20),
          _AddStepButton(),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget _TaskTitle() => Row(
    children: [
      Expanded(
        child: TextField(
          controller: _taskTitleController,
          style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
        ),
      ),
      const SizedBox(width: 20),
      // Conditionally render the image container based on whether an image is uploaded
      InkWell(
        onTap: () async {
          String? key = await uploadImage();
            if (key != null) {
              setState(() {
                uploadedImageKey = key;
              });
            }
        },
        child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: uploadedImageKey == null
                  ? Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    )
                  : FutureBuilder<String>(
                      future: getDownloadUrl(key: uploadedImageKey!, accessLevel: StorageAccessLevel.guest),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
            ),
          ),

          Positioned(
            top: 70,
            right: 70,
            child: Icon(
              Icons.add_a_photo,
              size: 40,
              color: Colors.grey[300]!.withOpacity(0.7),
            ),
          ),
          
        ],
      ),
    ),
  ],
);


  Widget _StepCard(BuildContext context, String step, int stepNumber) {
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
          child: _stepDesc(stepNumber),
        ),
      ),
    );
  }

  Widget _stepDesc(int stepNumber) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: taskSteps[stepNumber - 1],
            onChanged: (value) {
              setState(() {
                taskSteps[stepNumber - 1] = value;
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
          String? key = await uploadStepImage(stepNumber);
          if (key != null) {
            setState(() {
              if (taskStepImages.length >= stepNumber) {
                taskStepImages[stepNumber - 1] = key;
              } else {
                taskStepImages.add(key);
              }
            });
          }
        },
        child: Stack(
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: taskStepImages.length >= stepNumber && taskStepImages[stepNumber - 1] != null
                    ? FutureBuilder<String>(
                        future: getDownloadUrl(key: taskStepImages[stepNumber - 1]!, accessLevel: StorageAccessLevel.guest),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
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
              Positioned(
                top: 70,
                right: 70,
                child: Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: Colors.grey[300]!.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _AddStepButton() => ElevatedButton(
    onPressed: () {
      setState(() {
        taskSteps.add('');
        taskStepImages.add('placeholder.png'); //Include placeholder every initialisation, can be updated
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
        borderRadius: BorderRadius.circular(50)
      )
    ),
    child: const Text('+ ADD STEP'),
  );

  //Delete selected task
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
                    Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
                  },
                  child: const Text("YES"))
            ])
          ],
        );
      },
    );
  }
  
  void errorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50))),
        elevation: 10,
        content: Text(
          'Error saving changes!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.pink[900]),
        )),
    );
  }

  void saveTask() {
    String taskName = _taskTitleController.text;

    safePrint('Task Name: $taskName');
    safePrint('Steps: $taskSteps');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50))),
        elevation: 10,
        content: Text(
          'Successfully created a task!',
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