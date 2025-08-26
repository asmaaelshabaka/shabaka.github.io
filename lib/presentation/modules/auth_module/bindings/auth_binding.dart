// lib/modules/auth_module/bindings/auth_binding.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart'; // Keep import

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController is registered globally and permanently in AppBinding.
    // No need to register it again here.
    // Get.put<AuthController>(AuthController(), permanent: true);
  }
}
