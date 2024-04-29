import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_task.dart';
import 'package:inka_test/admin/admin_edit_selected_task.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/modules/module_items/task_item.dart';

class AdminEditTasks extends StatefulWidget {
  const AdminEditTasks({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _AdminEditTasksState createState() => _AdminEditTasksState();
}

class _AdminEditTasksState extends State<AdminEditTasks> {
  late List<Task> allTasks = []; // List to store all tasks
  @override
  void initState() {
    super.initState();
    fetchAllTask(); // Call the function to fetch all task notes
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

  
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(allTasks); 
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminAddTask(title: 'Add Task'); // To change route
                }));
              },
              iconSize: 60,
              icon: const Icon(Icons.add_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(25), child: _buildTaskSearchBar(context)),
          Expanded(
            child: GridView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                final task = allTasks[index]; // Use allTasks instead of mockTasks
                return GestureDetector(
                  onTap: () {
                    // Navigate to the desired screen when a task card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminEditSelectedTask(
                          title: 'Edit ${task.taskTitle}',
                        ),
                      ),
                    );
                  },
                  child: _buildTaskCard(task.taskTitle ?? "Task Title Not Found", task.taskCoverImage ?? ""),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
            ),
          )

        ]));
  }

  // Search Bar
  Widget _buildTaskSearchBar(context) => TextField(
        controller: _textController,
        style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: const EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Tasks",
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
      );

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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: Image.network(taskCoverImageUrl, fit: BoxFit.fill),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Lexend Exa',
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            IconButton(
              onPressed: () => _deleteTask(context, 0), // change this later
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






  //Mock Data
  final List<TaskItem> mockTasks = [
    TaskItem(title: 'Dishes', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(
        title: 'Clear Table', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(
        title: 'Closing', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(title: 'Orders', assetImage: 'assets/images/task_placeholder.jpg'),
    TaskItem(title: 'Opening', assetImage: 'assets/images/task_placeholder.jpg')
  ];

  //Delete selected task - pending backend functionality
  void _deleteTask(BuildContext context, index) {
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
                    // Remove the note from the list
                    mockTasks.remove(mockTasks[index]);
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
