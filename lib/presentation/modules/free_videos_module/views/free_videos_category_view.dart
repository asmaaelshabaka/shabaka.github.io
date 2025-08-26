// lib/modules/course_module/views/categories_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/widgets/shared_components/category_card.dart'; // Import your CategoryCard
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/routes/app_routes.dart'; // Import app_routes for navigation

// Import your custom app bar to reuse it
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:shabakahub2025/presentation/widgets/drawer_nav/app_drawer.dart';

import '../../course_module/controllers/category_controller.dart'; // Import AppDrawer


class FreeVideosCategoryView  extends GetView<CategoryController> {
  const FreeVideosCategoryView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // REMOVED: Get.lazyPut(() => HomeController()); // This should be handled by HomeBinding for the Home route

    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      // Use your CustomAppBar here, matching the style of your HomeView
      appBar: CustomAppBar(
        titleText: 'All Categories',
      ),

      // AppDrawer should be accessible from this screen
      drawer: const AppDrawer(),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
        child: Obx( // This Obx specifically reacts to changes in controller.categories and isLoading
              () {
            if (controller.isLoading.value) { // <--- CORRECTED: Check isLoading for loading state
              return Center(
                child: Column(

                  children: [
                    SizedBox(height: AppSizes.getScreenHeight(context) * 0.3), // Adjust vertical position
                    CircularProgressIndicator(color: AppColors.primaryColor),
                    SizedBox(height: AppSizes.getSpacingMedium(context)),
                    Text(
                      'Loading categories...',
                      style: TextStyle(color: AppColors.textColor, fontSize: AppSizes.getFontSizeMedium(context)),
                    ),
                  ],
                ),
              );
            } else if (controller.categories.isEmpty) { // <--- CORRECTED: Check isEmpty AFTER loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.category_outlined, size: AppSizes.getIconSizeXLarge(context), color: AppColors.greyText),
                    SizedBox(height: AppSizes.getSpacingMedium(context)),
                    Text(
                      'No categories found.',
                      style: TextStyle(color: AppColors.greyText, fontSize: AppSizes.getFontSizeMedium(context)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            else {
              // Display categories in a Wrap layout
              return Wrap(
                spacing: AppSizes.getSpacingSmall(context), // Horizontal spacing
                runSpacing: AppSizes.getSpacingSmall(context), // Vertical spacing
                children: controller.categories.map((category) {
                  return CategoryCard(
                    category: category,
                    onTap: () { // onTap callback for CategoryCard
                      Get.toNamed(
                        Routes.FREE_VIDEOS, // Navigate to a new route
                        parameters: {'free_categoryId': category.id, 'free_categoryName': category.name}, // Pass category ID and name
                      );
                    },
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
