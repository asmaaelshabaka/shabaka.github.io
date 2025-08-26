// lib/utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors from the Logo
  static const Color primaryOrange = Color(0xFFF78B1F); // This is the orange from your logo. I've used an approximate hex value. You may need to use a color picker to get the exact one.
  static const Color hubBlack = Colors.black; // The background color of the logo.
  static const Color hubWhite = Colors.white; // The color of the text in the logo.

  // New Primary & Accent based on the logo
  static const Color primaryColor = primaryOrange;
  static const Color accentColor = hubWhite; // Use white as an accent or secondary color.

  // Text Colors
  static const Color textColor = hubBlack; // Black for primary text.
  static const Color greyText = Color(0xFF757575);
  static const Color greyLight = Color(0xFFE0E0E0);

  // Background Colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkBackground = hubBlack; // Use black for dark mode or specific sections.

  // Status/Utility Colors
  static const Color successColor = Color(0xFF4CAF50); // Keep for "Completed" status.
  static const Color errorColor = Color(0xFFF44336); // Use a standard red for errors.
  static const Color borderColor = greyLight; // Use a light grey for borders.
}