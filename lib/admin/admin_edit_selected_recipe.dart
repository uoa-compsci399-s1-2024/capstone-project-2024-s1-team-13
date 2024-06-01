import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

//AMPLIFY IMPORTS
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:inka_test/models/Recipe.dart';
import 'package:inka_test/models/ModelProvider.dart';

class AdminEditSelectedRecipe extends StatefulWidget {
  final String title;
  final Recipe recipe;
  const AdminEditSelectedRecipe(
      {super.key, required this.title, required this.recipe});

  @override
  _AdminEditSelectedRecipeState createState() =>
      _AdminEditSelectedRecipeState();
}

class _AdminEditSelectedRecipeState extends State<AdminEditSelectedRecipe> {
  //GLOBAL VARIABLES
  TextEditingController _recipeTitleController = TextEditingController();
  TextEditingController _stepDescriptionController = TextEditingController();
  String? _imagePath;
  late String retRecipeTitle;
  late String globalRecipeId;
  late String globalAdminId;
  late String globalCoverImageUrl;
  List<String> recipeSteps = []; //List to store recipe steps
  List<String> recipeStepImages = []; //List to store the recipe step images
  bool? hasInstructions;

  //INIT STATE
  @override
  void initState() {
    super.initState();
    recipeSteps = widget.recipe.recipeStep!;
    recipeStepImages = widget.recipe.recipeStepImage!;
    globalRecipeId = widget.recipe.id;
    globalAdminId = widget.recipe.adminID;
    globalCoverImageUrl = widget.recipe.recipeCoverImage!;
    _recipeTitleController =
        TextEditingController(text: widget.recipe.recipeTitle);
    _stepDescriptionController =
        TextEditingController(text: widget.recipe.recipeStep?[0]);
  }

  //BACKEND FUNCTIONS
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

  Future<String?> uploadImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: false,
      withReadStream: true,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );

    if (result == null) {
      safePrint('No file selected');
      return null;
    }

    final platformFile = result.files.single;
    try {
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        key: platformFile.name,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;

      setState(() {
        globalCoverImageUrl = platformFile.name;
      });

      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }

  Future<String?> uploadStepImage(int stepNumber) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: false,
      withReadStream: true,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );

    if (result == null) {
      safePrint('No file selected');
      return null;
    }

    final platformFile = result.files.single;
    try {
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        key: platformFile.name,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;

      final url = await getDownloadUrl(
          key: platformFile.name, accessLevel: StorageAccessLevel.guest);
      print('Uploaded image URL for Step $stepNumber: $url');

      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }

  Future<void> updateRecipe(String retRecipeTitle, List<String> retRecipeSteps,
      String imageKey, List<String> recipeStepImages) async {
    try {
      final updatedRecipe = Recipe(
          id: globalRecipeId,
          recipeTitle: retRecipeTitle,
          recipeStep: recipeSteps,
          adminID: globalAdminId,
          recipeCoverImage: imageKey,
          recipeStepImage: recipeStepImages);

      final req = ModelMutations.update(updatedRecipe);
      final res = await Amplify.API.mutate(request: req).response;
      safePrint('The recipe has been edited!: $res');
    } catch (e) {
      errorSnackbar();
      safePrint('Error editing recipe: $e');
    }
  }

  
  void deleteStep(int index) {
  if (index >= 0 && index < recipeSteps.length) {
    setState(() {
      recipeStepImages.removeAt(index);
      recipeSteps.removeAt(index);
    });
  } else {
    safePrint('Invalid index!: $index');
  }
}

  Future<void> _refresh() async {
  setState(() {
    // No need to set recipeSteps = recipeSteps;
    // Just calling setState will rebuild the UI with the updated list
    safePrint('THIS IS THE NEW: $recipeSteps');
  });
}
  //FRONTEND
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.arrow_back_ios),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                if (_recipeTitleController.text.isEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        elevation: 10,
                        content: Text(
                          'Please add a recipe title!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Lexend Exa',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink[900]),
                        )),
                  );
                }
                if (recipeSteps.isEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        elevation: 10,
                        content: Text(
                          'Please add at least 1 recipe step!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Lexend Exa',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink[900]),
                        )),
                  );
                }
                if (globalCoverImageUrl == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        elevation: 10,
                        content: Text(
                          'Please add a recipe cover image!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Lexend Exa',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink[900]),
                        )),
                  );
                }
                for (int i = 0; i < recipeSteps.length; i++) {
                  if (recipeSteps[i].isEmpty == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          elevation: 10,
                          content: Text(
                            'No instructions in Step ${i + 1}!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Lexend Exa',
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink[900]),
                          )),
                    );
                    hasInstructions = false;
                    break;
                  }
                  hasInstructions = true;
                }
                if (globalCoverImageUrl != null &&
                    _recipeTitleController.text.isNotEmpty == true &&
                    hasInstructions == true &&
                    recipeSteps.isNotEmpty == true) {
                  updateRecipe(_recipeTitleController.text, recipeStepImages,
                      globalCoverImageUrl!, recipeStepImages);
                  saveRecipe();
                }
              },
              iconSize: 50,
              icon: const Icon(Icons.done_rounded),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Grid View
        body: RefreshIndicator(
  onRefresh: _refresh,
  child: Column(
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
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: _RecipeTitle(),
        ),
      ),
      const SizedBox(height: 30),
      Expanded(
  child: ReorderableListView.builder(
    itemCount: recipeSteps.length,
    itemBuilder: (context, index) {
      final stepKey = ValueKey<String>('step_$index');
      return _StepCard(
        context,
        recipeSteps[index],
        index + 1,
        key: stepKey, // Pass the key here
      );
    },
    onReorder: (oldIndex, newIndex) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final step = recipeSteps.removeAt(oldIndex);
        recipeSteps.insert(newIndex, step);

        final stepImage = recipeStepImages.removeAt(oldIndex);
        recipeStepImages.insert(newIndex, stepImage);
      });
    },
  ),
),


      const SizedBox(height: 20),
      _AddStepButton(),
      const SizedBox(height: 30)
    ],
  ),
)
);
  }

  // Task Title - text form field and image
  Widget _RecipeTitle() => Row(
        children: [
          // Task Title
          Expanded(
              child: TextField(
            controller: _recipeTitleController,
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
          const SizedBox(width: 20),
          InkWell(
            onTap: () async {
              String? url = await uploadImage();
              if (url != null) {
                setState(() {
                  globalCoverImageUrl = url;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      elevation: 10,
                      content: Text(
                        'Error uploading image!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink[900]),
                      )),
                );
              }
            },
            child: Stack(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: globalCoverImageUrl == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                          )
                        : FutureBuilder<String>(
                            future: getDownloadUrl(
                                key: globalCoverImageUrl!,
                                accessLevel: StorageAccessLevel.guest),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                return Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                );
                              }
                            },
                          ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 70,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: Colors.grey[300]!.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  // Step Card
  Widget _StepCard(BuildContext context, String step, int stepNumber, {Key? key}) {
  String? stepImageKey = recipeStepImages.length >= stepNumber
      ? recipeStepImages[stepNumber - 1]
      : null;
  return Card(
    key: key, // Add this line to assign a key to the Card widget
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    elevation: 2,
    color: Colors.white,
    child: ListTile(
      title: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 5, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 196, 155, 175),
                  ),
                  child: Center(
                    child: Text(
                      '$stepNumber',
                      style: const TextStyle(
                        fontFamily: "Lexend Exa",
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Step $stepNumber',
                  style: TextStyle(
                    fontFamily: "Lexend Exa",
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                _deleteStep(context, stepNumber - 1);
              },
              icon: const Icon(Icons.remove_circle_rounded),
              iconSize: 55,
              color: Colors.red[600],
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _stepDesc(stepNumber, stepImageKey),
      ),
    ),
  );
}


  Widget _stepDesc(int stepNumber, String? stepImageKey) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: recipeSteps[
                stepNumber - 1], // Set initial value based on step text
            onChanged: (value) {
              setState(() {
                recipeSteps[stepNumber - 1] =
                    value; // Update step text in the data structure
              });
            },
            maxLines: 4,
            style: const TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
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
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () async {
            String? url = await uploadStepImage(stepNumber);
            if (url != null) {
              setState(() {
                if (recipeStepImages.length >= stepNumber) {
                  recipeStepImages[stepNumber - 1] = url;
                } else {
                  recipeStepImages.add(url);
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    elevation: 10,
                    content: Text(
                      'Error uploading image!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink[900]),
                    )),
              );
            }
          },
          child: Stack(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: recipeStepImages.length >= stepNumber &&
                          recipeStepImages[stepNumber - 1] != null
                      ? FutureBuilder<String>(
                          future: getDownloadUrl(
                              key: recipeStepImages[stepNumber - 1]!,
                              accessLevel: StorageAccessLevel.guest),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 70,
                right: 70,
                child: Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: Colors.grey[300]!.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _AddStepButton() => ElevatedButton(
        onPressed: () {
          setState(() {
            recipeSteps.add('');
            recipeStepImages.add(
                'placeholder.png'); //Include placeholder every initialisation, can be updated
          });
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

  void _deleteStep(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: const Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            'Are you sure you want to delete this step?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lexend Exa',
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 60),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("NO"),
              ),
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
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    deleteStep(index);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("YES"),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  void errorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          elevation: 10,
          content: Text(
            'Error saving changes!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]),
          )),
    );
  }

  void saveRecipe() {
    String recipeName = _recipeTitleController.text;
    print('Recipe Name: $recipeName');
    print('Steps: $recipeSteps');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          elevation: 10,
          content: Text(
            'Successfully edited recipe!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Lexend Exa',
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900]),
          )),
    );
  }
}
