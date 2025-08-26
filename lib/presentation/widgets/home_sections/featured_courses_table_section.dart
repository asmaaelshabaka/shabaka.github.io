// lib/presentation/widgets/home_sections/featured_courses_table_section.dart

import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
// Import the new LatestUpdateTile widget
import 'package:shabakahub2025/presentation/widgets/home_sections/latest_update_tile.dart'; // <--- NEW IMPORT

class FeaturedCoursesTableSection extends StatelessWidget {
  const FeaturedCoursesTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for the table. This is the data we'll now map to LatestUpdateTiles.
    final List<Map<String, String>> coursesData = [
      {'title': 'Flutter Web Dev Basics', 'instructor': 'Jane Doe', 'progress': '75%'},
      {'title': 'UI/UX Design Masterclass', 'instructor': 'John Smith', 'progress': 'Completed'},
      {'title': 'Advanced GetX State Mgmt', 'instructor': 'Alice Green', 'progress': '20%'},
      {'title': 'Backend with Firebase', 'instructor': 'Bob White', 'progress': 'N/A'},
      {'title': 'Data Science with Python', 'instructor': 'Dr. Emily Chen', 'progress': '10%'},
      {'title': 'Cloud Computing Essentials', 'instructor': 'Mark Taylor', 'progress': 'N/A'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSizes.getSpacingMedium(context)),
      padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding( // Added Padding here for consistency with other sections
            padding: EdgeInsets.only(bottom: AppSizes.getSpacingSmall(context), left: AppSizes.getPaddingSmall(context)),
            child: Text(
              'Featured Courses & Latest Updates',
              style: TextStyle(
                fontSize: AppSizes.getFontSizeXLarge(context),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(height: AppSizes.getSpacingMedium(context)), // Spacing below the title

          // Replaced DataTable with a ListView.separated of LatestUpdateTiles
          ListView.separated( // <--- REPLACED DataTable and SingleChildScrollView
            shrinkWrap: true, // Important: Allows ListView to take only as much space as its children
            physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling if the parent page is scrollable
            itemCount: coursesData.length,
            separatorBuilder: (context, index) => SizedBox(height: AppSizes.getSpacingSmall(context)), // Add space between items
            itemBuilder: (context, index) {
              final course = coursesData[index];
              return LatestUpdateTile(
                title: course['title']!,
                instructor: course['instructor']!,
                progress: course['progress']!,
                onTap: () {
                  // Optional: Handle tap for this update tile
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tapped on: ${course['title']}')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}