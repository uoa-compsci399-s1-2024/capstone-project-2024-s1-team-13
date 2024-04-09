import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'widgets/admin_trainee_view_widget.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_admin.dart';

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
        Navigator.pushNamed(
            context, '/trainee_profile_page');
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
class AdminTraineeView extends StatelessWidget {
  AdminTraineeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 6.v),
              decoration: AppDecoration.fillOnError,
              child: Column(
                children: [
                  SearchBar(context),
                  Expanded(child: _buildFrameSix(context)),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomBar(), // Add CustomBottomBarAdmin widget
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 46.v,
      leadingWidth: 30.h,
      leading: GestureDetector(
        onTap: () {
          // Navigate to the previous screen
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 40,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Trainees",
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.h),
          child: IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 50),
            onPressed: () {
              // Add functionality to navigate to the add screen
              Navigator.pushNamed(context, '/admin_add_trainee_screen');
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.h),
          child: IconButton(
            icon: Icon(Icons.edit, color: Colors.white, size: 50),
            onPressed: () {
              // Add functionality to navigate to the edit screen
              Navigator.pushNamed(context, '/admin_edit_trainees_screen');
            },
          ),
        ),
      ],
      styleType: Style.bgShadow,
      //styleType: Style.bgShadow_1,
    );
  }

  Widget _buildFrameSix(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 12),
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

Widget SearchBar(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: 10.v),
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
