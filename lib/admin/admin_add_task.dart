import 'package:flutter/material.dart';

class AdminAddTask extends StatefulWidget {
  AdminAddTask({super.key, required this.title});
  final String title;

  @override
  _AdminAddTaskState createState() => _AdminAddTaskState();
}

class _AdminAddTaskState extends State<AdminAddTask> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _stepDescriptionController =
      TextEditingController();
  String? _imagePath; // Fetches from backend?

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
                //Pending backend functionality
              },
              iconSize: 50,
              icon: Icon(Icons.done_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Grid View
        body: Column(
          children: <Widget>[
            Container(
              child: Padding(padding: EdgeInsets.all(25), child: _TaskTitle()),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
                child: ListView.builder(
              itemCount:
                  1, //Pending backend functionality - should increment dynamically
              itemBuilder: (context, currentNumber) {
                return _StepCard();
              },
            )),
            SizedBox(height: 20),
            _AddStepButton(),
            SizedBox(height: 30)
          ],
        ));
  }

  // Task Title - text form field and image
  Widget _TaskTitle() => Row(
        children: [
          // Task Title
          Expanded(
              child: TextField(
            controller: _taskTitleController,
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              hintText: "Enter task name",
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
          )),

          // Task Image
          SizedBox(width: 20),
          _imagePath == null
              ? InkWell(
                  //onTap: // pending backend functionality,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.grey[300]),
                    child: Center(
                      child: Icon(Icons.add_a_photo,
                          size: 40, color: Colors.grey[600]),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                          image: AssetImage(_imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _imagePath = null;
                          });
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ],
      );

  // Step Card

  Widget _StepCard() => Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 196, 155, 175),
                  ),
                  child: Center(
                      child: Text(
                    '1', // Pending backend functionality
                    style: TextStyle(
                        fontFamily: "Lexend Exa",
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))),
              SizedBox(width: 20),
              Text('Step One', // Pending backend functionality
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 40,
                      fontWeight: FontWeight.w500)),
            ]),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _stepDesc(),
          )));

// Step Card helper widget - text field
  Widget _stepDesc() => Row(
        children: [
          // Text Form Field - pending backend functionality
          Expanded(
              child: TextFormField(
                  controller: _stepDescriptionController,
                  maxLines: 4,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: "Enter instruction",
                    hintStyle: TextStyle(
                        fontFamily: "Lexend Exa",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                  ))),

          // Upload image here
          SizedBox(width: 20),
          _imagePath == null
              ? InkWell(
                  //onTap: // pending backend functionality,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.grey[300]),
                    child: Center(
                      child: Icon(Icons.add_a_photo,
                          size: 40, color: Colors.grey[600]),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                          image: AssetImage(_imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _imagePath = null;
                          });
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),

          // Image insertion - will insert default image if image not provided
        ],
      );

// Add Step Button

  Widget _AddStepButton() => ElevatedButton(
        onPressed: () {
          // Pending backend functionality, mock functionality below:
        },
        child: Text('+ ADD STEP'),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(800, 100),
            foregroundColor: Colors.pink[900],
            textStyle: TextStyle(
              fontSize: 35,
              fontFamily: 'Lexend Exa',
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
      );
}
