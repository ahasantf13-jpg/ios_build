import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautygm/core/constants/app_text_styles.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:beautygm/features/profile/presentation/pages/my_profile_tab.dart';
import 'package:beautygm/features/user/presentation/pages/user_favorites_tab.dart';
import 'package:beautygm/features/user/presentation/pages/user_home_tab.dart';
import 'package:beautygm/features/user/presentation/pages/user_offers_tab.dart';

class UserTabsLayout extends StatefulWidget {
  const UserTabsLayout({super.key});

  @override
  State<UserTabsLayout> createState() => _UserTabsLayoutState();
}

class _UserTabsLayoutState extends State<UserTabsLayout> {
  int _selectedIndex = 0;

  late final List<Widget> _screens = const [
    UserHomeTab(),
    UserOffersTab(),
    UserFavoritesTab(),
    MyProfileTab(),
  ];

  bool get _isGuest {
    final userType = getIt<CacheHelper>().get<String>(ApiKey.type);
    return userType == 'G';
  }

  void _onItemTapped(int index) {
    // Block guests from accessing the Profile tab (index 3)
    if (index == 3 && _isGuest) {
      _showGuestDialog();
      return;
    }
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
    }
  }

  void _showGuestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text(
          "Create an Account",
          style: AppTextStyles.paragraph01Regular,
        ),
        content: Text(
          "You need to register first to access your profile.",
          style: AppTextStyles.paragraph02Regular.copyWith(
            color: const Color(0xFF393E46),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Not Now",
              style: AppTextStyles.paragraph02SemiBold.copyWith(
                color: const Color(0xFF78808B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await getIt<CacheHelper>().clear();

              if (context.mounted) {
                Navigator.pop(context);
              }

              if (context.mounted) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                );
              }
            },
            child: const Text("Sign In / Register"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7CAC8E),
        unselectedItemColor: const Color(0xFF78808B),
        iconSize: 25.w,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyles.footerSemiBold,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? Icons.discount : Icons.discount_outlined,
            ),
            label: "Offers",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.favorite : Icons.favorite_outline,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.person : Icons.person_outline,
            ),
            label: "My Profile",
          ),
        ],
      ),
    );
  }
}
