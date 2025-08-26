// lib/routes/app_pages.dart
import 'package:flutter/material.dart'; // Added for Text widget in COURSE_DETAILS
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/modules/course_module/bindings/categories_binding.dart';
import 'package:shabakahub2025/presentation/modules/course_module/views/categories_view.dart';
import 'package:shabakahub2025/routes/app_binding.dart';
import 'package:shabakahub2025/routes/app_routes.dart';
import '../presentation/modules/about_us_module/views/about_us.dart';
import '../presentation/modules/auth_module/bindings/auth_binding.dart';
import '../presentation/modules/auth_module/views/login_view.dart';
import '../presentation/modules/auth_module/views/register_view.dart';
import '../presentation/modules/contact_us_module/contact_us.dart';
import '../presentation/modules/course_module/bindings/courses_binding.dart';
import '../presentation/modules/course_module/views/course_detail_view.dart';
import '../presentation/modules/course_module/views/courses_view.dart';
import '../presentation/modules/free_videos_module/bindings/free_videos_binding.dart';
import '../presentation/modules/free_videos_module/views/free_videos_category_view.dart';
import '../presentation/modules/free_videos_module/views/free_videos_view.dart';
import '../presentation/modules/home_module/bindings/home_binding.dart';
import '../presentation/modules/home_module/views/home_view.dart';
import '../presentation/modules/instructor_module/bindings/all_instructors_binding.dart';
import '../presentation/modules/instructor_module/views/all_instructors_view.dart';

class AppPages {
  // Set the initial route to the HOME screen as per your scenario
  static const INITIAL = Routes.HOME; // <--- App starts on Home screen

  static final routes = [
    // Auth Routes - No middleware needed if auth is removed from main
    GetPage(
      name: Routes.AUTH, // This is your Login page route
      page: () => const LoginView(),
      binding:
          AuthBinding(), // Keep binding, but its dependencies() should not put AuthController if auth is removed
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      // Removed: middlewares: [AuthGuardMiddleware()],
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding:
          AuthBinding(), // Keep binding, but its dependencies() should not put AuthController if auth is removed
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      // Removed: middlewares: [AuthGuardMiddleware()],
    ),

    // Home Route - No middleware needed if auth is removed from main
    GetPage(
      name: Routes.HOME, // This is your Home page route
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      // Removed: middlewares: [AuthGuardMiddleware()],
    ),

    // Course Routes - No middleware needed if auth is removed from main
    GetPage(
      name: Routes.COURSES, // Corrected to COURSES (all caps)
      page: () => const CoursesByCategoryView(),
      binding: CoursesBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      // Removed: middlewares: [AuthGuardMiddleware()],
    ),
    GetPage(
      name:
          Routes.COURSE_DETAILS, // Matches the route defined in app_routes.dart
      page: () => const CourseDetailView(), // The new view
      binding: CoursesBinding(), // The new binding
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => CategoriesView(), // Correct and valid
      binding: CategoriesBinding(),
      transition: Transition.rightToLeft, // Added a transition for consistency
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.ALL_INSTRUCTORS,
      page: () => const InstructorView(),
      binding: InstructorBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.FREE_VIDEOS_CATEGORIES,
      page: () => const FreeVideosCategoryView(),
      binding: FreeVideoBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.FREE_VIDEOS,
      page: () => const FreeVideosListView(),
      binding: FreeVideoBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: Routes.ABOUT_US, page: ()=> const AboutUsView()),
    GetPage(name: Routes.CONTACT_US, page: ()=> ContactUsView())
  ];
}

// Auth Guard Middleware is no longer needed if auth is removed from main
// Removed: class AuthGuardMiddleware extends GetMiddleware { ... }
