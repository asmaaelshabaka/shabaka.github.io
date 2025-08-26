// lib/modules/course_module/controllers/category_controller.dart
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/category_model.dart';
import 'package:shabakahub2025/data/repositories/category_repository.dart'; // <--- NEW: Import your CategoryRepository

class CategoryController extends GetxController {
  // The controller now depends on the CategoryRepository
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  List<CategoryModel> get categories => _categories.toList();

  final RxBool isLoading = true.obs; // Tracks if data is being loaded

  @override
  void onInit() {
    super.onInit();
    print('CategoryController initialized.'); // Debug print
    fetchCategories(); // Call method to fetch categories from the repository
  }

  // Method to fetch categories using the CategoryRepository
  Future<void> fetchCategories() async {
    isLoading.value = true; // Set loading to true at the start of fetch operation
    _categories.clear(); // Clear any existing categories before fetching new ones

    try {
      // Call the getAllCategories method from the repository
      final fetchedCategories = await _categoryRepository.getAllCategories();
      _categories.assignAll(fetchedCategories); // Assign the fetched categories to the observable list
      print('Fetched ${fetchedCategories.length} categories from repository.'); // Debug print

      // Provide user feedback if no categories are found
      if (fetchedCategories.isEmpty) {
        Get.snackbar(
          'No Categories Found',
          'There are no categories available in the database.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Get.theme.colorScheme.onSecondary,
        );
      }
    } catch (e) {
      // Handle any errors during the fetch operation
      print('Error fetching categories via repository: $e');
      Get.snackbar(
        'Error',
        'Failed to load categories: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false; // Set loading to false after operation completes (success or failure)
    }
  }
}
