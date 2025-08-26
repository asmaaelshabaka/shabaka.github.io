import 'package:flutter/material.dart';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final bool filled;
  final double borderRadius;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Color iconColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconData,
    this.suffixIconData,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.autoFocus = false,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.borderColor = AppColors.greyLight,
    this.focusedBorderColor = AppColors.primaryColor,
    this.errorBorderColor = AppColors.errorColor,
    this.fillColor = Colors.white,
    this.filled = true,
    this.borderRadius = 8.0,
    this.iconColor = AppColors.greyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      focusNode: focusNode,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon ?? (prefixIconData != null
            ? Icon(prefixIconData, color: iconColor)
            : null),
        suffixIcon: suffixIcon ?? (suffixIconData != null
            ? Icon(suffixIconData, color: iconColor)
            : null),
        filled: filled,
        fillColor: fillColor,
        contentPadding: EdgeInsets.all(AppSizes.getPaddingMedium(context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: errorBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: errorBorderColor, width: 2.0),
        ),
        labelStyle: TextStyle(
          color: AppColors.greyText,
          fontSize: AppSizes.getFontSizeMedium(context),
        ),
        hintStyle: TextStyle(
          color: AppColors.greyLight,
          fontSize: AppSizes.getFontSizeSmall(context),
        ),
        errorStyle: TextStyle(
          color: AppColors.errorColor,
          fontSize: AppSizes.getFontSizeSmall(context),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      style: TextStyle(
        color: enabled ? AppColors.textColor : AppColors.greyText,
        fontSize: AppSizes.getFontSizeMedium(context),
      ),
    );
  }
}

// Optional: Pre-styled text fields for common use cases
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailTextField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Email Address',
      keyboardType: TextInputType.emailAddress,
      prefixIconData: Icons.email_outlined,
      validator: validator ?? _defaultValidator,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.obscureText = true,
    this.onToggleVisibility,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Password',
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      prefixIconData: Icons.lock_outlined,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.greyText,
        ),
        onPressed: onToggleVisibility,
      ),
      validator: validator ?? _defaultValidator,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}