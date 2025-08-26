import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_sizes.dart';

// Renamed the class to NavigationListTile
// This name clearly indicates its purpose as a reusable component for navigation items
// within a drawer or menu.
class NavigationListTile extends StatelessWidget {
  // Use a const constructor for better performance with immutable widgets.
  const NavigationListTile({
    super.key, // Best practice: include Key in constructors
    required this.title,      // Renamed from 'txt' to 'title' for clarity and standard ListTile naming
    required this.leadingIcon, // Renamed from 'icon' to 'leadingIcon' to specify its position
    this.routeName,           // Renamed from 'route' to 'routeName' for clarity.
    // Made nullable (String?) because not all list tiles might navigate.
    this.onTapCallback,       // Added an optional 'onTapCallback' for custom actions.
  });

  final String title;
  final IconData leadingIcon;
  final String? routeName; // Can be null if a custom onTapCallback is provided
  final VoidCallback? onTapCallback; // A function to be executed when the tile is tapped

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon, color: AppColors.textColor),
      title: Text(
        title,
        // Using getFontSizeMedium for better legibility in list items on web
        style: TextStyle(color: AppColors.textColor, fontSize: AppSizes.getFontSizeSmall(context)),
      ),
      onTap: () {
        // Always close the drawer when a menu item is tapped
        Get.back();

        if (onTapCallback != null) {
          // If a custom callback is provided, execute it.
          onTapCallback!();
        } else if (routeName != null) {
          // If no custom callback, but a routeName is provided, navigate to that route.
          // Check if already on the route to prevent redundant navigation stack entries.
          if (Get.currentRoute != routeName) {
            // Consider if Get.toNamed (pushes a new route) or Get.offAllNamed (replaces stack)
            // is appropriate based on your navigation flow for each specific item.
            // For general menu items (e.g., "All Courses", "Settings"), Get.toNamed is often used.
            // For "Home" or "Logout", Get.offAllNamed is common.
            Get.toNamed(routeName!); // Default navigation: push the new route
          }
        }
        // If neither onTapCallback nor routeName is provided, the tile does nothing on tap.
      },
    );
  }
}