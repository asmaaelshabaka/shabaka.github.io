// lib/presentation/widgets/home_sections/featured_courses_table_section.dart
// NOTE: The file path in the comment above seems to be incorrect based on the class name.
// Assuming this is actually lib/presentation/widgets/home_sections/featured_courses_section.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/presentation/widgets/home_sections/latest_update_tile.dart'; // Keep if used
import 'package:shabakahub2025/presentation/widgets/shared_components/course_card.dart'; // Import your CourseCard

import '../../modules/course_module/controllers/course_controller.dart'; // Import the CourseController
import 'package:shabakahub2025/routes/app_routes.dart'; // Assuming you still need this for navigation

class FeaturedCoursesSection extends GetView<CourseController> {
  const FeaturedCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller injected by GetX
    final controller = Get.find<CourseController>();

    return Obx(() {
      // Show a loading spinner while data is being fetched
      if (controller.isLoading.value) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: AppSizes.getSpacingMedium(context)),
          padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      // Changed to use 'popularCourses' list to fetch courses for the home screen
      final List<dynamic> coursesToDisplay = controller.courses;

      // Show a message if there are no courses available
      if (coursesToDisplay.isEmpty) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: AppSizes.getSpacingMedium(context)),
          padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text('No courses found.beeeeeeeeeeeeeeeeeeeeeeeeb'), // Updated message
          ),
        );
      }

      // Otherwise, display the list of courses
      return Container(
        margin: EdgeInsets.symmetric(vertical: AppSizes.getSpacingMedium(context)),
        padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.getSpacingSmall(context), left: AppSizes.getPaddingSmall(context)),
              child: Text(
                'All Courses', // Updated title
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeXLarge(context),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            SizedBox(height: AppSizes.getSpacingSmall(context)),
            // Horizontal Scrollable List of Course Cards
            SizedBox(
              // Increased height to give more vertical space for the cards.
              // If overflow persists, the issue is likely within CourseCard itself.
              height: AppSizes.getBaseUnit(context) * 25, // <--- MODIFIED HEIGHT
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: coursesToDisplay.length, // Use the correct list here
                itemBuilder: (context, index) {
                  final course = coursesToDisplay[index]; // Use the correct list here
                  return Padding(
                    padding: EdgeInsets.only(right: AppSizes.getSpacingMedium(context)),
                    child: CourseCard(
                      course: course,
                      onTap: () {
                        Get.toNamed(Routes.COURSE_DETAILS, arguments: course.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
