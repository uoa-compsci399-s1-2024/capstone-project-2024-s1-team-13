import 'package:flutter/material.dart';

//FILE UPLOAD IMPORT
import 'package:file_picker/file_picker.dart';

//AMPLIFY IMPORT
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/models/ModelProvider.dart';

class AdminAddTrainee extends StatefulWidget {
  const AdminAddTrainee({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AdminAddTraineeState createState() => _AdminAddTraineeState();
}

class _AdminAddTraineeState extends State<AdminAddTrainee> {
  //GLOBAL VARIABLES
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? uploadedImageKey;
  String? downloadedImageUrl;
  String placeholderImageKey = 'trainee_placeholder.png';
  bool? hasPlaceholder;

  //INIT STATE
  @override
  void initState() {
    super.initState();
    displayImage();
  }

  //FUNCTIONS
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
      print('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }
  
  Future<void> displayImage() async {
    String? imageKey = uploadedImageKey;
    final String? imageUrl;

    try {
      imageKey ??= placeholderImageKey;
      if (imageKey == placeholderImageKey) {
        hasPlaceholder = true;
      }
      imageUrl = await getDownloadUrl(key: imageKey, accessLevel: StorageAccessLevel.guest);
      
      setState(() {
        downloadedImageUrl = imageUrl;
      });
    
    } catch (e) {
      safePrint('Error fetching image URL :$e');
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
        uploadedImageKey = platformFile.name;
      });

      return platformFile.name;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }

  Future<void> createTrainee() async {
    try {
      if (_firstNameController.text.isEmpty != true && _lastNameController.text.isEmpty != true){
        if (hasPlaceholder != true) {
          final aTrainee = Trainee(
            traineePhoto: uploadedImageKey,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            supportID: '2801781d-ff27-4fec-92a7-f1b1cd632b36', //dummy value
            adminID: 'e7bd6941-2f8f-4949-a4ed-6803cd2ab42b', //dummy value
            isWorking: true, //default value
          );
          final req = ModelMutations.create(aTrainee);
          final res = await Amplify.API.mutate(request: req).response;

          final createdTrainee = res.data;
          if (createdTrainee == null) {
            safePrint('errors: ${res.errors}');
            return;
          }
          safePrint('Successfully created a trainee! TRAINEE: ${createdTrainee.firstName}');
        } else if (hasPlaceholder == true) {
          final aTrainee = Trainee(
            traineePhoto: placeholderImageKey,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            supportID: '2801781d-ff27-4fec-92a7-f1b1cd632b36', //dummy value
            adminID: 'e7bd6941-2f8f-4949-a4ed-6803cd2ab42b', //dummy value
            isWorking: true, //default value
          );
          final req = ModelMutations.create(aTrainee);
          final res = await Amplify.API.mutate(request: req).response;

          final createdTrainee = res.data;
          if (createdTrainee == null) {
            safePrint('errors: ${res.errors}');
            return;
          }
          safePrint('Successfully created a trainee! TRAINEE: ${createdTrainee.firstName}');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid information!')),
        );
      }
    } on ApiException catch (e) {
      safePrint('Error creating a trainee: $e');
    }
  }

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
        actions: [
          IconButton(
            onPressed: () {
              createTrainee();
              Navigator.pop(context);
            },
            iconSize: 50,
            icon: const Icon(Icons.done_rounded),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TraineeImage(),
            const SizedBox(height: 100),
            _TraineeDetails(),
          ],
        ),
      ),
    );
  }

  Widget _TraineeImage() => Column(
      children: <Widget>[
        Container(
          width: 250,
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (downloadedImageUrl != null)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(downloadedImageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 196, 155, 175),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        await uploadImage();
                        await displayImage();
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              if (uploadedImageKey != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        uploadedImageKey = null;
                        downloadedImageUrl = null;
                      });
                      displayImage();
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            await uploadImage();
            await displayImage();
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Change Photo",
              style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.pink[900],
              ),
            ),
          ),
        ),
      ],
    );

  Widget _TraineeDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter name",
              hintStyle: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Surname",
            style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: _lastNameController,
            style: const TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter surname",
              hintStyle: const TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      );
}