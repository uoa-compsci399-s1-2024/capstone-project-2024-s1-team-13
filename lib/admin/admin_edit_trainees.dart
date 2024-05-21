import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_edit_selected_trainee.dart';

import 'package:inka_test/admin/admin_items/admin_greeting_text.dart';
import 'package:inka_test/items/trainee_item.dart';
import 'package:inka_test/models/Trainee.dart';

import '../models/ModelProvider.dart';

class AdminEditTrainees extends StatefulWidget {
  const AdminEditTrainees({super.key, required this.title});
  final String title;

  @override
  _AdminEditTraineesState createState() => _AdminEditTraineesState();
}

class _AdminEditTraineesState extends State<AdminEditTrainees> {
  late final String title;
  final TextEditingController _textController = TextEditingController();
  late List<Trainee> allTrainees = [];
  late List<Trainee> allArchivedTrainees = [];
  late List<Trainee> searchResults = []; // For autocomplete
  Trainee? selectedTrainee;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    fetchAllTrainees();
  }

  //FETCHES ONLY CURRENT WORKING TRAINEES
  Future<void> fetchAllTrainees() async {
    try {
      final trainees = await queryTrainees();

      setState(() {
        allTrainees = trainees;
      });
    } catch (e) {
      print('Error fetching trainees: $e');
    }
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allTrainees
          .where((trainee) =>
              trainee.firstName!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              trainee.lastName!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  //RETRIVES ONLY CURRENT WORKING TRAINEES
  Future<List<Trainee>> queryTrainees() async {
    try {
      final request = ModelQueries.list(Trainee.classType,
          where: Trainee.ISWORKING.eq(true));
      final response = await Amplify.API.query(request: request).response;

      final trainee = response.data?.items;
      if (trainee == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return trainee.cast<Trainee>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  //FETCHES ONLY ARCHIVED TRAINEES
  Future<void> fetchArchivedTrainees() async {
    try {
      final trainees = await queryArchivedTrainees();

      setState(() {
        allArchivedTrainees = trainees;
      });
    } catch (e) {
      print('Error fetching trainees: $e');
    }
  }

  //RETRIVES ONLY ARCHIVED TRAINEES
  Future<List<Trainee>> queryArchivedTrainees() async {
    try {
      final request = ModelQueries.list(Trainee.classType,
          where: Trainee.ISWORKING.eq(false));
      final response = await Amplify.API.query(request: request).response;

      final trainee = response.data?.items;
      if (trainee == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return trainee.cast<Trainee>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  Future<void> archiveTrainee(Trainee currTrainee) async {
    final updatedTrainee = currTrainee.copyWith(isWorking: false);

    final req = ModelMutations.update(updatedTrainee);
    final res = await Amplify.API.mutate(request: req).response;
    safePrint('Response: $res');
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
      ),

      // Body of screen
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: _buildTraineeSearchBar(context),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchAllTrainees,
              child: searchResults.isEmpty && _textController.text.isNotEmpty
                  ? Center(
                      child: Text(
                        "No trainees found",
                        style: TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  :   ListView.builder(
                            itemCount: _textController.text.isNotEmpty
                            ? searchResults.length
                            : allTrainees.length,
                        itemBuilder: (context, index) {
                         final trainee = _textController.text.isNotEmpty
                              ? searchResults[index]
                              : allTrainees[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminEditSelectedTrainee(
                                  title: 'Edit Details',
                                  trainee: searchResults[index],
                                ),
                              ),
                            );
                          },
                          child: _TraineeCard(trainee),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Search Bar
  Widget _buildTraineeSearchBar(context) {
    final maxListHeight = MediaQuery.of(context).size.height * 0.3;
    final itemHeight = 70.0;
    final listItemWidth = MediaQuery.of(context).size.width * 0.95;

    return Autocomplete<Trainee>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Trainee>.empty();
        }
        return allTrainees.where((trainee) =>
            trainee.firstName!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()) ||
            trainee.lastName!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (Trainee selectedTrainee) {
        setState(() {
          // Filter out the search results to only the selected option
          searchResults = [selectedTrainee];
          // Store the selected trainee
          this.selectedTrainee = selectedTrainee;
          _textController.text =
              '${selectedTrainee.firstName} ${selectedTrainee.lastName}';
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: _textController,
          focusNode: focusNode,
          onChanged: _onSearchTextChanged,
          style: TextStyle(
            fontSize: 27, // Adjust the font size here
          ),
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.search_rounded, color: Colors.grey[600], size: 40),
            suffixIcon: IconButton(
              icon:
                  Icon(Icons.clear_rounded, color: Colors.grey[600], size: 40),
              onPressed: () {
                _textController.clear();
                _onSearchTextChanged('');
              },
            ),
            hintText: "Search Trainees",
            hintStyle: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
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

  // Trainee Card
  Widget _TraineeCard(Trainee trainee) => Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        color: Colors.white,
        child: ListTile(
            // Avatar containing image - set as leading for Card instance, needs fixing
            leading: FutureBuilder<String>(
              future: getDownloadUrl(
                key: trainee.traineePhoto!,
                accessLevel: StorageAccessLevel.guest,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircleAvatar(
                    radius: 60,
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.error),
                  );
                }
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(snapshot.data!),
                );
              },
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 100, bottom: 100),
              child: Text(
                '${trainee.firstName} ${trainee.lastName}',
                style: const TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminEditSelectedTrainee(
                    title: 'Edit Details',
                    trainee: trainee,
                  ),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () => deleteTraineeDialog(
                  context, allTrainees.indexOf(trainee), trainee),
              icon: const Icon(Icons.remove_circle_rounded),
              iconSize: 50,
              color: Colors.red[600],
            )),
      );

  void deleteTraineeDialog(BuildContext context, index, Trainee currTrainee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                  'Archive ${allTrainees[index].firstName} and their details?', // Warning: This works, but throws a NoSuchMethod Error for some reason?
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Lexend Exa',
                      fontSize: 35,
                      fontWeight: FontWeight.w500))),
          actionsPadding: const EdgeInsets.only(bottom: 60),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("NO")),
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
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    archiveTrainee(currTrainee);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("YES"))
            ])
          ],
        );
      },
    );
  }
}
