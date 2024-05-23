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
  int _selectedFilterIndex = 0;

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
      searchResults = _filterTrainees(searchText, _selectedFilterIndex);
    });
  }

  List<Trainee> _filterTrainees(String searchText, int filterIndex) {
    return allTrainees.where((trainee) {
      final matchesSearchText = trainee.firstName!
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          trainee.lastName!.toLowerCase().contains(searchText.toLowerCase());

      switch (filterIndex) {
        case 1:
          return matchesSearchText && (trainee.isWorking ?? false);
        case 2:
          return matchesSearchText && !(trainee.isWorking ?? true);
        default:
          return matchesSearchText;
      }
    }).toList();
  }

  Trainee? selectedTrainee;

  // Navigate to trainee profile
  void _navigateToTraineeProfile(Trainee trainee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AdminTraineeProfile(title: 'Profile', trainee: trainee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Trainee> displayTrainees;
    switch (_selectedFilterIndex) {
      case 1:
        displayTrainees =
            allTrainees.where((trainee) => trainee.isWorking ?? false).toList();
        break;
      case 2:
        displayTrainees = allTrainees
            .where((trainee) => !(trainee.isWorking ?? true))
            .toList();
        break;
      default:
        displayTrainees = allTrainees;
    }

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
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ToggleButtons(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                        fontFamily: 'Lexend Exa',
                        fontSize: 25,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Working',
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 25,
                          fontWeight: FontWeight.w200)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Archived',
                      style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          fontSize: 25,
                          fontWeight: FontWeight.w200)),
                ),
              ],
              isSelected:
                  List.generate(3, (index) => index == _selectedFilterIndex),
              onPressed: (int index) {
                setState(() {
                  _selectedFilterIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(30.0),
              selectedColor: Colors.white,
              fillColor: Colors.pink[900],
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: fetchAllTrainees,
                child: searchResults.isNotEmpty || _textController.text.isEmpty
                    ? ListView.builder(
                        itemCount: _textController.text.isNotEmpty
                            ? searchResults.length
                            : displayTrainees.length,
                        itemBuilder: (context, index) {
                          final trainee = _textController.text.isNotEmpty
                              ? searchResults[index]
                              : displayTrainees[index];
                          return GestureDetector(
                            onTap: () {
                              _navigateToTraineeProfile(trainee);
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
    return Autocomplete<Trainee>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Trainee>.empty();
        }
        return _filterTrainees(textEditingValue.text, _selectedFilterIndex);
      },
      onSelected: (Trainee selectedTrainee) {
        setState(() {
          searchResults = [selectedTrainee];
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
        color: trainee.isWorking == true ? Colors.white : Colors.grey[400],
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
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: trainee.isWorking == true
                      ? Colors.black
                      : Colors.grey[600]),
            ),
          ),
        ),
      );
}
