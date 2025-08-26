import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

import '../../widgets/custom_controls/custom_button.dart';
import '../../widgets/custom_controls/custom_text_field.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        titleText: 'Contact Us',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.getPaddingLarge(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.contact_support_outlined,
                    size: AppSizes.getIconSizeXLarge(context),
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeXLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingSmall(context)),
                  Text(
                    'We\'d love to hear from you! Send us a message and we\'ll respond as soon as possible.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeMedium(context),
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.getSpacingXLarge(context)),

            // Contact Form
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.getPaddingLarge(context)),
                child: Column(
                  children: [
                    // Name Field
                    CustomTextField(
                      controller: nameController,
                      labelText: 'Full Name',
                      prefixIconData: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Email Field
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email Address',
                      prefixIconData: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Subject Field
                    CustomTextField(
                      controller: subjectController,
                      labelText: 'Subject',
                      prefixIconData: Icons.ac_unit_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Message Field
                    CustomTextField(
                      controller: messageController,
                      labelText: 'Message',
                      prefixIconData: Icons.message_outlined,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        if (value.length < 10) {
                          return 'Message should be at least 10 characters';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSizes.getSpacingLarge(context)),

                    // Submit Button
                    CustomButton(
                      onPressed: () {
                        // Handle form submission
                        Get.snackbar(
                          'Message Sent',
                          'Thank you for contacting us! We\'ll get back to you soon.',
                          backgroundColor: AppColors.successColor,
                          colorText: Colors.white,
                        );
                      },
                      text: 'Send Message',
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.getSpacingXLarge(context)),

            // Contact Information
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.getBorderRadiusMedium(context)),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.getPaddingLarge(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: AppSizes.getFontSizeLarge(context),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Email
                    _buildContactItem(
                      icon: Icons.email,
                      title: 'Email',
                      value: 'support@shabakahub.com',
                      context: context,
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Phone
                    _buildContactItem(
                      icon: Icons.phone,
                      title: 'Phone',
                      value: '+1 (555) 123-4567',
                      context: context,
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Address
                    _buildContactItem(
                      icon: Icons.location_on,
                      title: 'Address',
                      value: '123 Education Street\nKnowledge City, KC 12345',
                      context: context,
                    ),

                    SizedBox(height: AppSizes.getSpacingMedium(context)),

                    // Hours
                    _buildContactItem(
                      icon: Icons.access_time,
                      title: 'Working Hours',
                      value: 'Mon - Fri: 9:00 AM - 6:00 PM\nSat: 10:00 AM - 4:00 PM',
                      context: context,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.getSpacingXLarge(context)),

            // Social Media
            Center(
              child: Column(
                children: [
                  Text(
                    'Follow Us',
                    style: TextStyle(
                      fontSize: AppSizes.getFontSizeLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.getSpacingMedium(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook, context),
                      SizedBox(width: AppSizes.getSpacingMedium(context)),
                      _buildSocialIcon(Icons.yard_outlined, context),
                      SizedBox(width: AppSizes.getSpacingMedium(context)),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: AppSizes.getIconSizeMedium(context),
        ),
        SizedBox(width: AppSizes.getSpacingMedium(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.getFontSizeSmall(context),
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: AppSizes.getSpacingExtraSmall(context)),
              Text(
                value,
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeSmall(context),
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      radius: AppSizes.getIconSizeMedium(context) / 1.5,
      child: Icon(
        icon,
        color: Colors.white,
        size: AppSizes.getIconSizeSmall(context),
      ),
    );
  }
}