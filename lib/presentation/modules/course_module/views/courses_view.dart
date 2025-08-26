import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:shabakahub2025/presentation/widgets/shared_components/course_card.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import '../controllers/course_controller.dart';

class CoursesByCategoryView extends GetView<CourseController> {
  const CoursesByCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the category parameters
    final categoryId = Get.parameters['categoryId'];
    final categoryName = Get.parameters['categoryName'];

    // Call the load function when the view builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryId != null && categoryName != null) {
        controller.loadCoursesForCategory(
          id: categoryId,
          name: categoryName,
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        titleText: categoryName != null
            ? 'Courses in $categoryName'
            : 'Category Courses',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.primaryColor),
                SizedBox(height: AppSizes.getSpacingMedium(context)),
                Text(
                  'Loading courses...',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: AppSizes.getFontSizeMedium(context),
                  ),
                ),
              ],
            ),
          );
        } else if (controller.coursesbycat.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: AppSizes.getIconSizeXLarge(context),
                  color: AppColors.greyText,
                ),
                SizedBox(height: AppSizes.getSpacingMedium(context)),
                Text(
                  'No courses found for this category.',
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: AppSizes.getFontSizeMedium(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
              padding: EdgeInsets.only(
                left: AppSizes.getPaddingMedium(context),
                right: AppSizes.getPaddingMedium(context),
                bottom: AppSizes.getPaddingMedium(context),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSizes.getSpacingMedium(context),
                mainAxisSpacing: AppSizes.getSpacingMedium(context),
                childAspectRatio: 0.7,
              ),
              itemCount: controller.coursesbycat.length,
              itemBuilder: (context, index) {
                final course = controller.coursesbycat[index];
                return CourseCard(course: course);
              },
            ),
          );
        }
      }),
    );
  }
}