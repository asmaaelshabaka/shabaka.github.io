// lib/presentation/widgets/shared_components/styled_container.dart

import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_sizes.dart'; // For consistent sizes

class StyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final double? height; // Added height for flexibility
  final double? width;  // Added width for flexibility

  const StyledContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default values if not provided
    final defaultBorderRadius = AppSizes.getBorderRadiusMedium(context);
    final defaultBoxShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ];

    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor, // Default to cardColor
        borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
        boxShadow: boxShadow ?? defaultBoxShadow,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSizes.getPaddingMedium(context)), // Default padding
        child: child,
      ),
    );
  }
}