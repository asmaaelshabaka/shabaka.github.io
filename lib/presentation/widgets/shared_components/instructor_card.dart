// lib/presentation/widgets/shared_components/instructor_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/instructor_model.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/presentation/widgets/shared_components/styled_container.dart'; // <--- THIS IMPORT IS NECESSARY

class InstructorCard extends StatelessWidget {
  final InstructorModel instructor;

  const InstructorCard({Key? key, required this.instructor}) : super(key: key);

  @override
  // In instructor_card.dart, update the build method:
  @override
  Widget build(BuildContext context) {
    final cardWidth = AppSizes.getInstructorCardWidth(context);
    final cardHeight = AppSizes.getInstructorCardHeight(context);

    return StyledContainer(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.only(right: AppSizes.getSpacingMedium(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Profile Image
          Container(
            width: cardWidth * 0.5,
            height: cardWidth * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: instructor.profilePictureUrl != null
                  ? Image.network(
                instructor.profilePictureUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.person,
                  size: cardWidth * 0.4,
                  color: AppColors.primaryColor,
                ),
              )
                  : Icon(
                Icons.person,
                size: cardWidth * 0.4,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          // Name and Bio
          Column(
            children: [
              Text(
                instructor.name,
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeMedium(context),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSizes.getSpacingExtraSmall(context)),
              Text(
                instructor.bio,
                style: TextStyle(
                  fontSize: AppSizes.getFontSizeSmall(context),
                  color: AppColors.greyText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // View Profile Button
          // SizedBox(
          //   width: cardWidth * 0.7,
          //   child: OutlinedButton(
          //     style: OutlinedButton.styleFrom(
          //       padding: EdgeInsets.symmetric(
          //         vertical: AppSizes.getSpacingExtraSmall(context),
          //       ),
          //       side: BorderSide(color: AppColors.primaryColor),
          //     ),
          //     onPressed: () => Get.toNamed('/instructor/${instructor.id}'),
          //     child: Text('View Profile'),
          //   ),
          // ),
        ],
      ),
    );
  }
}