import 'package:flutter/material.dart';
import 'package:inka_test/admin/admin_edit_recipes.dart';
import 'package:inka_test/admin/admin_notifications.dart';
import 'package:inka_test/admin/admin_tasks.dart';
import 'package:inka_test/admin/admin_trainees.dart';
import 'package:inka_test/modules/module_items/recipe_item.dart';
import 'package:inka_test/modules/selected_recipe.dart';

class AdminRecipesScreen extends StatefulWidget {
  const AdminRecipesScreen({super.key, required this.title});
  final String title;

  @override
  _AdminRecipesScreenState createState() => _AdminRecipesScreenState();
}

class _AdminRecipesScreenState extends State<AdminRecipesScreen> {
  final TextEditingController _textController = TextEditingController();

  // Bottom Bar Navigation
  int _selectedIndex = 2;
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
                builder: (context) => const AdminRecipesScreen(title: 'Recipes')));
        break;
      default:
        break;
    }
  }

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
                  return AdminNotifications(title: 'Notifications');
                }));
              }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminEditRecipes(title: 'Edit Recipes');
                }));
              }, // To add functionality to settings
              iconSize: 45,
              icon: const Icon(Icons.edit_rounded),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
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

        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(25),
              child: _buildRecipeSearchBar(context)),
          Expanded(
              child: GridView.builder(
                  itemCount:
                      mockRecipes.length, //Placeholder list - backend pending.
                  itemBuilder: (context, index) {
                    final recipe = mockRecipes[
                        index]; //Placeholder list - backend pending.
                    return GestureDetector(
                        onTap: () {
                          // Navigate to the desired screen when a task card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedRecipe(title: recipe.title, recipeId: ""),
                            ),
                          );
                        },
                        child: _buildRecipeCard(recipe));
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

  // Recipe Card
  Widget _buildRecipeCard(task) => Card(
      margin: const EdgeInsets.all(20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: 400,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Image.asset(task.assetImage, fit: BoxFit.fill)),
          ),
          const SizedBox(height: 30),
          Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                task.title,
                style: const TextStyle(
                    fontFamily: 'Lexend Exa',
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ))
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
}
