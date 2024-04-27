import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inka_test/modules/module_items/recipes_step.dart';
import 'package:inka_test/support/support_settings.dart';

class SelectedRecipe extends StatelessWidget {
  SelectedRecipe({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
          children: [
            Expanded(
                child: PageView.builder(
                    itemCount: mockSteps.length,
                    itemBuilder: (context, index) {
                      return StepScreen(step: mockSteps[index]);
                    }))
          ],
        ));
  }

  //Mock Data
  final List<RecipesStep> mockSteps = [
    RecipesStep(
        stepNumber: 1,
        description: 'Pipe the batter on the baking sheet.',
        stepImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipesStep(
        stepNumber: 2,
        description: 'Pipe the batter on the baking sheet.',
        stepImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipesStep(
        stepNumber: 3,
        description: 'Pipe the batter on the baking sheet.',
        stepImage: 'assets/images/recipe_placeholder.jpeg')
  ];
}

// Step Screen

class StepScreen extends StatelessWidget {
  final RecipesStep step;

  StepScreen({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Step and instruction
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 196, 155, 175),
                    ),
                    child: Center(
                        child: Text(
                      '${step.stepNumber}',
                      style: TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )))),
            SizedBox(width: 15),
            Container(
                width: 620,
                child: Text(
                  step.description,
                  style: TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),

        // Step image/visual cue

        SizedBox(height: 50),
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Image.asset(
              step.stepImage,
              width: 700,
              height: 500,
              fit: BoxFit.cover,
            )),

        // Next and Back Button
        /*
        SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                // Navigate to the previous step
                // Implement the logic for navigation here
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(275, 100),
                  foregroundColor: Colors.pink[900],
                  textStyle: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.grey[200],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
          SizedBox(width: 150),
          ElevatedButton(
              onPressed: () {
                // Navigate to the next step
                // Implement the logic for navigation here
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(275, 100),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.pink[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
        ]),*/
      ],
    );
  }
}

// Add Linear Progess Indicator somehow...