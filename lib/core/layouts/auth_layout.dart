import 'package:flutter/material.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/layouts/owner_tabs_layout.dart';
import 'package:beautygm/core/layouts/user_tabs_layout.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/admin/pages/admin_panel.dart';
import 'package:beautygm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:beautygm/features/onboarding/pages/onboarding_page.dart';
import 'package:beautygm/features/onboarding/pages/splash_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageInNotConnected});

  final Widget? pageInNotConnected;

  Future<Map<String, dynamic>> _getInitialData() async {
    final userType = getIt<CacheHelper>().get<String>(ApiKey.type);
    final isSeenOnboarding =
        getIt<CacheHelper>().get<bool>("SeenOnboarding") ?? false;
    return {
      'userType': userType,
      'isSeenOnboarding': isSeenOnboarding,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getInitialData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const SplashPage();
        }

        final userType = snapshot.data!['userType'];
        final isSeenOnboarding = snapshot.data!['isSeenOnboarding'] ?? false;

        // 1️⃣ Logged in? Go straight to their layout
        if (userType != null && userType is String && userType.isNotEmpty) {
          switch (userType) {
            case 'CO':
              return const OwnerTabsLayout();
            case 'U':
            case 'G': // guests should see the normal user UI
              return const UserTabsLayout();
            case 'A':
              return const AdminPanel();
            default:
              // unexpected type, fall back to login
              debugPrint('AuthLayout: unknown userType "$userType"');
              return pageInNotConnected ?? const SignInPage();
          }
        }

        // 2️⃣ Not logged in — has the user seen onboarding?
        if (!isSeenOnboarding) {
          return const OnboardingPage();
        }

        // 3️⃣ Seen onboarding but not logged in
        return pageInNotConnected ?? const SignInPage();
      },
    );
  }
}
