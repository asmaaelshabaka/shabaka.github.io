// lib/data/repositories/course_repository.dart
import 'package:shabakahub2025/data/models/course_model.dart';

import '../providers/course_provider.dart'; // Import your CourseProvider

class CourseRepository {
  final CourseProvider _courseProvider; // Repository depends on the provider

  CourseRepository(this._courseProvider); // Constructor to inject the provider

  // Method to get all courses (delegates to provider)
  Future<List<CourseModel>> getAllCourses() async {
    try {
      return await _courseProvider.getAllCourses();
    } catch (e) {
      throw Exception(
        'Failed to fetch all courses from repository: ${e.toString()}',
      );
    }
  }

  // Method to get courses by category ID (delegates to provider)
  Future<List<CourseModel>> getCoursesByCategoryId(String categoryId) async {
    try {
      return await _courseProvider.getCoursesByCategoryId(categoryId);
    } catch (e) {
      throw Exception(
        'Failed to fetch courses for category $categoryId from repository: ${e.toString()}',
      );
    }
  }

  // <--- NEW METHOD: getCourseById --->

  Future<CourseModel?> getCourseById(String courseId) async {
    try {
      return await _courseProvider.getCourseById(courseId);
    } catch (e) {
      throw Exception(
        'Failed to fetch course with ID $courseId from repository: ${e.toString()}',
      );
    }
  }
}
