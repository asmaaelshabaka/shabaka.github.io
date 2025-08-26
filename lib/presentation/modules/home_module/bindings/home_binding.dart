// lib/presentation/modules/home_module/bindings/home_binding.dart
import 'package:get/get.dart';

// Import only controllers specific to the Home Module view,
// or controllers that are globally registered in AppBinding and used here.
import '../controllers/home_controller.dart';
// Remove imports for providers/repositories as they are globally put in AppBinding
// Remove imports for controllers that are now globally put/lazyPut in AppBinding,
// unless this binding needs to specifically lazyPut them for its own lifecycle.
// For simplicity, assuming HomeController is the primary controller for HomeView.

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register HomeController, as it's specific to the Home Module.
    Get.lazyPut<HomeController>(() => HomeController());

    // All other global providers, repositories, and widely-used controllers
    // (like InstructorController, CategoryController, CourseController, FreeVideoController)
    // are now registered in AppBinding.
    // Do NOT register them again here to avoid conflicts.
  }
}
