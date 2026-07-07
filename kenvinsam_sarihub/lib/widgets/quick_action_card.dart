import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Quick action card for the home tab horizontal list.
=======
import 'package:kenvinsam_sarihub/widgets/pressable_scale.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// A compact quick-action button with subtle gradient and press feedback.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceLg,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? color.withOpacity(0.15)
                : color.withOpacity(0.12),
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(icon, color: color, size: 22),
=======
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 88,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.10),
              color.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: color.withOpacity(0.18), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.75)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              label,
              style: AppTheme.caption.copyWith(
<<<<<<< HEAD
                color: context.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
=======
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
