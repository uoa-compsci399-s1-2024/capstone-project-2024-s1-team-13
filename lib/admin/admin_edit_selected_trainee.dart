// ignore_for_file: must_be_immutable

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Trainee.dart';

class AdminEditSelectedTrainee extends StatefulWidget {
  AdminEditSelectedTrainee({
    Key? key,
    required this.title,
    required this.trainee,
  }) : super(key: key);

  final String title;
  final Trainee trainee;

  @override
  AdminEditSelectedTraineeState createState() =>
      AdminEditSelectedTraineeState();
}

class AdminEditSelectedTraineeState extends State<AdminEditSelectedTrainee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? uploadedImageKey;
  String? downloadedImageUrl;

  @override
  void initState() {
    super.initState();
    // Retrieve the image key from the trainee object
    uploadedImageKey = widget.trainee.traineePhoto;
    // Call displayImage to fetch and display the trainee's image
    if (uploadedImageKey != null) {
      displayImage(uploadedImageKey!);
    }
  }

  Future<void> displayImage(String imageKey) async {
    try {
      final String imageUrl = await getDownloadUrl(
        key: imageKey,
        accessLevel: StorageAccessLevel.guest,
      );
      setState(() {
        downloadedImageUrl = imageUrl;
      });
    } catch (e) {
      print('Error displaying image: $e');
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
      print('Could not get a downloadable URL: ${e.message}');
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
      print('No file selected');
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
          print('Fraction completed: ${progress.fractionCompleted}');
        },
      );
      setState(() {
        uploadedImageKey = platformFile.name;
      });
      return platformFile.name;
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }

  Future<void> updateTrainee(
      String first, String last, String? imagePath) async {
    final originalFirstName = widget.trainee.firstName;
    final originalLastName = widget.trainee.lastName;

    final updatedFirstName = first.isNotEmpty ? first : originalFirstName;
    final updatedLastName = last.isNotEmpty ? last : originalLastName;

    final updatedTrainee = widget.trainee.copyWith(
      firstName: updatedFirstName,
      lastName: updatedLastName,
      traineePhoto: imagePath,
    );

    final request = ModelMutations.update(updatedTrainee);
    try {
      final response = await Amplify.API.mutate(request: request).response;
      print('Response: $response');
    } catch (e) {
      print('Error updating trainee: $e');
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
              final firstName = _firstNameController.text;
              final lastName = _lastNameController.text;

              if (uploadedImageKey != null) {
                updateTrainee(firstName, lastName, uploadedImageKey);
              } else {
                print('Image upload failed.');
              }

              Navigator.pop(context);
            },
            iconSize: 50,
            icon: const Icon(Icons.done_rounded),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
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

  Widget _TraineeImage() {
    return Column(
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
                ),
              if (downloadedImageUrl == null && uploadedImageKey == null)
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 196, 155, 175),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        await uploadImage();
                        if (uploadedImageKey != null) {
                          await displayImage(uploadedImageKey!);
                        }
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
            if (uploadedImageKey != null) {
              await displayImage(uploadedImageKey!);
            }
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
  }

  Widget _TraineeDetails() {
    return Column(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: widget.trainee.firstName,
            hintStyle: const TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 30),
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: widget.trainee.lastName,
            hintStyle: const TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500,
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
}
