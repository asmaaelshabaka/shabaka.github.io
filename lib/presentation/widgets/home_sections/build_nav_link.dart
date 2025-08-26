import 'package:flutter/material.dart';

import '../../../utils/app_sizes.dart';
import 'package:flutter/material.dart';

class buildNavLink extends StatelessWidget {
  final String title;
  final String? routeName;
  final VoidCallback? onTapCallback;

  const buildNavLink(String s, {super.key, required this.title, this.routeName, this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback!();
        } else if (routeName != null) {
          Navigator.of(context).pushNamed(routeName!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // Replace with your AppSizes
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
