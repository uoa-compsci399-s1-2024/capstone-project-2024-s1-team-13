import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_task.dart';
import 'package:inka_test/admin/admin_edit_selected_task.dart';
import 'package:inka_test/modules/module_items/task_item.dart';
import 'package:auto_size_text/auto_size_text.dart';

//------------------------------------------------------------
//AMPLIFY IMPORTS --------------------------------------------
//------------------------------------------------------------
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:inka_test/models/Task.dart';

//------------------------------------------------------------

class AdminEditTasks extends StatefulWidget {
  const AdminEditTasks({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _AdminEditTasksState createState() => _AdminEditTasksState();
}

class _AdminEditTasksState extends State<AdminEditTasks> {
  //------------------------------------------------------------
  //GLOBAL VARIABLES -------------------------------------------
  //------------------------------------------------------------
  late List<Task> allTasks = []; // List to store all tasks
  final TextEditingController _textController = TextEditingController();
  late List<Task> searchResults = []; // For autocomplete
  Task? selectedTask;

  //------------------------------------------------------------
  //INITSTATE() ------------------------------------------------
  //------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    fetchAllTask(); // Call the function to fetch all task notes
  }

  //------------------------------------------------------------
  //FUNCTIONS SECTION ------------------------------------------
  //------------------------------------------------------------

  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allTasks
          .where((task) =>
              task.taskTitle!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchAllTask() async {
    try {
      final task = await queryTask();

      setState(() {
        allTasks = task.cast<Task>();
      });
    } catch (e) {
      safePrint('Error fetching task notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<Task>> queryTask() async {
    try {
      final request = ModelQueries.list(Task.classType);
      final response = await Amplify.API.query(request: request).response;

      final task = response.data?.items;
      if (task == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return task.cast<Task>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final req = ModelMutations.deleteById(
        Task.classType,
        TaskModelIdentifier(id: taskId),
      );

      final res = await Amplify.API.mutate(request: req).response;
      safePrint('The task has been deleted!: $res');

      setState(() {
        allTasks.removeWhere((task) => task.id == taskId);
      });
    } catch (e) {
      safePrint('Error deleting task: $e');
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
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminAddTask(title: 'Add Task');
              }));
            },
            iconSize: 60,
            icon: const Icon(Icons.add_rounded),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),

      // Grid View
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: _buildTaskSearchBar(context),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchAllTask,
              child: searchResults.isEmpty && _textController.text.isNotEmpty
                  ? Center(
                      child: Text(
                      'No tasks found',
                      style: TextStyle(
                        fontFamily: "Lexend Exa",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ))
                  : GridView.builder(
                      itemCount: searchResults.isNotEmpty
                          ? searchResults.length
                          : allTasks.length,
                      itemBuilder: (context, index) {
                        final task = searchResults.isNotEmpty
                            ? searchResults[index]
                            : allTasks[
                                index]; // Use filtered results or allTasks
                        return FutureBuilder<String>(
                          future: getDownloadUrl(
                            key: task.taskCoverImage!,
                            accessLevel: StorageAccessLevel.guest,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminEditSelectedTask(
                                              title: 'Edit ${task.taskTitle}',
                                              task: task),
                                    ),
                                  );
                                },
                                child: _buildTaskCard(
                                    task.taskTitle ?? "Task Title Not Found",
                                    snapshot.data ??
                                        "", 
                                    task.id),
                              );
                            }
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.vertical,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Search Bar
  Widget _buildTaskSearchBar(context) {
    final maxListHeight = MediaQuery.of(context).size.height * 0.3;
    final itemHeight = 70.0;
    final listItemWidth = MediaQuery.of(context).size.width * 0.95;

    return Autocomplete<Task>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Task>.empty();
        }
        return allTasks.where((task) => task.taskTitle!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (Task selectedTask) {
        setState(() {
          searchResults = [selectedTask];
          this.selectedTask = selectedTask;
          _textController.text = '${selectedTask.taskTitle}';
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: _textController,
          focusNode: focusNode,
          onChanged: _onSearchTextChanged,
          style: TextStyle(
            fontSize: 27, // Adjust the font size here
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 40),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: IconButton(
                icon: Icon(Icons.clear_rounded,
                    color: Colors.grey[600], size: 40),
                onPressed: () {
                  _textController.clear();
                  _onSearchTextChanged('');
                },
              ),
            ),
            hintText: "Search Tasks",
            hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }

  String _getTitle(int index) {
    if (index < allTasks.length) {
      return allTasks[index].taskTitle ??
          "Task Title Not Found"; // Providing a default value if taskTitle is null
    } else {
      return "Task Title Not Found"; // Fallback title if index exceeds the length of allTasks
    }
  }

  String _getUrl(int index) {
    if (index < allTasks.length) {
      String? imageUrl = allTasks[index].taskCoverImage;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        return imageUrl;
        // Return the task cover image URL if it's not null or empty
      } else {
        return ""; // Return an empty string as a fallback if the URL is null or empty
      }
    } else {
      return ""; // Fallback if index exceeds the length of allTasks
    }
  }

  // Task Card
  Widget _buildTaskCard(
          String title, String taskCoverImageUrl, String currTaskId) =>
      Card(
        margin: const EdgeInsets.all(20),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 260, 
              width: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Image.network(taskCoverImageUrl,
                    fit: BoxFit.cover), // Use BoxFit.contain
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1, // Limit the text to a single line
                        minFontSize: 10, 
                        overflow: TextOverflow
                            .ellipsis, 
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => deleteTaskDialog(
                        context, currTaskId), 
                    //_deleteTask(context, mockTasks.indexOf(atask)),
                    icon: const Icon(Icons.remove_circle_rounded),
                    iconSize: 50,
                    color: Colors.red[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  //Delete selected task
  void deleteTaskDialog(BuildContext context, String currTaskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: const Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this task?',
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
                    deleteTask(currTaskId);
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
