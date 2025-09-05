// lib/modules/course_module/controllers/course_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/course_model.dart';
import 'package:shabakahub2025/data/models/lesson_model.dart';
import 'package:shabakahub2025/data/repositories/course_repository.dart';
import 'package:shabakahub2025/data/repositories/lesson_repository.dart';
import 'package:video_player/video_player.dart';

class CourseController extends GetxController {
  final CourseRepository _courseRepository = Get.find<CourseRepository>();

  // Use a single list for the courses displayed on the screen
  final RxList<CourseModel> _courses = <CourseModel>[].obs;
  List<CourseModel> get courses => _courses.toList();
  final RxList<CourseModel> _coursesbycat = <CourseModel>[].obs;
  List<CourseModel> get coursesbycat => _coursesbycat.toList();

  final RxBool isLoading = true.obs;

  String? categoryId;
  String? categoryName;

  // We will no longer rely on onInit to fetch the category courses
  // The onInit will now only be responsible for fetching popular courses
  @override
  void onInit() {
    super.onInit();
    // This is a good place to fetch popular courses for the home screen
    fetchPopularCourses();
  }

  // New method to load courses based on the provided category.
  // This method should be called from the Courses view/screen.
  Future<void> loadCoursesForCategory({
    required String id,
    required String name,
  }) async {
    categoryId = id;
    categoryName = name;
    print(
      'CourseController is loading courses for Category: ${categoryName} (ID: ${categoryId})',
    );
    await fetchCoursesByCategoryId(id);
  }

  Future<void> fetchPopularCourses() async {
    isLoading.value = true;
    _courses.clear();
    try {
      final fetchedCourses = await _courseRepository.getAllCourses();
      _courses.assignAll(fetchedCourses);
      print('Fetched ${fetchedCourses.length} popular courses.');

      if (fetchedCourses.isEmpty) {
        Get.snackbar(
          'No Popular Courses Found',
          'There are no popular courses available in the database.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Get.theme.colorScheme.onSecondary,
        );
      }
    } catch (e) {
      print('Error fetching popular courses: $e');
      Get.snackbar(
        'Error',
        'Failed to load popular courses: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCoursesByCategoryId(String id) async {
    isLoading.value = true;
    _coursesbycat.clear();
    try {
      final fetchedCourses = await _courseRepository.getCoursesByCategoryId(id);
      _coursesbycat.assignAll(fetchedCourses);
      print('Fetched ${fetchedCourses.length} courses for category $id.');
      if (fetchedCourses.isEmpty) {
        Get.snackbar(
          'No Courses Found',
          'There are no courses available for this category.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Get.theme.colorScheme.onSecondary,
        );
      }
    } catch (e) {
      print('Error fetching courses by category ID $id: $e');
      Get.snackbar(
        'Error',
        'Failed to load courses: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }
  /// Helper methods
  int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 1;   // phones
    if (width < 900) return 2;   // tablets
    if (width < 1200) return 3;  // small desktop
    return 4;                    // large screens
  }

  double getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 0.9;   // taller cards on mobile
    if (width < 900) return 0.85;
    if (width < 1200) return 0.8;
    return 0.75;                   // slightly wider on desktop
  }
}
