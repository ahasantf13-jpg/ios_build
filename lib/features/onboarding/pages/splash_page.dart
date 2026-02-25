import 'dart:async';
import 'package:beautygm/core/constants/app_assets.dart';
import 'package:beautygm/core/constants/app_colors.dart';
import 'package:beautygm/core/constants/app_text_styles.dart';
import 'package:beautygm/core/layouts/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthLayout()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary08,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.logo, width: 150, height: 150),
            SizedBox(height: 20.h),
            Text(
              "BeautyGM",
              style: AppTextStyles.heading01SemiBold.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              "The Preview Room",
              style: AppTextStyles.paragraph01Regular.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            const CircularProgressIndicator(color: AppColors.secondary04),
          ],
        ),
      ),
    );
  }
}
