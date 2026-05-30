import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/admin')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = _selectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index) {
            if (index == 0) {
              context.go('/');
            } else {
              context.go('/admin');
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_car_outlined,
                color: selected == 0
                    ? AppColors.govNavy
                    : AppColors.textMuted,
              ),
              activeIcon: const Icon(Icons.directions_car, color: AppColors.govNavy),
              label: l10n.navVerification,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected == 1
                        ? AppColors.primaryOrange
                        : AppColors.border,
                  ),
                ),
                child: Icon(
                  Icons.shield_outlined,
                  size: 20,
                  color: selected == 1
                      ? AppColors.primaryOrange
                      : AppColors.textMuted,
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryOrange.withValues(alpha: 0.15),
                  border: Border.all(color: AppColors.primaryOrange),
                ),
                child: const Icon(
                  Icons.shield,
                  size: 20,
                  color: AppColors.primaryOrange,
                ),
              ),
              label: l10n.navAdmin,
            ),
          ],
        ),
      ),
    );
  }
}
