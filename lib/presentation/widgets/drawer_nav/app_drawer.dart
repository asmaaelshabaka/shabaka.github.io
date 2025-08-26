// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/routes/app_routes.dart'; // Import your app routes
import 'package:shabakahub2025/utils/app_colors.dart'; // Import your AppColors
import 'package:shabakahub2025/utils/app_sizes.dart';

import 'list_tile.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Important for full height usage of the drawer
        children: <Widget>[
          // Drawer Header - uses responsive height and theme colors
          SizedBox( // Use SizedBox for explicit responsive height control
            height: AppSizes.getDrawerHeaderHeight(context), // <--- Correctly using AppSizes
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryOrange, // Use the new brand orange from AppColors
              ),
              margin: EdgeInsets.zero, // Remove default margin from DrawerHeader
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.getPaddingSmall(context), // <--- Using AppSizes
                vertical: AppSizes.getSpacingSmall(context),   // <--- Using AppSizes
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end, // Align content to bottom
                children: [
                  CircleAvatar(
                    radius: AppSizes.getIconSizeLarge(context) / 1.5, // <--- Responsive radius derived from icon size
                    backgroundColor: AppColors.hubWhite, // Use the new brand white for the avatar background
                    child: Icon(
                      Icons.person,
                      size: AppSizes.getIconSizeSmall(context), // <--- Responsive icon size
                      color: AppColors.primaryOrange, // Icon color matches the primary brand orange
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingSmall(context)), // <--- Using AppSizes
                  Text(
                    'Asmaa Elshabaka',
                    style: TextStyle(
                      color: AppColors.hubWhite, // Use the new brand white for the text color
                      fontSize: AppSizes.getFontSizeSmall(context), // <--- Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1, // Keep maxLines: 1 for the main title to ensure it stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Learn, Grow, share your work', // Updated text
                    style: TextStyle(
                      color: AppColors.hubWhite.withOpacity(0.8), // Slightly transparent white
                      fontSize: AppSizes.getFontSizeSmall(context), // <--- Responsive font size
                    ),
                    // REMOVED maxLines and overflow here to allow this text to wrap if it's too long
                    // This helps prevent vertical overflow in the DrawerHeader.
                  ),
                ],
              ),
            ),
          ),
          // Drawer Items - ListTiles are inherently responsive to their container width
          // Text and icon colors are explicitly set using AppColors for consistency

          NavigationListTile(title: 'Home',leadingIcon: Icons.home,routeName: Routes.HOME,),
          NavigationListTile(title: 'Categories-Courses',leadingIcon: Icons.school,routeName: Routes.CATEGORY,),
          NavigationListTile(title: 'instructors',leadingIcon: Icons.person_2_rounded,routeName: Routes.ALL_INSTRUCTORS ,),
          NavigationListTile(title: 'Share Your Work',leadingIcon: Icons.share,),
          NavigationListTile(title: ' Free videos',leadingIcon: Icons.video_camera_back_outlined,routeName: Routes.FREE_VIDEOS_CATEGORIES,),
          NavigationListTile(title: ' About Us',leadingIcon: Icons.contact_page,routeName: Routes.ABOUT_US,),
          NavigationListTile(title: ' Contact Us',leadingIcon: Icons.perm_device_info,routeName: Routes.CONTACT_US,),


          NavigationListTile(title: 'Profile',leadingIcon: Icons.home,routeName: Routes.HOME,),



          Divider(color: AppColors.greyText.withOpacity(0.5)), // A visual separator
          NavigationListTile(title: 'Log Out',leadingIcon: Icons.logout,routeName: Routes.AUTH,),
        ],
      ),
    );
  }
}