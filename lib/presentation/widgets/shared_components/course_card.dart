// lib/presentation/widgets/shared_components/course_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/course_model.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/routes/app_routes.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseCard({
    Key? key,
    required this.course,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using a fixed height for the image for more predictable card sizing
    const double fixedImageHeight = 120.0; // Adjusted for better fit
    final double screenWidth = AppSizes.getScreenWidth(context);
    final double desiredCardWidth = screenWidth * 0.9;

    const double minCardWidth = 300;
    const double maxCardWidth = 600;
    final double finalCardWidth = desiredCardWidth.clamp(minCardWidth, maxCardWidth);

    return Center(
      child: InkWell(
        onTap: onTap ?? () {
          // Default onTap behavior: Navigate to course details
          Get.toNamed(Routes.COURSE_DETAILS, arguments: course.id); // Assuming course.id is the argument
        },
        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
        child: Container(
          width: finalCardWidth,
          // Removed minHeight constraint to allow more flexible sizing by parent
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Use min to wrap content
            children: [
              // Course Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.getBorderRadiusMedium(context)),
                ),
                child: SizedBox(
                  height: fixedImageHeight, // Using fixed height
                  width: double.infinity,
                  child: Image.network(
                    course.imageUrl ?? 'https://placehold.co/600x${fixedImageHeight.round()}/cccccc/333333?text=Image+Unavailable',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.greyText.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            'Image Failed to Load',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textColor, fontSize: AppSizes.getFontSizeSmall(context)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Content Area
              // Using Flexible instead of Expanded here for more controlled sizing within the Column.
              // Expanded would try to take all available space, which might not be desired
              // if the Column itself is within a parent that provides limited height.
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Ensure inner column wraps its content
                    children: [
                      // Course Title
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppSizes.getFontSizeLarge(context),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: AppSizes.getSpacingSmall(context)),

                      // Instructor
                      if (course.instructor != null && course.instructor!.isNotEmpty) // Added check for empty string
                        Text(
                          'Instructor: ${course.instructor}',
                          style: TextStyle(
                            fontSize: AppSizes.getFontSizeSmall(context),
                            color: AppColors.greyText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      SizedBox(height: AppSizes.getSpacingExtraSmall(context)),

                      // Rating and Reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: AppSizes.getIconSizeSmall(context)),
                          SizedBox(width: AppSizes.getSpacingExtraSmall(context)),
                          Text(
                            '${course.rating?.toStringAsFixed(1) ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: AppSizes.getFontSizeMedium(context),
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (course.reviewsCount != null && course.reviewsCount! > 0) ...[ // Added check for reviewsCount > 0
                            SizedBox(width: AppSizes.getSpacingExtraSmall(context)),
                            Text(
                              '(${course.reviewsCount} reviews)',
                              style: TextStyle(
                                fontSize: AppSizes.getFontSizeSmall(context),
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: AppSizes.getSpacingSmall(context)),

                      // Course Description
                      // Using Flexible instead of Expanded here to prevent overflow if description is too long
                      // and to allow other elements to be visible.
                      Flexible(
                        child: Text(
                          course.description ?? 'No description available.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppSizes.getFontSizeMedium(context),
                            color: AppColors.greyText,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.getSpacingMedium(context)),

                      // Price and Forward Arrow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${course.price?.toStringAsFixed(2) ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: AppSizes.getFontSizeXLarge(context),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: AppSizes.getIconSizeSmall(context),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
