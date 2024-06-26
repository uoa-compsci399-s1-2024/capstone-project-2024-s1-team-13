import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/modules/modules_settings.dart';
import 'package:inka_test/modules/recipes_screen.dart';
import 'package:inka_test/modules/selected_task.dart';
import 'package:inka_test/modules/training_modules.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:inka_test/models/Task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.title});
  final String title;

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Task> searchResults = []; // For autocomplete
  Task? selectedTask;
  final TextEditingController _textController = TextEditingController();
  late List<Task> allTasks = []; // List to store all tasks

  @override
  void initState() {
    super.initState();
    fetchAllTask(); // Call the function to fetch all task notes
  }

  //BACKEND FUNCTIONS
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

  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allTasks
          .where((task) =>
              task.taskTitle!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  //FRONTEND
  @override
  Widget build(BuildContext context) {
    print(allTasks);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ModulesSettings(title: 'Settings');
              }));
            }, // To add functionality to settings
            iconSize: 45,
            icon: const Icon(Icons.settings),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'RECIPES',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: RefreshIndicator(
        onRefresh: fetchAllTask,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: _buildTaskSearchBar(context),
            ),
            Expanded(
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
                      ),
                    )
                  : GridView.builder(
                      itemCount: searchResults.isNotEmpty ||
                              _textController.text.isNotEmpty
                          ? searchResults.length
                          : allTasks.length,
                      itemBuilder: (context, index) {
                        final task = searchResults.isNotEmpty ||
                                _textController.text.isNotEmpty
                            ? searchResults[index]
                            : allTasks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedTask(
                                  title:
                                      task.taskTitle ?? "Task Title Not Found",
                                  taskId: task.id,
                                ),
                              ),
                            );
                          },
                          child: FutureBuilder<String>(
                            future: getDownloadUrl(
                              key: task.taskCoverImage ?? "",
                              accessLevel: StorageAccessLevel.guest,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Placeholder while loading
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final url = snapshot.data;
                                return _buildTaskCard(
                                    task.taskTitle ?? "Task Title Not Found",
                                    url ?? "");
                              }
                            },
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.vertical,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Bar Navigation
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to modules dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TrainingModules(title: 'Modules')));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
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
            fontSize: 27, 
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 40),
            ),
            suffixIcon: IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Icon(Icons.clear_rounded,
                    color: Colors.grey[600], size: 40),
              ),
              onPressed: () {
                _textController.clear();
                _onSearchTextChanged('');
              },
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
  Widget _buildTaskCard(String title, String taskCoverImageUrl) => Card(
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
                ],
              ),
            ),
          ],
        ),
      );
}
