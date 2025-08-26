// lib/modules/course_module/bindings/categories_binding.dart
import 'package:get/get.dart';
import '../../../../data/providers/category_provider.dart'; // Keep import
import '../controllers/category_controller.dart'; // Keep import
import 'package:shabakahub2025/data/repositories/category_repository.dart'; // Keep import

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    // CategoryProvider and CategoryRepository are now registered globally in AppBinding.
    // No need to register them again here.
    // Get.put<CategoryProvider>(CategoryProvider());
    // Get.put<CategoryRepository>(CategoryRepository(Get.find<CategoryProvider>()));

    // Register the CategoryController, which is specific to this module.
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
