import 'package:flutter/material.dart';

class TwoDotIndicator extends StatelessWidget {
  final int currentIndex;

  const TwoDotIndicator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const double lineHeight = 4;
    const activeColor = Color(0xFF132018);
    const inactiveColor = Color(0xFF7CAC8E);

    const int totalPages = 3;

    final double firstLineWidth = currentIndex == 0 ? 160 : 50;
    final double secondLineWidth = currentIndex == 1 ? 160 : 50;
    final double thirdLineWidth = currentIndex == 2 ? 160 : 50;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(isActive: currentIndex == 0),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: firstLineWidth,
              height: lineHeight,
              color: currentIndex == 0 ? activeColor : inactiveColor,
            ),
            _buildDot(isActive: currentIndex == 0),
            const SizedBox(width: 16),
            _buildDot(isActive: currentIndex == 1),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: secondLineWidth,
              height: lineHeight,
              color: currentIndex == 1 ? activeColor : inactiveColor,
            ),
            _buildDot(isActive: currentIndex == 1),
            const SizedBox(width: 16),
            _buildDot(isActive: currentIndex == 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: thirdLineWidth,
              height: lineHeight,
              color: currentIndex == 2 ? activeColor : inactiveColor,
            ),
            _buildDot(isActive: currentIndex == 2),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "${currentIndex + 1} / $totalPages",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF132018),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    const activeColor = Color(0xFF132018);
    const inactiveColor = Color(0xFF7CAC8E);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
