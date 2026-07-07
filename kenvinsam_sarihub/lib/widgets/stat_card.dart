import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Stat card used in admin dashboard and overview sections.
=======
import 'package:kenvinsam_sarihub/widgets/pressable_scale.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// A premium statistic card with icon, value, label, and optional trend.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
<<<<<<< HEAD
  final String? subtitle;
=======
  final String? trend;
  final bool trendPositive;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
<<<<<<< HEAD
    this.subtitle,
=======
    this.trend,
    this.trendPositive = true,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? color.withOpacity(0.15)
                : color.withOpacity(0.1),
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
=======
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PressableScale(
      onTap: onTap,
      scaleAmount: 0.97,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: !isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
<<<<<<< HEAD
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: context.textMuted,
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceLg),
=======
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.18),
                        color.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                if (trend != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: (trendPositive ? AppTheme.success : AppTheme.error)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          trendPositive
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          size: 10,
                          color: trendPositive
                              ? AppTheme.success
                              : AppTheme.error,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          trend!,
                          style: AppTheme.caption.copyWith(
                            color: trendPositive
                                ? AppTheme.success
                                : AppTheme.error,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceMd),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            Text(
              value,
              style: AppTheme.headingLg.copyWith(
                color: context.textPrimary,
<<<<<<< HEAD
                fontSize: 24,
              ),
=======
                fontSize: 22,
                letterSpacing: -0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
            const SizedBox(height: 2),
            Text(
              title,
<<<<<<< HEAD
              style: AppTheme.bodySm.copyWith(
                color: context.textSecondary,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: AppTheme.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
=======
              style: AppTheme.caption.copyWith(
                color: context.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ],
        ),
      ),
    );
  }
}
