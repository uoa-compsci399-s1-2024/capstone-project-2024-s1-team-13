import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Admin.dart';
import 'package:inka_test/models/Recipe.dart';



class AdminAddRecipe extends StatefulWidget {
  const AdminAddRecipe({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _AdminAddRecipeState createState() => _AdminAddRecipeState();
}

class _AdminAddRecipeState extends State<AdminAddRecipe> {

  Future<Admin?> queryItem(Admin queriedAdmin) async {
    try {
      final request = ModelQueries.get(
        Admin.classType,
        queriedAdmin.modelIdentifier,
      );
      final response = await Amplify.API.query(request: request).response;
      final todo = response.data;
      if (todo == null) {
        safePrint('errors: ${response.errors}');
      }
      return todo;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }

  //createTask section
  Future<void> createRecipe(String recipeTitle, List<String> recipeStep, String imageKey, List<String> taskStepImage) async {
    try {
      safePrint('DOES IT TRIGGER THE EVENT?');

      final dummyAdmin = Admin(id: 'e7bd6941-2f8f-4949-a4ed-6803cd2ab42b');
      final existingAdmin = await queryItem(dummyAdmin);
      safePrint('This is a new admin: $existingAdmin');

      final aRecipe = Recipe(
        recipeTitle: recipeTitle, 
        recipeStep: recipeStep,
        adminID: 'e7bd6941-2f8f-4949-a4ed-6803cd2ab42b',
        recipeCoverImage: imageKey, 
        recipeStepImage: stepImageUrls,
      );
      safePrint('This is the current recipe: $aRecipe');

      final req = ModelMutations.create(aRecipe);
      final res = await Amplify.API.mutate(request: req).response;

      final createdRecipe = res.data;
      if (createdRecipe == null) {
        safePrint('errors: ${res.errors}');
        return;
      }
      safePrint('Mutation result: ${createdRecipe.recipeTitle}');
    } on ApiException catch (e) {
      safePrint('Mutation Failed: $e');
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

      // Set the uploaded image key in the state
      setState(() {
        uploadedImageKey = platformFile.name;
      });

      // Return the key instead of the URL
      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
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

  
  final TextEditingController _taskTitleController = TextEditingController();


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
                //Pending backend functionality
                saveTask();
                String recipeTitle = _taskTitleController.text;
                List<String> recipeStep = steps;
                List<String> taskStepImage = stepImageUrls;
                print('Type of taskStep: ${recipeStep.runtimeType}');
                if (uploadedImageKey != null) {
                  createRecipe(recipeTitle, steps, uploadedImageKey!, stepImageUrls);
                } else {
                  print('Image upload failed.');  
                }
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
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset in the x and y direction
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
                  steps.length, 
              
              itemBuilder: (context, index) {
                return _StepCard(context, steps[index], index + 1);
              },
            )),
            const SizedBox(height: 20),
            _AddStepButton(),
            const SizedBox(height: 30)
          ],
        ));
  }

  // Recipe Title - text form field and image
  String? uploadedImageKey;
  //List<String> stepImageUrls = [];
  //List<String> steps = [];

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
              hintText: "Enter recipe name",
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
          // Conditionally render the image container based on whether an image is uploaded
          uploadedImageKey == null
              ? InkWell(
                  onTap: () async {
                    String? key = await uploadImage();
                    if (key != null) {
                      setState(() {
                        uploadedImageKey = key;
                      });
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                )
              : // If an image is already uploaded, allow re-uploading by clicking on the image
              InkWell(
                  onTap: () async {
                    String? key = await uploadImage();
                    if (key != null) {
                      setState(() {
                        uploadedImageKey = key;
                      });
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: FutureBuilder<String>(
                        future: getDownloadUrl(
                            key: uploadedImageKey!,
                            accessLevel: StorageAccessLevel.guest),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
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
                ),
        ],
      );

  List<String> stepImageUrls = [];
  
  List<String> steps = [];

  Widget _StepCard(BuildContext context, String step, int stepNumber) {
  return Card(
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    elevation: 2,
    color: Colors.white,
    child: ListTile(
      title: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
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
              style: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _stepDesc(stepNumber),
      ),
    ),
  );
}


// Step Card helper widget - text field
  Widget _stepDesc(int stepNumber) {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          initialValue: steps[stepNumber - 1],
          onChanged: (value) {
            setState(() {
              steps[stepNumber - 1] = value;
            });
          },
          maxLines: 4,
          style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
      if (stepImageUrls.isNotEmpty && stepImageUrls.length >= stepNumber && stepImageUrls[stepNumber - 1] != null)
        SizedBox(
          width: 180,
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: InkWell(
              onTap: () async {
                String? key = await uploadStepImage(stepNumber);
                if (key != null) {
                  setState(() {
                    stepImageUrls[stepNumber - 1] = key;
                  });
                }
              },
              child: FutureBuilder<String>(
                future: getDownloadUrl(key: stepImageUrls[stepNumber - 1]!, accessLevel: StorageAccessLevel.guest),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
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
        )
      else // Show upload button if no image is uploaded
        InkWell(
          onTap: () async {
            String? key = await uploadStepImage(stepNumber);
            if (key != null) {
              setState(() {
                if (stepImageUrls.length >= stepNumber) {
                  stepImageUrls[stepNumber - 1] = key;
                } else {
                  stepImageUrls.add(key);
                }
              });
            }
          },
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.grey[300],
            ),
            child: Center(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
    ],
  );
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

    final url = await getDownloadUrl(key: platformFile.name, accessLevel: StorageAccessLevel.guest);
    print('Uploaded image URL for Step $stepNumber: $url');
    
    // Return the key instead of the URL
    return platformFile.name;
  } on StorageException catch (e) {
    safePrint('Error uploading file: $e');
    rethrow;
  }
}

// Add Step Button

  Widget _AddStepButton() => ElevatedButton(
    onPressed: () {
      setState(() {
        steps.add('');
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
        borderRadius: BorderRadius.circular(50)
      )
    ),
    child: const Text('+ ADD STEP'),
  );
void saveTask() {
    String recipeName = _taskTitleController.text;

    print('Task Name: $recipeName');
    print('Steps: $steps');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task saved successfully')),
    );
  }

  


}
