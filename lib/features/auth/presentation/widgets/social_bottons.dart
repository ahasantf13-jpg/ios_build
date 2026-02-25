import 'package:flutter/material.dart';

class SocialBottons extends StatelessWidget {
  final void Function()? googleAuth;
  final void Function()? appleAuth;
  final void Function()? facebookAuth;

  const SocialBottons({
    super.key,
    required this.googleAuth,
    required this.appleAuth,
    required this.facebookAuth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          imageAsset: 'assets/images/icons/GoogleIcon.png',
          onTap: googleAuth,
        ),
        const SizedBox(width: 8),
        _buildSocialButton(
          imageAsset: 'assets/images/icons/AppleIcon.png',
          onTap: appleAuth,
        ),
        const SizedBox(width: 8),
        _buildSocialButton(
          imageAsset: 'assets/images/icons/FacebookIcon.png',
          onTap: facebookAuth,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String imageAsset,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDBDDDF), width: 1),
        ),
        child: Image.asset(imageAsset, width: 24),
      ),
    );
  }
}
