import 'package:chronicle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Text('Chronicle',style: Theme.of(context).textTheme.headlineLarge,),
      ),
    );
  }
}
