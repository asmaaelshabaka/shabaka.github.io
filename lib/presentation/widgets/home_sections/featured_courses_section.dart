// lib/presentation/widgets/home_sections/featured_courses_section.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/presentation/widgets/shared_components/course_card.dart';
import '../../modules/course_module/controllers/course_controller.dart';
import 'package:shabakahub2025/routes/app_routes.dart';

class FeaturedCoursesSection extends GetView<CourseController> {
  const FeaturedCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CourseController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildContainer(
          context,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final coursesToDisplay = controller.courses;

      if (coursesToDisplay.isEmpty) {
        return _buildContainer(
          context,
          child: const Center(
            child: Text('No courses found.'),
          ),
        );
      }

      return _buildContainer(
        context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Padding(
              padding: EdgeInsets.only(
                bottom: AppSizes.getSpacingSmall(context),
                left: AppSizes.getPaddingSmall(context),
              ),
              child: Text(
                'All Courses',
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeXLarge(context),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            SizedBox(height: AppSizes.getSpacingSmall(context)),

            // Grid of courses
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: coursesToDisplay.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.getCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: controller.getChildAspectRatio(context),
              ),
              itemBuilder: (context, index) {
                final course = coursesToDisplay[index];
                return AspectRatio(
                  aspectRatio: 3 / 4, // width : height (adjust as needed)
                  child: CourseCard(course: course),
                );
              },
            )
          ],
        ),
      );
    });
  }

  /// Helper method to wrap sections with consistent styling
  Widget _buildContainer(BuildContext context, {required Widget child}) {
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
      child: child,
    );
  }
}
