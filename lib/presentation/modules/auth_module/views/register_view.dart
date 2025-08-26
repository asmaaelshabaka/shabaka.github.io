// lib/modules/auth_module/views/register_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/auth_request_model.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/routes/app_routes.dart';

import '../controllers/auth_controller.dart'; // For navigation to Login

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: AppColors.textColor),
        ),
        backgroundColor: AppColors.hubWhite,
        iconTheme: IconThemeData(color: AppColors.textColor),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppSizes.getMaxContentWidth(context),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    size: AppSizes.getIconSizeXLarge(context) * 2,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeXLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),
                  Text(
                    'Join Shabaka Hub and start your learning journey',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeMedium(context),
                      color: AppColors.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                      ),
                      filled: true,
                      fillColor: AppColors.hubWhite,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                      ),
                      filled: true,
                      fillColor: AppColors.hubWhite,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Password Field
                  Obx(() => TextFormField(
                    controller: passwordController,
                    obscureText: !controller.isLoading.value, // Simple toggle, or use a separate RxBool for visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Create a password',
                      prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isLoading.value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.greyText,
                        ),
                        onPressed: () {
                          // In a real scenario, you'd toggle a separate RxBool here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                      ),
                      filled: true,
                      fillColor: AppColors.hubWhite,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please create a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Confirm Password Field
                  Obx(() => TextFormField(
                    controller: confirmPasswordController,
                    obscureText: !controller.isLoading.value,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      prefixIcon: Icon(Icons.lock_reset, color: AppColors.primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isLoading.value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.greyText,
                        ),
                        onPressed: () {
                          // In a real scenario, you'd toggle a separate RxBool here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
                      ),
                      filled: true,
                      fillColor: AppColors.hubWhite,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Register Button
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        controller.register(
                          RegisterRequestModel(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.hubWhite,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.getPaddingMedium(context),
                        horizontal: AppSizes.getPaddingLarge(context),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusLarge(context)),
                      ),
                      minimumSize: Size(double.infinity, 0), // Full width
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: AppColors.hubWhite)
                        : Text(
                      'Register',
                      style: TextStyle(
                        fontSize: AppSizes.getFontSizeLarge(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: AppColors.textColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.AUTH); // Navigate back to Login screen
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
