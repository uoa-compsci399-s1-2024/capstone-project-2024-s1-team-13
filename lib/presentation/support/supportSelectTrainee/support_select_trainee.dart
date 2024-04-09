import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/selectTrainee_item_widget.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class TraineeCard extends StatelessWidget {
  final String traineeName;
  final String imageUrl;

  const TraineeCard({
    required this.traineeName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next screen using the route name
        Navigator.pushNamed(context, '/support_trainee_summary_container_screen');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(
            vertical: 35,
            horizontal: 20), // Adding margins between trainee cards

        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  traineeName,
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController searchController = TextEditingController();

// ignore: must_be_immutable
class SupportSelectTrainee extends StatelessWidget {
  SupportSelectTrainee({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          height: 492.v,
          width: 343.h,
          padding: EdgeInsets.symmetric(
            horizontal: 7.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SearchBar(context),
              Expanded(child: _buildFrameSix(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
    height: 46.v,
    leadingWidth: 35.h,
    leading: GestureDetector(
      onTap: () {
        // Navigate to the notification screen
        Navigator.pushNamed(context, '/notifications_screen_support');
      },
      child: Icon(
        Icons.notifications, // Replace with your notification icon
        color: Colors.white,
        size: 45, // Adjust size as needed
      ),
    ),
    centerTitle: true,
    title: AppbarTitle(
      text: "Trainees",
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
          right: 16.h,
        ),
        child: IconButton(
          icon: Icon(Icons.settings, color: Colors.white, size: 50),
          onPressed: () {
            // Navigate to the settings screen
            Navigator.pushNamed(context, '/support_staff_settings');
          },
        ),
      ),
    ],
    styleType: Style.bgShadow,
    //styleType: Style.bgShadow_1,
  );
}



  /// Section Widget
  Widget _buildFrameSix(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        return TraineeCard(
          traineeName: "Trainee ${index + 1}",
          imageUrl:
              "https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg",
        );
      },
    );
  }
}

/// Section Widget
Widget SearchBar(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: 20.v), //adjusting top margin
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomSearchView(
              controller: searchController,
              hintText: "Search Trainees",
            ),
          ),
        ],
      ),
    ),
  );
}
