import 'package:get/get.dart';

// Auth
import 'package:shabakahub2025/presentation/modules/auth_module/controllers/auth_controller.dart';

// Providers
import 'package:shabakahub2025/data/providers/category_provider.dart';
import 'package:shabakahub2025/data/providers/course_provider.dart';
import 'package:shabakahub2025/data/providers/lessons_provider.dart';
import 'package:shabakahub2025/data/providers/instructor_provider.dart';
import 'package:shabakahub2025/data/providers/free_videos_provider.dart';
import 'package:shabakahub2025/data/providers/home_provider.dart';

// Repositories
import 'package:shabakahub2025/data/repositories/category_repository.dart';
import 'package:shabakahub2025/data/repositories/course_repository.dart';
import 'package:shabakahub2025/data/repositories/lesson_repository.dart';
import 'package:shabakahub2025/data/repositories/instructor_repository.dart';
import 'package:shabakahub2025/data/repositories/free_videos_repository.dart';
import 'package:shabakahub2025/data/repositories/home_repository.dart';


// Controllers
import 'package:shabakahub2025/presentation/modules/course_module/controllers/course_controller.dart';
import 'package:shabakahub2025/presentation/modules/home_module/controllers/intro_video_controller.dart';
import 'package:shabakahub2025/presentation/modules/instructor_module/controllers/all_instructors_controller.dart';
import 'package:shabakahub2025/presentation/modules/course_module/controllers/category_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../presentation/modules/free_videos_module/controllers/free_videos_controller.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    // ===== 1. Initialize Providers First =====
    Get.put<CategoryProvider>(CategoryProvider());
    Get.put<CourseProvider>(CourseProvider());
    Get.put<FreeVideoProvider>(FreeVideoProvider());
    Get.put<LessonProvider>(LessonProvider());
    Get.put<InstructorProvider>(InstructorProvider());
    Get.put<HomeProvider>(HomeProvider()); // Moved here for proper ordering

    // ===== 2. Initialize Repositories (with Provider Dependencies) =====
    Get.put<CategoryRepository>(
      CategoryRepository(Get.find<CategoryProvider>()),
    );
    Get.put<CourseRepository>(
      CourseRepository(Get.find<CourseProvider>()),
    );
    Get.put<FreeVideoRepository>(
      FreeVideoRepository(Get.find<FreeVideoProvider>()),
    );
    Get.put<LessonRepository>(
      LessonRepository(Get.find<LessonProvider>()),
    );
    Get.put<InstructorRepository>(
      InstructorRepository(),
    );
    Get.put<HomeRepository>(
      HomeRepository(Get.find<HomeProvider>()), // Moved here for proper ordering
    );

    // ===== 3. Initialize Controllers (with Repository Dependencies) =====
    // Auth Controller (Permanent)
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );

    // Course Controller
    Get.put<CourseController>(
      // You should inject its repository here, for example:
      // CourseController(courseRepository: Get.find<CourseRepository>()),
      CourseController(),
    );

    // Other Controllers (Lazy-loaded)
    // The import is for 'all_instructors_controller.dart', so we'll use that name here.
    Get.lazyPut<InstructorController>(
          () => InstructorController(),
    );

    Get.lazyPut<CategoryController>(
          () => CategoryController(),
    );

    Get.lazyPut<FreeVideosListController>(
          () => FreeVideosListController(),
    );

    Get.put<IntroVideoController>(
      IntroVideoController(Get.find<HomeRepository>()),
    );
    // Initialize YouTube controller once for the whole app


  }

}
