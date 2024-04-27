import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inka_test/support/support_notifications.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';
import 'package:inka_test/support/support_items/trainee_item.dart';

class SupportTrainees extends StatelessWidget {
  SupportTrainees({Key? key, required this.title}) : super(key: key);
  final String title;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.arrow_back_ios_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SupportSettings(title: 'Settings');
                }));
              },
              // To add functionality to settings
              iconSize: 45,
              icon: Icon(Icons.settings),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(25),
                child: _buildTraineeSearchBar(context)),
            Expanded(
                child: ListView.builder(
              itemCount: mockTrainees.length,
              itemBuilder: (context, index) {
                final trainee = mockTrainees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupportTraineeDashboard(
                                traineeName: trainee.firstName)));
                  },
                  child: _TraineeCard(trainee),
                );
              },
            ))
          ],
        ));
  }

  // Search Bar
  Widget _buildTraineeSearchBar(context) => TextField(
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
          hintText: "Search Trainees",
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

  // Trainee Card
  Widget _TraineeCard(trainee) => Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(

          // Avatar containg image - set as leading for Card instance, needs fixing
          leading: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(trainee.assetImage),
              ),
            ),
          ),
          title: Padding(
              padding: EdgeInsets.only(top: 100, bottom: 100),
              child: Text('${trainee.firstName} ${trainee.lastName}',
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 40,
                      fontWeight: FontWeight.w500)))));

  //Mock Data
  final List<TraineeItem> mockTrainees = [
    TraineeItem(
        firstName: 'John',
        lastName: 'Doe',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Tom',
        lastName: 'Stevens',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Clark',
        lastName: 'Johnson',
        assetImage: 'assets/images/trainee_placeholder.jpeg'),
    TraineeItem(
        firstName: 'Sam',
        lastName: 'Wood',
        assetImage: 'assets/images/trainee_placeholder.jpeg')
  ];
}
