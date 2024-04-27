import 'package:flutter/material.dart';
import 'package:inka_test/modules/module_items/recipe_item.dart';
import 'package:inka_test/modules/selected_recipe.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen(
      {super.key,
      required this.title}); // Was a constant constructor - removed to test code.
  final String title;
  final TextEditingController _textController = TextEditingController();

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
              }),
        ),

        // Bottom Navigation Bar -- needs working
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
          //currentIndex: _selectedIndex,
          //onTap: _onItemTapped,
        ),

        // Search

        // Grid View
        body: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(25),
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
                                  SelectedRecipe(title: recipe.title),
                            ),
                          );
                        },
                        child: _buildRecipeCard(recipe));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              icon:
                  Icon(Icons.search_rounded, color: Colors.grey[600], size: 50),
              onPressed: () => _textController.clear()),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 10, right: 20),
            icon: Icon(Icons.clear_rounded, color: Colors.grey[600], size: 50),
            onPressed: () {
              _textController.text = "";
            },
          ),
          hintText: "Search Recipes",
          hintStyle: TextStyle(
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
      margin: EdgeInsets.all(20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: 400,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Image.asset(task.assetImage, fit: BoxFit.fill)),
          ),
          SizedBox(height: 30),
          Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                task.title,
                style: TextStyle(
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
