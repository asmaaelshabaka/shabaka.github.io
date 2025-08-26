// lib/presentation/modules/instructor_module/bindings/instructor_binding.dart
import 'package:get/get.dart';
import '../controllers/all_instructors_controller.dart'; // Keep the import

class InstructorBinding extends Bindings {
  @override
  void dependencies() {
    // InstructorController is now registered globally in AppBinding.
    // No need to register it again here.
     Get.lazyPut<InstructorController>(() => InstructorController());
  }
}
