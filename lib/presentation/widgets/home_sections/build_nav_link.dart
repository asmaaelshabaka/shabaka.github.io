import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_sizes.dart';

class BuildNavLink extends StatelessWidget {
  final String title;
  final String? routeName;
  final VoidCallback? onTapCallback;

  // Constructor with title as positional parameter (matches your usage)
  const BuildNavLink(
      this.title, {
        super.key,
        this.routeName,
        this.onTapCallback,
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = MediaQuery.of(context).size.width < 768;
        final bool isMediumScreen = MediaQuery.of(context).size.width >= 768 &&
            MediaQuery.of(context).size.width < 1024;

        return GestureDetector(
          onTap: () {
            if (onTapCallback != null) {
              onTapCallback!();
            } else if (routeName != null) {
              Get.toNamed(routeName!);
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen
                    ? AppSizes.getPaddingSmall(context)
                    : AppSizes.getPaddingMedium(context),
                vertical: AppSizes.getPaddingSmall(context) / 2,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmallScreen
                      ? AppSizes.getFontSizeSmall(context)
                      : isMediumScreen
                      ? AppSizes.getFontSizeMedium(context) * 0.9
                      : AppSizes.getFontSizeMedium(context),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}