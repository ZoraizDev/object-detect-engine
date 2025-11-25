import 'package:flutter/material.dart';

import '../resources/colors/app_colors.dart';


class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final int? maxLines;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final VoidCallback? onToggle;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;

  const AuthTextField({
    super.key,
    required this.controller,
    this.labelStyle,
    this.label,
    this.hintText,
    this.maxLines = 1,
    this.onChanged,
    this.icon,
    this.obscureText = false,
    this.onToggle,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: const TextStyle(),
        prefixIcon: icon != null
            ? Icon(icon,)
            : null,

        contentPadding: icon != null
            ? const EdgeInsets.symmetric(horizontal: 0, vertical: 16)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        suffixIcon: onToggle != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.textFormFieldTextColor,
                ),
                onPressed: onToggle,
              )
            : null,

        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}