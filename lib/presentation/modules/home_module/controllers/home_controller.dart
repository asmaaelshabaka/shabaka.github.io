import 'package:get/get.dart';
import 'package:shabakahub2025/routes/app_routes.dart'; // Ensure this path is correct

// Import your CourseModel
import '../../../../data/models/course_model.dart'; // Ensure this path is correct

class HomeController extends GetxController {
  final welcomeMessage = 'Welcome to ShabakaHub!'.obs;

  final isLoading = false.obs;

  final popularCourses = <CourseModel>[].obs; // Correct type as discussed

  @override
  void onInit() {
    super.onInit(); // Don't forget to call super.onInit()
    fetchWelcomeMessage();
   // fetchPopularCourses();
  }

  void navigateToCourseList() {
    // This currently navigates to LOGIN.
    // When you have a 'course_list' route, you'd change this to Routes.COURSE_LIST
    Get.toNamed(Routes.AUTH);
  }

  void fetchWelcomeMessage() {
    Future.delayed(const Duration(seconds: 1), () {
      welcomeMessage.value = 'Hello, User! Discover great courses.';
    });
  }

  // void fetchPopularCourses() async {
  //   isLoading.value = true; // Set loading to true when starting fetch
  //   try {
  //     await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
  //
  //
  //
  //
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load courses: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}