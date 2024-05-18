import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_edit_recipes.dart';
import 'package:inka_test/admin/admin_settings.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainees.dart';
import 'package:inka_test/models/Recipe.dart';
import 'package:inka_test/modules/selected_recipe.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AdminRecipesScreen extends StatefulWidget {
  const AdminRecipesScreen({super.key, required this.title});
  final String title;

  @override
  _AdminRecipesScreenState createState() => _AdminRecipesScreenState();
}

class _AdminRecipesScreenState extends State<AdminRecipesScreen> {
  late List<Recipe> searchResults = []; // For autocomplete

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

  late List<Recipe> allRecipes = []; // List to store all recipes
  @override
  void initState() {
    super.initState();
    fetchAllRecipe();
  }

  Future<void> fetchAllRecipe() async {
    try {
      final recipe = await queryRecipe();

      setState(() {
        allRecipes = recipe.cast<Recipe>();
      });
    } catch (e) {
      safePrint('Error fetching task notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<Recipe>> queryRecipe() async {
    try {
      final request = ModelQueries.list(Recipe.classType);
      final response = await Amplify.API.query(request: request).response;

      final task = response.data?.items;
      if (task == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return task.cast<Recipe>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  final TextEditingController _textController = TextEditingController();
// Bottom Bar Navigation
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to modules dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTrainees(title: 'Trainees')));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminTasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to profile screen
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

  Recipe? selectedRecipe;

  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allRecipes
          .where((recipe) => recipe.recipeTitle!
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  // Search Bar with Autocomplete
  Widget _buildRecipeSearchBar(context) {
    final maxListHeight = MediaQuery.of(context).size.height * 0.3;
    final itemHeight = 70.0;
    final listItemWidth = MediaQuery.of(context).size.width * 0.95;

    return Autocomplete<Recipe>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Recipe>.empty();
        }
        return allRecipes.where((recipe) => recipe.recipeTitle!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (Recipe selectedRecipe) {
        setState(() {
          searchResults = [selectedRecipe];
          this.selectedRecipe = selectedRecipe;
          _textController.text = '${selectedRecipe.recipeTitle}';
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
                padding: const EdgeInsets.only(left: 25, right: 10),
                child: Icon(Icons.clear_rounded,
                    color: Colors.grey[600], size: 40),
              ),
              onPressed: () {
                _textController.clear();
                _onSearchTextChanged('');
              },
            ),
            hintText: "Search Recipes",
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
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminEditRecipes(title: 'Edit Recipes');
                }));
              },
              iconSize: 45,
              icon: const Icon(Icons.edit_rounded),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0)),
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

      // Body
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: _buildRecipeSearchBar(context),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchAllRecipe,
              child: searchResults.isEmpty && _textController.text.isNotEmpty
                  ? Center(
                      child: Text(
                      'No recipes found',
                      style: TextStyle(
                        fontFamily: "Lexend Exa",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ))
                  : GridView.builder(
                      itemCount: searchResults.isNotEmpty ||
                              _textController.text.isNotEmpty
                          ? searchResults.length
                          : allRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = searchResults.isNotEmpty ||
                                _textController.text.isNotEmpty
                            ? searchResults[index]
                            : allRecipes[
                                index]; // Use searchResults if available, otherwise allRecipes

                        return FutureBuilder<String>(
                          future: getDownloadUrl(
                            key: recipe.recipeCoverImage!,
                            accessLevel: StorageAccessLevel.guest,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to the desired screen when a recipe card is tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectedRecipe(
                                        title: recipe.recipeTitle!,
                                        recipeId: recipe.id,
                                      ),
                                    ),
                                  );
                                },
                                child: _buildRecipeCard(
                                  recipe.recipeTitle ??
                                      "Recipe Title Not Found",
                                  snapshot.data ??
                                      "", // Use the URL from the snapshot
                                ),
                              );
                            }
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Recipe Card
  String _getRecipe(int index) {
    if (index < allRecipes.length) {
      return allRecipes[index].recipeTitle ??
          "Recipe Title Not Found"; // Providing a default value if taskTitle is null
    } else {
      return "Recipe Title Not Found"; // Fallback title if index exceeds the length of allTasks
    }
  }

  String _getUrl(int index) {
    if (index < allRecipes.length) {
      String? imageUrl = allRecipes[index].recipeCoverImage;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        return imageUrl;
        // Return the task cover image URL if it's not null or empty
      } else {
        return ""; // Return an empty string as a fallback if the URL is null or empty
      }
    } else {
      return ""; // Fallback if index exceeds the length of allTasks
    }
  }

  // Recipe Card
  Widget _buildRecipeCard(String title, String recipeCoverImageUrl) => Card(
      margin: const EdgeInsets.all(20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 260, // Set a fixed height for the image container
            width: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Image.network(recipeCoverImageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Lexend Exa',
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1, // Limit the text to a single line
                          minFontSize: 10, // Set the minimum font size
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis if the text overflows
                        ),
                      ),
                    )
                  ])),
        ],
      ));
}
