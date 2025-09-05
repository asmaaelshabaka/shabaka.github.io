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
      title: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 1000;

          return Column(
            children: [
              const SizedBox(height: 8),
              // Main Nav Row: Logo, Navigation Links, Search, Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: isSmallScreen
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        SizedBox(
          height: AppSizes.getLogoHeight(context),
          width: AppSizes.getLogoWidth(context),
          child: Image.asset(
            'assets/images/lii-01-01.png',
            fit: BoxFit.contain,
          ),
        ),

        // Navigation Links - Made scrollable for overflow
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BuildNavLink( 'Home',  routeName: Routes.HOME),
                BuildNavLink( 'Courses',  routeName: Routes.CATEGORY),
                BuildNavLink('Instructors',  routeName: Routes.ALL_INSTRUCTORS),
                BuildNavLink( 'Free Videos',  routeName: Routes.FREE_VIDEOS_CATEGORIES),
                BuildNavLink( 'About Us',  routeName: Routes.ABOUT_US),
                BuildNavLink('Contact Us',  routeName: Routes.CONTACT_US),
              ],
            ),
          ),
        ),

        // Right-side widgets with flexible sizing
        Container(
          constraints: BoxConstraints(maxWidth: AppSizes.getScreenWidth(context) * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.search, color: Colors.black, size: 20),
              SizedBox(width: AppSizes.getPaddingSmall(context)),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.AUTH),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.getPaddingSmall(context),
                    vertical: AppSizes.getPaddingSmall(context) / 2,
                  ),
                ),
                child: Text(
                  'Login To Course',
                  style: TextStyle(fontSize: AppSizes.getFontSizeSmall(context)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Logo row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: AppSizes.getLogoHeight(context) * 0.8,
              width: AppSizes.getLogoWidth(context) * 0.8,
              child: Image.asset(
                'assets/images/lii-01-01.png',
                fit: BoxFit.contain,
              ),
            ),
            // Hamburger menu for mobile

          ],
        ),

        SizedBox(height: AppSizes.getPaddingSmall(context)),

        // Search and Login button row for mobile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.search, color: Colors.black, size: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.AUTH),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.getPaddingSmall(context),
                  vertical: AppSizes.getPaddingSmall(context) / 2,
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: AppSizes.getFontSizeSmall(context)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}