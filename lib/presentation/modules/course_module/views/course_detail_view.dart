// lib/modules/course_detail_module/views/course_detail_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:video_player/video_player.dart';

import '../controllers/course_detail_controller.dart'; // For VideoPlayer widget


class CourseDetailView extends GetView<CourseDetailController> {
  const CourseDetailView({Key? key}) : super(key: key);

  // Removed: _launchWhatsApp function is now in the controller <--- REMOVED

  @override
  Widget build(BuildContext context) {
    // Removed: Access AuthController here, it's now in CourseDetailController <--- REMOVED

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        titleText: 'Course Details',
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (controller.course == null) {
            return Center(
              child: Text(
                'Course not found or failed to load.',
                style: TextStyle(color: AppColors.textColor),
              ),
            );
          } else {
            final course = controller.course!;
            final lessons = controller.lessons;

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Title
                  Text(
                    course.title,
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeXLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingSmall(context)),

                  // Instructor and Rating
                  Row(
                    children: [
                      Text(
                        'Instructor: ${course.instructor ?? 'N/A'}',
                        style: TextStyle(fontSize: AppSizes.getFontSizeMedium(context), color: AppColors.greyText),
                      ),
                      SizedBox(width: AppSizes.getSpacingMedium(context)),
                      Icon(Icons.star, color: Colors.amber, size: AppSizes.getIconSizeSmall(context)),
                      Text(
                        '${course.rating?.toStringAsFixed(1) ?? 'N/A'} (${course.reviewsCount ?? 0} reviews)',
                        style: TextStyle(fontSize: AppSizes.getFontSizeSmall(context), color: AppColors.greyText),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Intro Video Player
                  if (controller.isVideoInitialized.value)
                    Container(
                      height: AppSizes.getScreenHeight(context) * 0.35,
                      child: AspectRatio(
                        aspectRatio: controller.videoPlayerController.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(controller.videoPlayerController),
                            Obx(() => Visibility(
                              visible: controller.showControls.value,
                              child: VideoProgressIndicator(
                                controller.videoPlayerController,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: AppColors.primaryColor,
                                  bufferedColor: AppColors.greyText.withOpacity(0.5),
                                  backgroundColor: AppColors.greyText.withOpacity(0.2),
                                ),
                              ),
                            )),
                            Obx(() => Center(
                              child: GestureDetector(
                                onTap: controller.togglePlayPause,
                                child: AnimatedOpacity(
                                  opacity: controller.showControls.value ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: FloatingActionButton(
                                    onPressed: controller.togglePlayPause,
                                    backgroundColor: AppColors.primaryColor.withOpacity(0.7),
                                    child: Icon(
                                      controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                                      color: AppColors.hubWhite,
                                      size: AppSizes.getIconSizeMedium(context),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    )
                  else if (course.introVideoUrl != null && course.introVideoUrl!.isNotEmpty)
                    Container(
                      height: AppSizes.getScreenHeight(context) * 0.35,
                      color: AppColors.greyText.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          'Video not available or failed to load.',
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: AppSizes.getScreenHeight(context) * 0.35,
                      color: AppColors.greyText.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          'No Intro Video for this course.',
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      ),
                    ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Course Description
                  Text(
                    course.description ?? 'No description provided for this course.',
                    style: TextStyle(fontSize: AppSizes.getFontSizeMedium(context), color: AppColors.textColor),
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Enroll Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Call the controller's method directly <--- MODIFIED
                        controller.handleEnrollment(course); // <--- MODIFIED
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.hubWhite,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.getPaddingLarge(context),
                          vertical: AppSizes.getPaddingMedium(context),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Enroll Now - \$${course.price?.toStringAsFixed(2) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: AppSizes.getFontSizeLarge(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Lessons Stepper
                  Text(
                    'Course Curriculum',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),
                  if (lessons.isNotEmpty)
                    Stepper(
                      currentStep: controller.currentStep.value,
                      onStepContinue: controller.nextStep,
                      onStepCancel: controller.previousStep,
                      onStepTapped: controller.goToStep,
                      steps: lessons.mapIndexed((index, lesson) {
                        return Step(
                          title: Text('Lesson ${lesson.order}: ${lesson.title}'),
                          content: Text(lesson.description),
                          isActive: index <= controller.currentStep.value,
                          state: index == controller.currentStep.value
                              ? StepState.editing
                              : (index < controller.currentStep.value ? StepState.complete : StepState.indexed),
                        );
                      }).toList(),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizes.getPaddingMedium(context)),
                      child: Text(
                        'No lessons available for this course yet.',
                        style: TextStyle(fontSize: AppSizes.getFontSizeMedium(context), color: AppColors.greyText),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Extension to map with index (for Stepper)
extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) sync* {
    var index = 0;
    for (var item in this) {
      yield f(index, item);
      index++;
    }
  }
}
