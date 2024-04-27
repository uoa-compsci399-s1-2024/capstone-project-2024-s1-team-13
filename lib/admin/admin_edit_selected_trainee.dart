// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:inka_test/items/trainee_item.dart';

class AdminEditSelectedTrainee extends StatefulWidget {
  AdminEditSelectedTrainee(
      {super.key, required this.title, required this.trainee});
  final String title;
  TraineeItem trainee;

  @override
  AdminEditSelectedTraineeState createState() =>
      AdminEditSelectedTraineeState();
}

class AdminEditSelectedTraineeState extends State<AdminEditSelectedTrainee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _imagePath;

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
                //Pending backend functionality - should save edits
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: Icon(Icons.done_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Body of screen
        // Body of screen
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TraineeImage(),
              SizedBox(height: 100),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 196, 155, 175),
                      image: DecorationImage(
                        image: AssetImage(widget.trainee.assetImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.photo_camera_rounded,
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
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 20),
          Text(
            "Change Photo",
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
        Text(
          "Name",
          style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
            controller: _firstNameController,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "${widget.trainee.firstName}",
              hintStyle: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
        SizedBox(height: 30),

        // Trainee Surname
        Text(
          "Surname",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _lastNameController,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "${widget.trainee.lastName}",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
      ]);
}
