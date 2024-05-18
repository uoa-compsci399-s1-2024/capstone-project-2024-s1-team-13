import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_add_recipe.dart';
import 'package:inka_test/admin/admin_edit_selected_recipe.dart';
import 'package:inka_test/models/ModelProvider.dart';
import 'package:inka_test/modules/module_items/recipe_item.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:inka_test/models/Recipe.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:auto_size_text/auto_size_text.dart';

//------------------------------------------------------------

class AdminEditRecipes extends StatefulWidget {
  const AdminEditRecipes({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _AdminRecipesScreenState createState() => _AdminRecipesScreenState();
}

class _AdminRecipesScreenState extends State<AdminEditRecipes> {
  //------------------------------------------------------------
  //GLOBAL VARIABLES -------------------------------------------
  //------------------------------------------------------------

  late List<Recipe> allRecipes = []; // List to store all tasks
  final TextEditingController _textController = TextEditingController();
  late List<Recipe> searchResults = []; // For autocomplete
  Recipe? selectedRecipe;

  //------------------------------------------------------------
  //INITSTATE() ------------------------------------------------
  //------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    fetchAllRecipe(); // Call the function to fetch all task notes
  }

  //------------------------------------------------------------
  //FUNCTIONS SECTION ------------------------------------------
  //------------------------------------------------------------

  Future<void> fetchAllRecipe() async {
    try {
      final task = await queryRecipe();

      setState(() {
        allRecipes = task.cast<Recipe>();
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

  //DELETERECIPE (SINGULAR)
  Future<void> deleteRecipe(String recipeId) async {
    try {
      final req = ModelMutations.deleteById(
        Recipe.classType,
        RecipeModelIdentifier(id: recipeId),
      );

      final res = await Amplify.API.mutate(request: req).response;
      safePrint('The recipe has been deleted!: $res');

      setState(() {
        allRecipes.removeWhere((recipe) => recipe.id == recipeId);
      });
    } catch (e) {
      safePrint('Error deleting recipe: $e');
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

  void _onSearchTextChanged(String searchText) {
    setState(() {
      searchResults = allRecipes
          .where((recipe) => recipe.recipeTitle!
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  //------------------------------------------------------------
  //SCREEN BUILD -----------------------------------------------
  //------------------------------------------------------------

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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminAddRecipe(title: 'Add Recipe');
              }));
            },
            iconSize: 60,
            icon: const Icon(Icons.add_rounded),
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
          ),
        ],
      ),

      // Grid View
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
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to the desired screen when a task card is tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminEditSelectedRecipe(
                                        title: 'Edit ${recipe.recipeTitle}',
                                        recipe: recipe,
                                      ),
                                    ),
                                  );
                                },
                                child: _buildRecipeCard(
                                  recipe.recipeTitle ?? "Task Title Not Found",
                                  snapshot.data ??
                                      "", // Use the URL from the snapshot
                                  recipe.id,
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
                      scrollDirection: Axis.vertical,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Search Bar
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

  String _getTitle(int index) {
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
  Widget _buildRecipeCard(
          String title, String recipeCoverImageUrl, String currRecipeId) =>
      Card(
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
                        ),
                        IconButton(
                          onPressed: () =>
                              deleteRecipeDialog(context, currRecipeId),
                          //_deleteRecipe(context, mockRecipes.indexOf(arecipe)),
                          icon: const Icon(Icons.remove_circle_rounded),
                          iconSize: 50,
                          color: Colors.red[600],
                        )
                      ])),
            ],
          ));

  //------------------------------------------------------------
  //POP-UP DIALOG ----------------------------------------------
  //------------------------------------------------------------

  void deleteRecipeDialog(BuildContext context, String currentRecipeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: const Padding(
              padding: EdgeInsets.all(30),
              child: Text('Are you sure you want to delete this recipe?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                    deleteRecipe(currentRecipeId);
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
