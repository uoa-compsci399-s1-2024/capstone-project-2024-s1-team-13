import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_trainee.dart';
import 'package:inka_test/admin/admin_edit_trainees.dart';
import 'package:inka_test/admin/admin_recipes.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainee_profile.dart';
import 'package:inka_test/models/Trainee.dart';

class AdminTrainees extends StatefulWidget {
  const AdminTrainees({super.key, required this.title});
  final String title;

  @override
  _AdminTraineesState createState() => _AdminTraineesState();
}

class _AdminTraineesState extends State<AdminTrainees> {
  late final String title;
  final TextEditingController _textController = TextEditingController();
  late List<Trainee> allTrainees = [];
  late List<Trainee> searchResults = []; // For autocomplete

  @override
  void initState() {
    super.initState();
    title = widget.title;
    fetchAllTrainees();
  }

  // Function to fetch all trainees
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

  // Function to query all task notes
  Future<List<Trainee>> queryTrainees() async {
    try {
      final request = ModelQueries.list(Trainee.classType);
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

  // Bottom Bar Navigation
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to trainees
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTrainees(title: 'Trainees')));
        break;
      case 1:
        // Navigate to tasks
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to recipes
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AdminRecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
  }

  // Autocomplete logic
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

  Trainee? selectedTrainee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AdminSettings(title: 'Settings');
            }));
          },
          iconSize: 45,
          icon: Icon(Icons.settings),
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdminAddTrainee(title: 'Add Trainee');
                  }));
                },
                iconSize: 60,
                icon: const Icon(Icons.add_rounded),
                padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdminEditTrainees(title: 'Edit Trainees');
                  }));
                },
                iconSize: 45,
                icon: const Icon(Icons.edit_rounded),
                padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
              )
            ],
          )
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'TRAINEES',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'RECIPES',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
                child: searchResults.isNotEmpty || _textController.text.isEmpty
                    ? ListView.builder(
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
                                  builder: (context) => AdminTraineeProfile(
                                    title: 'Profile',
                                    trainee: allTrainees[index],
                                  ),
                                ),
                              );
                            },
                            child: _TraineeCard(trainee),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        "No trainees found",
                        style: TextStyle(
                          fontFamily: "Lexend Exa",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ))),
          ),
        ],
      ),
    );
  }

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
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 40),
            ),
            suffixIcon: IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Icon(Icons.clear_rounded,
                    color: Colors.grey[600], size: 40),
              ),
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
        ),
      );
}
