import 'package:flutter/material.dart';

class AdminAddTrainee extends StatefulWidget {
  const AdminAddTrainee({super.key, required this.title});
  final String title;

  @override
  _AdminAddTraineeState createState() => _AdminAddTraineeState();
}

class _AdminAddTraineeState extends State<AdminAddTrainee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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

        // Body of screen
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TraineeImage(),
              const SizedBox(height: 100),
              _TraineeDetails()
            ],
          ),
        ));
  }

  // Trainee Photo
  Widget _TraineeImage() => Column(
        children: [
          _imagePath == null
              ? InkWell(
                  //onTap: // pending backend functionality,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 196, 155, 175)),
                    child: const Center(
                      child: Icon(Icons.add_a_photo,
                          size: 60, color: Colors.white),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
          const SizedBox(height: 20),
          Text(
            "Add Photo",
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]),
          )
        ],
      );

  // Trainee Text Form Fields
  Widget _TraineeDetails() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Trainee Name
        const Text(
          "Name",
          style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
            controller: _firstNameController,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter name",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
        const SizedBox(height: 30),

        // Trainee Surname
        const Text(
          "Surname",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _lastNameController,
            style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter surname",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
      ]);
}
