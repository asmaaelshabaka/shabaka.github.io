// lib/routes/app_routes.dart
abstract class Routes {
  static const String AUTH = '/login';
  static const String REGISTER = '/register';
  static const String HOME = '/home'; // <--- CORRECTED: Changed from Home to HOME (all caps)
  static const String COURSES = '/courses'; // <--- CORRECTED: Changed from COURSE_LIST to COURSES (all caps)
  static const String COURSE_DETAILS = '/course_details/:courseId';
  static const String PROFILE = '/profile';
  static const String CATEGORY = '/category'; // Assuming this is correct from your usage
  static const String ALL_INSTRUCTORS = '/all_instructors'; // <--- NEW ROUTE for all instructors
  static const String FREE_VIDEOS_CATEGORIES = '/free_videos_categories'; // <--- NEW ROUTE for free videos categories
  static const String FREE_VIDEOS = '/free_videos/:categoryId'; // <--- NEW ROUTE for free videos by specific category
static const String ABOUT_US='/about_us';
static const String CONTACT_US='/contact_us';
}
