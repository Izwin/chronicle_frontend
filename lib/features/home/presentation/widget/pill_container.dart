import 'package:chronicle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PillContainer extends StatelessWidget {
  final String text;
  const PillContainer({this.text = '',super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.textColor,
      ),
      child: Text(text,style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.background,
      ),),
    );
  }
}
