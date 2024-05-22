import 'package:flutter/material.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/modules/modules_settings.dart';
import 'package:inka_test/models/Recipe.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SelectedRecipe extends StatefulWidget {
  const SelectedRecipe(
      {super.key, required this.title, required this.recipeId});

  final String title;
  final String recipeId; // Add taskId parameter

  @override
  // ignore: library_private_types_in_public_api
  _SelectedRecipeState createState() => _SelectedRecipeState();
}

class _SelectedRecipeState extends State<SelectedRecipe> {
  Recipe? selectedRecipe; // Variable to store the selected task
  //late List<Task> allTasks = []; // List to store all tasks
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    //fetchAllTask(); // Call the function to fetch all task notes
    _configureTts(); // Configure TTS settings
    fetchSelectedRecipe();
  }

  Future<void> fetchSelectedRecipe() async {
    try {
      final recipe =
          await queryRecipeById(widget.recipeId); // Query for the task by ID

      setState(() {
        selectedRecipe = recipe!; // Store the selected task in the state
      });
    } catch (e) {
      safePrint('Error fetching selected task: $e');
    }
  }

  Future<void> _configureTts() async {
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.2);
  }

  Future<Recipe?> queryRecipeById(String recipeId) async {
    try {
      final request = ModelQueries.get(
          Recipe.classType,
          RecipeModelIdentifier(
              id: recipeId)); // Use ModelQuery.get to fetch a single task by ID
      final response = await Amplify.API.query(request: request).response;

      final recipe = response.data;
      if (recipe == null) {
        safePrint('errors: ${response.errors}');
      }
      return recipe;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
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

  int _currentPageIndex = 0;

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
          },
        ),
      ),
      body: selectedRecipe != null
          ? buildRecipeContent()
          : buildLoadingIndicator(), // Check if selectedTask is null
    );
  }

  // Build task content
  // Build task content
  Widget buildRecipeContent() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: selectedRecipe!.recipeStep?.length ?? 0,
            itemBuilder: (context, index) {
              String description = selectedRecipe!.recipeStep != null &&
                      selectedRecipe!.recipeStep!.isNotEmpty
                  ? selectedRecipe!.recipeStep![index]
                  : ''; // Assign empty string if taskStep is null or empty

              Future<String> url = getDownloadUrl(
                key: selectedRecipe!.recipeStepImage![index] ?? "",
                accessLevel: StorageAccessLevel.guest,
              ); // Assign empty string if taskStepImage is null or empty

              return FutureBuilder<String>(
                future: url,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String image = snapshot.data ?? "";
                    RecipesStep step = RecipesStep(
                      stepNumber: index + 1,
                      description: description,
                      stepImage: image,
                    );
                    return StepScreen(step: step, flutterTts: flutterTts);
                  }
                },
              );
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
                child: selectedRecipe!.recipeStep != null &&
                        selectedRecipe!.recipeStep!.isNotEmpty
                    ? LinearProgressIndicator(
                        value: (_currentPageIndex + 1) /
                            selectedRecipe!.recipeStep!.length,
                        borderRadius: BorderRadius.circular(50),
                        minHeight: 30,
                        backgroundColor: Colors.grey[350],
                        color: Colors.pink[900],
                      )
                    : LinearProgressIndicator(
                        value:
                            0.0, // Set value to 0 if taskStep is null or empty
                        borderRadius: BorderRadius.circular(50),
                        minHeight: 30,
                        backgroundColor: Colors.grey[350],
                        color: Colors.pink[900],
                      ),
              ),
              const SizedBox(width: 10),
              Text(
                selectedRecipe?.recipeStep != null &&
                        selectedRecipe!.recipeStep!.isNotEmpty
                    ? '${(((_currentPageIndex + 1) / selectedRecipe!.recipeStep!.length) * 100).toInt()}%'
                    : '0%', // Set text to '0%' if taskStep is null or empty
                style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // Build loading indicator while fetching data
  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class RecipesStep {
  final int stepNumber;
  final String description;
  final String stepImage;

  RecipesStep(
      {required this.stepNumber,
      required this.description,
      required this.stepImage});
}

// Step Screen

class StepScreen extends StatelessWidget {
  final RecipesStep step;
  final FlutterTts flutterTts;

  const StepScreen({super.key, required this.step, required this.flutterTts});

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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 196, 155, 175),
                    ),
                    child: Center(
                        child: Text(
                      '${step.stepNumber}',
                      style: const TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )))),
            const SizedBox(width: 15),
            SizedBox(
                width: 620,
                child: Text(
                  step.description,
                  style: const TextStyle(
                      fontFamily: "Lexend Exa",
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                )),
            IconButton(
              icon: Icon(Icons.volume_up, size: 45, color: Colors.pink[900]),
              onPressed: () async {
                await flutterTts.speak(step.description);
              },
            ),
          ],
        ),

        // Step image/visual cue

        const SizedBox(height: 50),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Image.network(
            step.stepImage,
            width: 700,
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

// Add Linear Progress Indicator somehow