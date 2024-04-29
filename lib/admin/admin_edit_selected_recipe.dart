import 'package:flutter/material.dart';

class AdminEditSelectedRecipe extends StatefulWidget {
  const AdminEditSelectedRecipe({super.key, required this.title});
  final String title;

  @override
  _AdminEditSelectedRecipeState createState() =>
      _AdminEditSelectedRecipeState();
}

// Overall UI layout for editing a recipe - should fetch details from backend.

class _AdminEditSelectedRecipeState extends State<AdminEditSelectedRecipe> {
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
              icon: const Icon(Icons.arrow_back_ios),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                //Pending backend functionality - should save edits
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: const Icon(Icons.done_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Grid View
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
              child:
                  Padding(padding: const EdgeInsets.all(25), child: _RecipeTitle()),
            ),
            const SizedBox(height: 30),
            Expanded(
                child: ListView.builder(
              itemCount:
                  1, //Pending backend functionality - should increment dynamically
              itemBuilder: (context, index) {
                return _StepCard();
              },
            )),
            const SizedBox(height: 20),
            _AddStepButton(),
            const SizedBox(height: 30)
          ],
        ));
  }

  // Task Title - text form field and image
  Widget _RecipeTitle() => Row(
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
          )),

          // Task Image
          const SizedBox(width: 20),
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
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ],
      );

  // Step Card

  Widget _StepCard() => Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepNumber(),
              IconButton(
                onPressed: () {
                  //Pending backend functionality - delete selected step
                  _deleteStep(context);
                },
                icon: const Icon(Icons.remove_circle_rounded),
                iconSize: 60,
                color: Colors.red[600],
              )
            ],
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
                  style: const TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
          const SizedBox(width: 20),
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
                        child: const Icon(Icons.close, color: Colors.white),
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
  Widget _StepNumber() => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 196, 155, 175),
              ),
              child: const Center(
                  child: Text(
                '1', // Pending backend functionality
                style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ))),
          const SizedBox(width: 20),
          const Text('Step One', // Pending backend functionality
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 40,
                  fontWeight: FontWeight.w500)),
        ]),
      );

  //Delete selected task - pending backend functionality
  void _deleteStep(BuildContext context) {
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
                    // Remove the step - pending backend functionality
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
