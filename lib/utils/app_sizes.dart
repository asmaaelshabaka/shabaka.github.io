import 'package:flutter/material.dart';

class AppSizes {
  // Private constructor to prevent instantiation
  AppSizes._();

  // Base sizing unit (similar to 'rem' in CSS)
  static double getBaseUnit(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // For web, we scale up to a point, then cap at reasonable sizes
    return (width * 0.01).clamp(8.0, 16.0); // 1% of width, but min 8, max 16
  }

  // --- General Spacing and Padding ---
  static double getPaddingSmall(BuildContext context) => getBaseUnit(context) * 1;
  static double getPaddingMedium(BuildContext context) => getBaseUnit(context) * 2;
  static double getPaddingLarge(BuildContext context) => getBaseUnit(context) * 3;
  static double getPaddingXLarge(BuildContext context) => getBaseUnit(context) * 4;

  // For vertical spacing, use a similar approach but consider height too
  static double getSpacingExtraSmall(BuildContext context) => getBaseUnit(context) * 0.5; // NEW/UPDATED
  static double getSpacingSmall(BuildContext context) => getBaseUnit(context) * 1;
  static double getSpacingMedium(BuildContext context) => getBaseUnit(context) * 2;
  static double getSpacingLarge(BuildContext context) => getBaseUnit(context) * 3;
  static double getSpacingXLarge(BuildContext context) => getBaseUnit(context) * 4;


  // --- Icon Sizes ---
  static double getIconSizeSmall(BuildContext context) => getBaseUnit(context) * 1.5;
  static double getIconSizeMedium(BuildContext context) => getBaseUnit(context) * 2;
  static double getIconSizeLarge(BuildContext context) => getBaseUnit(context) * 3;
  static double getIconSizeXLarge(BuildContext context)=>getBaseUnit(context)*5;

  // --- Font Sizes ---
  static double getFontSizeSmall(BuildContext context) => getBaseUnit(context) * 0.875; // ~14px at base 16
  static double getFontSizeMedium(BuildContext context) => getBaseUnit(context) * 1; // Base size
  static double getFontSizeLarge(BuildContext context) => getBaseUnit(context) * 1.25; // ~20px at base 16
  static double getFontSizeXLarge(BuildContext context) => getBaseUnit(context) * 1.5; // ~24px at base 16
  static double getFontSizeSuperLarge(BuildContext context) => getBaseUnit(context) * 2; // ~32px at base 16

  // --- Border Radius ---
  static double getBorderRadiusSmall(BuildContext context) => getBaseUnit(context) * 0.5;
  static double getBorderRadiusMedium(BuildContext context) => getBaseUnit(context) * 1;
  static double getBorderRadiusLarge(BuildContext context) => getBaseUnit(context) * 1.5;

  // --- Component Specific Sizes ---
  static double getDrawerHeaderHeight(BuildContext context) => getBaseUnit(context) * 12;
  static double getCourseImageHeight(BuildContext context) => getBaseUnit(context) * 8;


  // --- Button Sizes ---
  static double getButtonHeightSmall(BuildContext context) => getBaseUnit(context) * 2.5;
  static double getButtonHeightMedium(BuildContext context) => getBaseUnit(context) * 3;
  static double getButtonHeightLarge(BuildContext context) => getBaseUnit(context) * 3.5;
  static double getButtonHeightXLarge(BuildContext context) => getBaseUnit(context) * 4;

// --- Button Widths ---
  static double getButtonWidthSmall(BuildContext context) => getBaseUnit(context) * 6;
  static double getButtonWidthMedium(BuildContext context) => getBaseUnit(context) * 8;
  static double getButtonWidthLarge(BuildContext context) => getBaseUnit(context) * 10;
  static double getButtonWidthXLarge(BuildContext context) => getBaseUnit(context) * 12;

// --- Button Padding ---
  static double getButtonPaddingSmall(BuildContext context) => getBaseUnit(context) * 0.75;
  static double getButtonPaddingMedium(BuildContext context) => getBaseUnit(context) * 1;
  static double getButtonPaddingLarge(BuildContext context) => getBaseUnit(context) * 1.25;

  // --- AppBar Height ---
  static double getAppBarHeight(BuildContext context) => getBaseUnit(context) * 6;


  // --- Max Content Width (common web pattern) ---
  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 1200 ? 1200 : width * 0.9;
  }
  static double getVideoSectionHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return getBaseUnit(context) * 20; // Example multiplier for small screens
    } else if (screenHeight < 900) {
      return getBaseUnit(context) * 25; // Example multiplier for medium screens
    } else {
      return getBaseUnit(context) * 30; // Example multiplier for large screens
    }
  }

  // Instructor Card Specific Sizes (Crucial for InstructorIntroSection)
  static double getInstructorCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Adjust multipliers to show more cards on screen
    if (width < 600) { // Mobile - show ~2.5 cards
      return width * 0.36; // ~36% of screen width
    } else if (width < 1000) { // Tablet - show ~3.5 cards
      return width * 0.28; // ~28% of screen width
    } else { // Desktop - show ~5 cards
      return width * 0.18; // ~18% of screen width
    }
  }

  static double getInstructorCardHeight(BuildContext context) {
    return getInstructorCardWidth(context) * 1.4; // Maintain aspect ratio
  }
  // Category Card Specific Sizes (NEW)

  static double getCategoryCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) { // Mobile
      return width * 0.45; // Shows 2 cards with spacing
    } else if (width < 1000) { // Tablet
      return width * 0.3; // Shows 3 cards
    } else { // Desktop
      return width * 0.2; // Shows 5 cards
    }
  }

  static double getCategoryCardHeight(BuildContext context) {
    return getCategoryCardWidth(context) * 1.2; // Slightly wider than tall
  }
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 2; // 2 columns for small screens (mobile)
    } else if (width < 900) {
      return 3; // 3 columns for medium screens (tablet)
    } else {
      return 4; // 4 columns for large screens (desktop)
    }
  }




}
