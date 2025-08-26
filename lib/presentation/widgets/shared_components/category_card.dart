import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/models/category_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/category_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_sizes.dart';
import '../../modules/course_module/controllers/course_controller.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = AppSizes.getCategoryCardWidth(context);
    final double cardHeight = AppSizes.getCategoryCardHeight(context);
    final CourseController courseController = Get.find<CourseController>();

    return InkWell(
      onTap: onTap ?? () {
        // Get the category ID and name
        final categoryId = category.id;
        final categoryName = category.name;

        // 1. Call the controller function to fetch the data
        // The controller will now start fetching the courses for this category.
        // courseController.fetchCoursesByCategoryId(categoryId);
        Get.toNamed(
          Routes.COURSES,
          parameters: {
            'categoryId': category.id,
            'categoryName': category.name,
          },
        )?.then((_){

          courseController.fetchCoursesByCategoryId(categoryId);
        });
      },
      borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusLarge(context)),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppColors.hubWhite, // Use the new brand white color
          borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusLarge(context)),
          border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.hubBlack.withOpacity(0.05), // Use the new brand black color for shadows
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Container
              Container(
                height: cardHeight * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.1), // Use a lightened version of the brand orange
                  borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                ),
                child: Center(
                  child: category.imageUrl != null && category.imageUrl!.isNotEmpty
                      ? Padding(
                    padding: EdgeInsets.all(AppSizes.getPaddingSmall(context)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusSmall(context)),
                      child: Image.network(
                        category.imageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.category,
                            size: AppSizes.getIconSizeLarge(context),
                            color: AppColors.primaryOrange, // Use the brand orange for the fallback icon
                          );
                        },
                      ),
                    ),
                  )
                      : Icon(
                    Icons.category,
                    size: AppSizes.getIconSizeLarge(context),
                    color: AppColors.primaryOrange, // Use the brand orange for the icon
                  ),
                ),
              ),

              SizedBox(height: AppSizes.getSpacingMedium(context)),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Name
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: AppSizes.getFontSizeMedium(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: AppSizes.getSpacingSmall(context)),

                    // Category Description
                    if (category.description != null && category.description!.isNotEmpty)
                      Expanded(
                        child: Text(
                          category.description!,
                          style: TextStyle(
                            fontSize: AppSizes.getFontSizeSmall(context),
                            color: AppColors.greyText,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: AppSizes.getSpacingMedium(context)),

              // Explore Button
              ElevatedButton(  onPressed: null, // Uses parent InkWell's onTap
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: AppSizes.getFontSizeSmall(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange, // Use the brand orange for the button
                  foregroundColor: AppColors.hubWhite, // Use the brand white for the text on the button
                  minimumSize: Size(double.infinity, AppSizes.getButtonHeightMedium(context)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.getPaddingSmall(context)),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
