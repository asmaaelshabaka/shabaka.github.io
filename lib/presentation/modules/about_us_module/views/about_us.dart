import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const CustomAppBar(
        titleText: 'About Us',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.getPaddingLarge(context),
            vertical: AppSizes.getPaddingLarge(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie animation to replace the static icon
              Lottie.asset(
                'assets/images/Certificate.json',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
                repeat: true, // Set to true for a continuous loop
              ),
              const SizedBox(height: 24),
              const Text(
                'We Help You Showcase Your Work',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.greyText,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Share your recorded work videos on YouTube and our platform. '
                          'Showcase your projects, demonstrate your skills, and connect with opportunities.',
                    ),
                    TextSpan(
                      text: 'Shabaka Hub',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildHowItWorksSection(context),
              const SizedBox(height: 32),
              _buildCallToAction(context),
              const SizedBox(height: 48),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHowItWorksSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How it works:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildHowItWorksStep(1, 'Record your work videos'),
          _buildHowItWorksStep(2, 'Upload to YouTube'),
          _buildHowItWorksStep(3, 'Share on Shabaka Hub'),
          _buildHowItWorksStep(4, 'Get discovered by employers'),
        ],
      ),
    );
  }

  Widget _buildHowItWorksStep(int step, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 12,
            child: Text(
              '$step',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.greyText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add navigation logic here, e.g., to a sign-up page
          // Navigator.of(context).pushNamed('/signup');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Join Now and Showcase Your Work',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Text(
      '© 2025 Shabaka Hub. All rights reserved.',
      style: TextStyle(
        fontSize: 12,
        color: AppColors.greyText,
      ),
      textAlign: TextAlign.center,
    );
  }
}
