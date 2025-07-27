import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarWidget extends StatelessWidget {
  final String currentPage;

  const NavigationBarWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      color: const Color(0xFFF3F3F3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              label: 'Today',
              iconPath: 'assets/icons/today_nav_icon.svg',
              isActive: currentPage == 'Today',
              onPressed: () {
                if (currentPage != 'Today') {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
            ),
            _buildNavItem(
              label: 'Log',
              iconPath: 'assets/icons/log_nav_icon.svg',
              isActive: currentPage == 'Log',
              onPressed: () {},
            ),
            const SizedBox(width: 56),
            _buildNavItem(
              label: 'More',
              iconPath: 'assets/icons/more_nav_icon.svg',
              isActive: currentPage == 'More',
              onPressed: () {},
            ),
            _buildNavItem(
              label: 'Profile',
              iconPath: 'assets/icons/profile_nav_icon.svg',
              isActive: currentPage == 'Profile',
              onPressed: () {
                if (currentPage != 'Profile') {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String label,
    required String iconPath,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 4),
            Column(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 24,
                    height: 2,
                    color: Colors.black87,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
