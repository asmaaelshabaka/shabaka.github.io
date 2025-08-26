import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class TextIntroSection extends StatelessWidget {
  const TextIntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Margin below this section to separate it from subsequent blocks.
      margin: EdgeInsets.only(bottom: AppSizes.getSpacingMedium(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppSizes.getBorderRadiusMedium(context),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      padding: EdgeInsets.all(AppSizes.getPaddingLarge(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to ShabakaHub!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.getFontSizeSuperLarge(context),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: AppSizes.getSpacingMedium(context)),

          // App description - provides a brief overview
          Text(
            'Your ultimate platform to Learn, Grow, and Share Your Work. Discover a world of courses, connect with experts, and showcase your unique talents.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: AppSizes.getFontSizeLarge(context),
            ),
          ),
          SizedBox(height: AppSizes.getSpacingLarge(context)),
          // ElevatedButton(
          //   // Action: Navigate to the course list page when the button is pressed.
          //   onPressed: () {
          //     Get.toNamed(Routes.COURSES);
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: AppSizes.getPaddingMedium(context),
          //       vertical: AppSizes.getSpacingMedium(context) * 0.8,
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(
          //         AppSizes.getBorderRadiusMedium(context),
          //       ),
          //     ),
          //   ),
          //
          //   child: Text(
          //     'Explore Courses',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Theme.of(context).colorScheme.onPrimary,
          //       fontSize: AppSizes.getFontSizeMedium(context)
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
