import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Compact info pill / badge widget.
=======
/// A small badge/pill for displaying labels, statuses, or counts.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class InfoPill extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
<<<<<<< HEAD
=======
  final bool filled;
  final double fontSize;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const InfoPill({
    super.key,
    required this.label,
    required this.color,
    this.icon,
<<<<<<< HEAD
=======
    this.filled = false,
    this.fontSize = 11,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
=======
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? 8 : 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: filled ? color : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: filled
            ? null
            : Border.all(color: color.withOpacity(0.2), width: 1),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
<<<<<<< HEAD
            Icon(icon, size: 12, color: color),
=======
            Icon(
              icon,
              size: fontSize + 2,
              color: filled ? Colors.white : color,
            ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTheme.caption.copyWith(
<<<<<<< HEAD
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 0.3,
=======
              color: filled ? Colors.white : color,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
              letterSpacing: 0.2,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
          ),
        ],
      ),
    );
  }
}
