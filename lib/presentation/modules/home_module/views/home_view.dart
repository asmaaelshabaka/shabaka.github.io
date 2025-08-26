import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/home_sections/featured_courses_section.dart';
import '../../../widgets/home_sections/instructor_intro_section.dart';
import '../../../widgets/home_sections/text_intro_section.dart';
import '../../../widgets/home_sections/video_intro_section.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/drawer_nav/app_drawer.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.getPaddingSmall(context),
          vertical: AppSizes.getSpacingSmall(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Removed all children to make the body empty as requested
          children: [
            // Place your Video Intro Section here
            const VideoIntroSection(),
            // Place your Text Intro Section here
            const TextIntroSection(),
         //   InstructorIntroSection(),
         //   FeaturedCoursesTableSection(),
            // Now, add the new Featured Courses Section with cards here
            const FeaturedCoursesSection(),
            InstructorIntroSection(),
            const SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}