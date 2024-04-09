import 'package:istefat_s_application1/presentation/support/traineeTaskAnalysis/trainee_task_analysis.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/traineeEvaluate_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable

class RectangleTaskCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const RectangleTaskCard({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to FrameThreeScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TraineeTaskAnalysis(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TraineeEvaluate extends StatelessWidget {
  const TraineeEvaluate({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: 20.h,
            top: 16.v,
            right: 6.h,
          ),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 1.v,
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the next screen using the route name
                  Navigator.pushNamed(context, '/trainee_task_analysis');
                },
                child: RectangleTaskCard(
                  title: _getTitle(index),
                  imagePath: _getImagePath(index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getImagePath(int index) {
    switch (index) {
      case 0:
        return "assets/images/img_rectangle_140.png";
      case 1:
        return "assets/images/img_rectangle_139.png";
      case 2:
        return "assets/images/img_rectangle_144.png";
      default:
        return "assets/images/img_rectangle_140.png";
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "DISHES";
      case 1:
        return "ORDERS";
      case 2:
        return "CLEAN";
      default:
        return "DISHES";
    }
  }
}
