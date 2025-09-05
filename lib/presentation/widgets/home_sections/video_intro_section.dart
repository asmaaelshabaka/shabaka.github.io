// lib/presentation/widgets/home_sections/video_intro_section.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/presentation/modules/home_module/controllers/intro_video_controller.dart';

class VideoIntroSection extends StatelessWidget {
  const VideoIntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IntroVideoController controller =
    Get.put(IntroVideoController(Get.find()));
    final double borderRadius = AppSizes.getBorderRadiusMedium(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSizes.getSpacingMedium(context)),
      decoration: BoxDecoration(
        color: Colors.black, // Changed to black to match video background
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (controller.hasError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: AppColors.errorColor,
                      size: AppSizes.getIconSizeLarge(context)),
                  SizedBox(height: AppSizes.getSpacingSmall(context)),
                  Text(
                    'Could not load video. Check URL or internet.',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.getFontSizeMedium(context)),
                  ),
                ],
              ),
            );
          } else if (!controller.isInitialized.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                  borderRadius - AppSizes.getSpacingSmall(context)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Use SizedBox.expand to fill the container and BoxFit.cover to remove gray space
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.videoPlayerController.value.size.width,
                        height: controller.videoPlayerController.value.size.height,
                        child: VideoPlayer(controller.videoPlayerController),
                      ),
                    ),
                  ),

                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.black.withOpacity(0.25),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // Animated Play/Pause button
                  GestureDetector(
                    onTap: controller.togglePlayPause,
                    child: AnimatedOpacity(
                      opacity: controller.isPlaying.value ? 0.3 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: AppSizes.getIconSizeLarge(context) * 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Bottom controls bar (only fullscreen now)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: () {
                        // TODO: handle fullscreen
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}