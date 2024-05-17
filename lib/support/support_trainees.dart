import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/models/Task.dart';
import 'package:inka_test/models/Trainee.dart';
import 'package:inka_test/support/support_settings.dart';
import 'package:inka_test/support/support_trainee_dashboard.dart';

class SupportTrainees extends StatefulWidget {
  const SupportTrainees({
    Key? key,
    required this.title,
    //required this.task,
  }) : super(key: key);
  final String title;
  //final Task task;

  @override
  _SupportTrainees createState() => _SupportTrainees();
}

class _SupportTrainees extends State<SupportTrainees> {
  late final String title;
  final TextEditingController _textController = TextEditingController();
  late List<Trainee> allTrainees = [];
  late List<Trainee> searchResults = []; // For autocomplete
  late Task task;

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
        searchResults = trainees; // Initialize search results with all trainees
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

  // Navigate to trainee dashboard
  void _navigateToTraineeDashboard(Trainee trainee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupportTraineeDashboard(trainee: trainee),
      ),
    );
  }

// Store the selected trainee in a variable
  Trainee? selectedTrainee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_back_ios_rounded),
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: _buildTraineeSearchBar(context),
          ),
          Expanded(
            child: searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final trainee = searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          _navigateToTraineeDashboard(trainee);
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
                    ),
                  ),
          ),
        ],
      ),
    );
  }

// Search Bar with Autocomplete
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
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
            ),
            suffixIcon: IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Icon(Icons.clear_rounded,
                    color: Colors.grey[600], size: 50),
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
