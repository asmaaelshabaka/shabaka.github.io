// lib/modules/course_module/bindings/courses_binding.dart
import 'package:get/get.dart';
import 'package:shabakahub2025/data/repositories/lesson_repository.dart'; // Keep import
import '../../../../data/providers/course_provider.dart'; // Keep import
import '../../../../data/providers/lessons_provider.dart'; // Keep import
import '../controllers/course_controller.dart'; // Keep import
import 'package:shabakahub2025/data/repositories/course_repository.dart'; // Keep import
import '../controllers/course_detail_controller.dart'; // Keep import

class CoursesBinding extends Bindings {
  @override
  void dependencies() {

   Get.lazyPut<CourseDetailController>(() => CourseDetailController());
    Get.lazyPut<CourseController>(() => CourseController());
  }
}
