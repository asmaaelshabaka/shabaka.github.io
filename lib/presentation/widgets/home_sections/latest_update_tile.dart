import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

// lib/presentation/widgets/home_sections/latest_update_tile.dart

import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_sizes.dart'; // For your responsive sizes
import 'package:shabakahub2025/utils/app_colors.dart'; // For your custom colors

class LatestUpdateTile extends StatelessWidget {
  final String title;
  final String instructor;
  final String progress;
  final VoidCallback? onTap; // Optional: to make the tile tappable

  const LatestUpdateTile({
    super.key,
    required this.title,
    required this.instructor,
    required this.progress,
    this.onTap,
  });

  // Helper to determine progress color/icon
  Color _getProgressColor(BuildContext context) {
    if (progress == 'Completed') {
      return AppColors.successColor; // A green color for completed
    } else if (progress == 'N/A' || progress == '0%') {
      return AppColors.greyText; // Grey for not applicable or not started
    } else {
      return Theme.of(context).colorScheme.primary; // Your primary color for in-progress
    }
  }

  IconData _getProgressIcon() {
    if (progress == 'Completed') {
      return Icons.check_circle;
    } else if (progress == 'N/A') {
      return Icons.do_not_disturb_on;
    } else {
      return Icons.circle; // A simple dot for in-progress
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Make the entire tile tappable
      borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusSmall(context)),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.getPaddingMedium(context),
          horizontal: AppSizes.getPaddingLarge(context),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant, // A slightly different background color
          borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusSmall(context)),
          border: Border.all(color: AppColors.borderColor.withOpacity(0.5)), // Subtle border
        ),
        child: Row(
          children: [
            // Left side: Course Title and Instructor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Take minimum vertical space
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeLarge(context), // Clear title
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.getSpacingSmall(context)),
                  Text(
                    'Instructor: $instructor',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeSmall(context), // Smaller for instructor
                      color: AppColors.greyText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSizes.getSpacingLarge(context)), // Space between text and progress

            // Right side: Progress Indicator/Text
            Row(
              mainAxisSize: MainAxisSize.min, // Take minimum horizontal space
              children: [
                Icon(
                  _getProgressIcon(),
                  color: _getProgressColor(context),
                  size: AppSizes.getIconSizeSmall(context), // Small icon
                ),
                SizedBox(width: AppSizes.getSpacingSmall(context)),
                Text(
                  progress,
                  style: TextStyle(
                    fontSize: AppSizes.getFontSizeMedium(context), // Progress text
                    fontWeight: FontWeight.w600,
                    color: _getProgressColor(context),
                  ),
                ),
                SizedBox(width: AppSizes.getSpacingSmall(context)),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppSizes.getIconSizeSmall(context), // Tiny arrow
                  color: AppColors.greyText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}