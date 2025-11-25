import 'package:flutter/material.dart';

import '../resources/colors/app_colors.dart';
class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }
}