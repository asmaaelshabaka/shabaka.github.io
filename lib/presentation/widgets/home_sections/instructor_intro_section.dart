// lib/presentation/widgets/home_sections/instructor_intro_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/widgets/shared_components/instructor_card.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/utils/app_colors.dart';

import '../../../routes/app_routes.dart' show Routes;
import '../../modules/instructor_module/controllers/all_instructors_controller.dart';

/// A section for the home screen that displays a horizontal list of instructors.
class InstructorIntroSection extends GetView<InstructorController> {
  const InstructorIntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The controller is automatically found and injected by GetView.
    final controller = Get.find<InstructorController>();

    return Obx(
          () {
        // Show a loading spinner while data is being fetched
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show an error message if the controller has an error
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error loading instructors: ${controller.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Show a message if there are no instructors available
        if (controller.instructors.isEmpty) {
          return const Center(
            child: Text(
              'No instructors found.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        // Otherwise, display the horizontal list of instructors
        return Container(
          margin: EdgeInsets.only(bottom: AppSizes.getSpacingMedium(context)),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.getPaddingMedium(context),
            vertical: AppSizes.getPaddingSmall(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meet Our Expert Instructors',
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeLarge(context),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: AppSizes.getSpacingMedium(context)),
              SizedBox(
                height: AppSizes.getInstructorCardHeight(context),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.instructors.length,
                  itemBuilder: (context, index) {
                    return InstructorCard(instructor: controller.instructors[index]);
                  },
                ),
              ),
              SizedBox(height: AppSizes.getSpacingMedium(context)),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_INSTRUCTORS);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusSmall(context))),
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.getPaddingMedium(context), vertical: AppSizes.getPaddingSmall(context)),
                  ),
                  child: Text(
                    'View All Instructors',
                    style: TextStyle(fontSize: AppSizes.getFontSizeMedium(context), color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
