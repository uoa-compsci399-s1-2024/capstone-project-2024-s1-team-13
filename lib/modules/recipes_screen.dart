import 'package:flutter/material.dart';
import 'package:inka_test/modules/module_items/recipe_item.dart';
import 'package:inka_test/modules/modules_notifications.dart';
import 'package:inka_test/modules/modules_settings.dart';
import 'package:inka_test/modules/selected_recipe.dart';
import 'package:inka_test/modules/tasks_screen.dart';
import 'package:inka_test/modules/training_modules.dart';

import 'package:inka_test/models/Recipe.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {


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
                builder: (context) => const TrainingModules(title: 'Modules')));
        break;
      case 1:
        // Navigate to evaluate screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TasksScreen(
                      title: "Tasks",
                    )));
        break;
      case 2:
        // Navigate to profile screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
  }

  late List<Recipe> allRecipes = []; // List to store all tasks
  @override
  void initState() {
    super.initState();
    fetchAllRecipe(); // Call the function to fetch all task notes
  }

  Future<void> fetchAllRecipe() async {
    try {
      final recipe = await queryRecipe();

      setState(() {
        allRecipes = recipe.cast<Recipe>();
      });
    } catch (e) {
      safePrint('Error fetching recipe notes: $e');
    }
  }

  // Function to query all task notes
  Future<List<Recipe>> queryRecipe() async {
    try {
      final request = ModelQueries.list(Recipe.classType);
      final response = await Amplify.API.query(request: request).response;

      final recipe = response.data?.items;
      if (recipe == null) {
        safePrint('errors: ${response.errors}');
        return [];
      }
      return recipe.cast<Recipe>();
    } catch (e) {
      safePrint('Query failed: $e');
      return [];
    }
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.notifications_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ModulesNotifications(title: 'Notifications');
                }));
              }),

          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ModulesSettings(title: 'Settings');
                }));
              }, // To add functionality to settings
              iconSize: 45,
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'HOME',
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


        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(25),
              child: _buildRecipeSearchBar(context)),
          Expanded(
              child: GridView.builder(
                  itemCount:
                      allRecipes.length, //Placeholder list - backend pending.
                  itemBuilder: (context, index) {
                    final recipe = allRecipes[index]; 
                    return GestureDetector(
                        onTap: () {
                          // Navigate to the desired screen when a task card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedRecipe(
                                    title: recipe.recipeTitle ?? "Recipe Title Not Found",
                                    recipeId: recipe.id),
                            ),

                          );
                        },
                        child: _buildRecipeCard(recipe.recipeTitle ?? "Recipe Title Not Found", recipe.recipeCoverImage ?? ""),
                        );

                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //crossAxisSpacing: 5,
                    //mainAxisSpacing: 5,
                  ),
                  scrollDirection: Axis.vertical))
        ]));
  }

  // Search Bar
  Widget _buildRecipeSearchBar(context) => TextField(
        controller: _textController,
        style: const TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: const EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Recipes",
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
      );

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
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Image.network(recipeCoverImageUrl, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontFamily: 'Lexend Exa',
                              fontSize: 30,
                              fontWeight: FontWeight.w300),
                        )),
                    
                  ])),
        ],
      ));

  //Mock Data
  final List<RecipeItem> mockRecipes = [
    RecipeItem(
        title: 'Macarons', assetImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipeItem(
        title: 'Brownies', assetImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipeItem(
        title: 'Cupcakes', assetImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipeItem(
        title: 'Quiche', assetImage: 'assets/images/recipe_placeholder.jpeg'),
    RecipeItem(
        title: 'Sausage Roll',
        assetImage: 'assets/images/recipe_placeholder.jpeg')
  ];

//Delete selected task - pending backend functionality
  
}


