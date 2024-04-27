import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_task.dart';
import 'package:inka_test/admin/admin_edit_selected_task.dart';
import 'package:inka_test/modules/module_items/task_item.dart';

class AdminEditTasks extends StatefulWidget {
  AdminEditTasks({super.key, required this.title});
  final String title;

  @override
  _AdminEditTasksState createState() => _AdminEditTasksState();
}

class _AdminEditTasksState extends State<AdminEditTasks> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                  return AdminAddTask(title: 'Add Task'); // To change route
                }));
              },
              iconSize: 60,
              icon: Icon(Icons.add_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(25), child: _buildTaskSearchBar(context)),
          Expanded(
              child: GridView.builder(
                  itemCount:
                      mockTasks.length, //Placeholder list - backend pending.
                  itemBuilder: (context, index) {
                    final task =
                        mockTasks[index]; //Placeholder list - backend pending.
                    return GestureDetector(
                        onTap: () {
                          // Navigate to the desired screen when a task card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminEditSelectedTask(
                                  title: 'Edit ${task.title}'),
                            ),
                          );
                        },
                        child: _buildTaskCard(task));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //crossAxisSpacing: 5,
                    //mainAxisSpacing: 5,
                  ),
                  scrollDirection: Axis.vertical))
        ]));
  }

  // Search Bar
  Widget _buildTaskSearchBar(context) => TextField(
        controller: _textController,
        style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Tasks",
          hintStyle: TextStyle(
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

  // Task Card
  Widget _buildTaskCard(task) => Card(
      margin: EdgeInsets.all(20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Image.asset(task.assetImage, fit: BoxFit.fill)),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        task.title,
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      )),
                  IconButton(
                    onPressed: () =>
                        _deleteTask(context, mockTasks.indexOf(task)),
                    icon: Icon(Icons.remove_circle_rounded),
                    iconSize: 50,
                    color: Colors.red[600],
                  )
                ]),
          )
        ],
      ));

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
          title: Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this task?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 35,
                      fontWeight: FontWeight.w500))),
          actionsPadding: EdgeInsets.only(bottom: 60),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  child: Text("NO"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 100),
                      textStyle: TextStyle(
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
                  }),
              SizedBox(width: 20),
              ElevatedButton(
                  child: Text("YES"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 100),
                      textStyle: TextStyle(
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
                  })
            ])
          ],
        );
      },
    );
  }
}
