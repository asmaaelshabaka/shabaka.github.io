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
    const double fixedImageHeight = 120.0;

    return InkWell(
      onTap: onTap ??
              () {
            Get.toNamed(Routes.COURSE_DETAILS, arguments: course.id);
          },
      borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
      child: Container(
        // Let GridView control the width
        width: double.infinity,
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
          mainAxisSize: MainAxisSize.max, // stretch to fill available height
          children: [
            // Course Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.getBorderRadiusMedium(context)),
              ),
              child: SizedBox(
                height: fixedImageHeight,
                width: double.infinity,
                child: Image.network(
                  course.imageUrl ??
                      'https://placehold.co/600x${fixedImageHeight.round()}/cccccc/333333?text=Image+Unavailable',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.greyText.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          'Image Failed to Load',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: AppSizes.getFontSizeSmall(context),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Content Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (course.instructor != null && course.instructor!.isNotEmpty)
                      Text(
                        'Instructor: ${course.instructor}',
                        style: TextStyle(
                          fontSize: AppSizes.getFontSizeSmall(context),
                          color: AppColors.greyText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (course.instructor != null && course.instructor!.isNotEmpty)
                      SizedBox(height: AppSizes.getSpacingExtraSmall(context)),

                    // Rating and Reviews
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: AppSizes.getIconSizeSmall(context),
                        ),
                        SizedBox(width: AppSizes.getSpacingExtraSmall(context)),
                        Text(
                          '${course.rating?.toStringAsFixed(1) ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: AppSizes.getFontSizeMedium(context),
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (course.reviewsCount != null && course.reviewsCount! > 0) ...[
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

                    // Course Description (Preview Only)
                    Expanded(
                      child: Text(
                        course.description ?? 'No description available.',
                        maxLines: 3,
                      //  minLines: 3, // keep consistent height
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppSizes.getFontSizeMedium(context),
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Price and Forward Arrow
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.getPaddingMedium(context),
                vertical: AppSizes.getPaddingSmall(context),
              ),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
