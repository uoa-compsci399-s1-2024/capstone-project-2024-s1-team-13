import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inka_test/modules/module_items/recipes_step.dart';
import 'package:inka_test/modules/modules_settings.dart';

class SelectedRecipe extends StatefulWidget {
  SelectedRecipe({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SelectedRecipeState createState() => _SelectedRecipeState();
}

class _SelectedRecipeState extends State<SelectedRecipe> {
  int _currentPageIndex = 0;
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
                return const ModulesSettings(title: 'Settings');
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
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                      value: (_currentPageIndex + 1) / mockSteps.length,
                      borderRadius: BorderRadius.circular(50),
                      minHeight: 30,
                      backgroundColor: Colors.grey[350],
                      color: Colors.pink[900]),
                ),
                SizedBox(width: 10),
                Text(
                  '${(((_currentPageIndex + 1) / mockSteps.length) * 100).toInt()}%',
                  style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
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
      ],
    );
  }
}
