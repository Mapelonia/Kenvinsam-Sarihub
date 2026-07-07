import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Section header with title, optional subtitle, icon, and action button.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
=======
/// A consistent section header for grouping content.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? icon;
  final Color? iconColor;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
<<<<<<< HEAD
    this.icon,
    this.actionLabel,
    this.onAction,
=======
    this.actionLabel,
    this.onAction,
    this.icon,
    this.iconColor,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppTheme.lightGreen.withOpacity(0.12)
                  : AppTheme.primaryGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              icon,
              size: 16,
              color: context.primaryColor,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.headingSm.copyWith(
                  color: context.textPrimary,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTheme.caption.copyWith(
                    color: context.textMuted,
                  ),
                ),
            ],
          ),
        ),
        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceXs,
              ),
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppTheme.lightGreen.withOpacity(0.1)
                    : AppTheme.primaryGreen.withOpacity(0.06),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                actionLabel!,
                style: AppTheme.caption.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
=======
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: (iconColor ?? AppTheme.primaryGreen).withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Icon(
                icon,
                size: 16,
                color: iconColor ?? AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(width: AppTheme.spaceMd),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.headingMd.copyWith(letterSpacing: -0.2),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTheme.caption.copyWith(
                      color: context.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(actionLabel!),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_rounded, size: 14),
                ],
              ),
            ),
        ],
      ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
  }
}
