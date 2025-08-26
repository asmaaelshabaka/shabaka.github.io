import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

import '../../../routes/app_routes.dart';
import '../home_sections/build_nav_link.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;

  const CustomAppBar({Key? key, this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      toolbarHeight: 150,
      title: Column(
        children: [
          // Top Row: Update text, Login/Register, Social Icons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


              ],
            ),
          ),
          const SizedBox(height: 8),
          // Main Nav Row: Logo, Navigation Links, Search, Login Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // **Corrected Logo Sizing**
                SizedBox(
                  height: 116, // Keep height to match other elements
                  width: 123,  // **Adjusted this value to a smaller width**
                  child: Image.asset(
                    'assets/images/lii-01-01.png',
                    fit: BoxFit.fill, // **Changed fit to fill height without stretching horizontally**
                  ),
                ),

                // Navigation Links
                Row(
                  children: [
                    buildNavLink(title: 'Home','',routeName: Routes.HOME,),
                    buildNavLink(title: 'Courses','',routeName: Routes.CATEGORY,),
                    buildNavLink(title: 'instractours','',routeName: Routes.ALL_INSTRUCTORS,),
                    buildNavLink(title: 'Free Preparation Videos','',routeName: Routes.FREE_VIDEOS_CATEGORIES,),
                    buildNavLink(title: 'About Us','',routeName: Routes.ABOUT_US,),
                    buildNavLink(title: 'Contact Us','',routeName: Routes.CONTACT_US,),

                  ],
                ),

                // Right-side widgets
                Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black),
                    SizedBox(width: AppSizes.getPaddingSmall(context)),
                    ElevatedButton(
                      onPressed: () {Get.toNamed(Routes.AUTH);},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Example button color
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Login To Course'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  @override
  Size get preferredSize => const Size.fromHeight(150);
}