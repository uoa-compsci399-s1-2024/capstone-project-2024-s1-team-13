import 'package:istefat_s_application1/presentation/admin/admin_remove_trainees_dialog/admin_remove_trainees_dialog.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/admin_edit_trainee_details_widget.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
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
            context, '/admin_edit_trainee_details_screen');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(
          vertical: 35,
          horizontal: 20,
        ), // Adding margins between trainee cards
        child: Stack(
          children: [
            Padding(
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
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  _showSaveTraineeDialog(context);
                  // Do something when the minus button is tapped
                },
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.red[400],
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveTraineeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: AdminRemoveTraineesDialog(),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}

TextEditingController searchController = TextEditingController();

// ignore: must_be_immutable
class AdminEditTraineesScreen extends StatelessWidget {
  AdminEditTraineesScreen({Key? key})
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
          decoration: AppDecoration.fillOnError,
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
      height: 49.v,
      leadingWidth: 38.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronBackButton,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 13.v,
          bottom: 13.v,
        ),
        onTap: () {
          onTapBack(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Edit Notes",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTickButton,
          height: 50,
          width:
              50, //edited appbar_trailing_image -- added height + width options
          margin: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 9.v),

          onTap: () {
            //do something when tick pressed
          },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  void onTapTickButton(BuildContext context) {}

  void onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminTraineeView);
  }
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
