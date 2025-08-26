import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shabakahub2025/presentation/modules/auth_module/controllers/auth_controller.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:get/get.dart';

import '../../../../data/models/auth_request_model.dart';
import '../../../../routes/app_routes.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
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
                    Icons.school,
                    size: AppSizes.getIconSizeXLarge(context) * 2,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeXLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),
                  Text(
                    'Sign in to continue to Shabaka Hub',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeMedium(context),
                      color: AppColors.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.getBorderRadiusMedium(context),
                        ),
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
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText: !controller.isLoading.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primaryColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            controller.isLoading.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greyText,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.getBorderRadiusMedium(context),
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.hubWhite,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),

                  ///Forget Password
                  ///
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Forgot Password',
                          'Feature coming soon!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.hubWhite,
                          colorText: AppColors.hubWhite,
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),

                  // Login Button
                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  controller.login(
                                    LoginRequestModel(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                      child:
                          controller.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: AppSizes.getFontSizeLarge(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.hubWhite,
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.getPaddingMedium(context),
                          horizontal: AppSizes.getPaddingLarge(context),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.getBorderRadiusLarge(context),
                          ),
                        ),
                        minimumSize: Size(double.infinity, 0), // Full width
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingLarge(context)),

                  // Don't have an account? Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(color: AppColors.textColor),
                      ),
                      TextButton(
                        onPressed: () {Get.toNamed(Routes.REGISTER);},
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
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
