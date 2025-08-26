// lib/presentation/modules/instructor_module/views/instructor_view.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../controllers/all_instructors_controller.dart';

class InstructorView extends GetView<InstructorController> {
  const InstructorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A custom app bar with a title.
      appBar: CustomAppBar(titleText: 'All Instructors'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.getPaddingSmall(context),
          vertical: AppSizes.getSpacingSmall(context),
        ),
        child: Obx(() {
          // Display a loading indicator while data is being fetched.
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display an error message if an error occurred.
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          // Display the list of instructors in a grid view with a new card design.
          if (controller.instructors.isNotEmpty) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppSizes.getCrossAxisCount(context),
                crossAxisSpacing: AppSizes.getSpacingSmall(context),
                mainAxisSpacing: AppSizes.getSpacingSmall(context),
                childAspectRatio: 0.7, // Adjusted for the new card design.
              ),
              itemCount: controller.instructors.length,
              itemBuilder: (context, index) {
                final instructor = controller.instructors[index];

                // The new instructor card design.
                return InkWell(
                  onTap: () {
                    // TODO: Implement navigation to the instructor's profile page.
                    // Example: Get.toNamed('/instructor-profile', arguments: instructor);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Instructor image section.
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: AspectRatio(
                            aspectRatio: 1, // Make the image a square.
                             // Replace the entire FadeInImage widget with:
                            child: instructor.profilePictureUrl != null && instructor.profilePictureUrl!.isNotEmpty
                          ? CachedNetworkImage(
                          imageUrl: instructor.profilePictureUrl!,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/man.png',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/man.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          )
                      : Image.asset(
                  'assets/images/man.png',
                  fit: BoxFit.cover,
                ),
                          ),
                        ),
                        // Instructor details section.
                        Padding(
                          padding: EdgeInsets.all(AppSizes.getPaddingSmall(context)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                instructor.name,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppSizes.getSpacingExtraSmall(context)),
                              Text(
                                instructor.bio,
                                style: Get.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // Display a message if no instructors are found.
          return const Center(child: Text('No instructors found.'));
        }),
      ),
    );
  }
}
