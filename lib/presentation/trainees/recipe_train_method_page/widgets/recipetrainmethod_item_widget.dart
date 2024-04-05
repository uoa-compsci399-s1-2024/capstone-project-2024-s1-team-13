import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class RecipetrainmethodItemWidget extends StatelessWidget {
  const RecipetrainmethodItemWidget({Key? key}) : super(key: key);

  @override

  
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154.v,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.macaronsRecipeScreen);
            },
            child: Container(
              width: 146.h, // Fixed width for the container
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye),
                  SizedBox(height: 5),
                  Text(
                    "VISUAL",
                    style: TextStyle(fontSize: 16, color: Colors.black), // Adjust styling as needed
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

              Navigator.pushNamed(context, AppRoutes.macaronsRecipeScreen);
            },
            
            child: Container(
              width: 146.h, // Fixed width for the container
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hearing),
                  SizedBox(height: 5),
                  Text(
                    "AUDITORY",
                    style: TextStyle(fontSize: 16, color: Colors.black), // Adjust styling as needed
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}