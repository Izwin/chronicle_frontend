import 'package:chronicle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? hintText;
  final Widget? actionIcon;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const DefaultTextField(
      {super.key,
      this.hintText,
      this.actionIcon,
      this.borderRadius,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        fillColor: AppColors.surface,
        filled: true,
        counterStyle: Theme.of(context).textTheme.bodySmall,
        hintText: hintText,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: actionIcon,
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textColor.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(40)
        )
      ),
    );
  }
}
