import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Category card with icon and count.
class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final int productCount;
  final VoidCallback? onTap;
  final Color? color;
=======
/// A reusable category card widget.
class CategoryCard extends StatelessWidget {
  final String name;
  final int itemCount;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const CategoryCard({
    super.key,
    required this.name,
<<<<<<< HEAD
    required this.icon,
    this.productCount = 0,
    this.onTap,
    this.color,
=======
    required this.itemCount,
    required this.icon,
    this.color = AppTheme.primaryGreen,
    this.onTap,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
    final cardColor = color ?? AppTheme.primaryGreen;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? cardColor.withOpacity(0.15)
                : cardColor.withOpacity(0.08),
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cardColor.withOpacity(isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Icon(icon, color: cardColor, size: 20),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            Text(
              name,
              style: AppTheme.bodyMd.copyWith(
                color: context.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$productCount ${productCount == 1 ? 'product' : 'products'}',
              style: AppTheme.caption.copyWith(
                color: context.textMuted,
              ),
            ),
          ],
=======
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$itemCount item${itemCount == 1 ? '' : 's'}',
                    style: AppTheme.caption.copyWith(color: context.textSecondary),
                  ),
                ],
              ),
            ],
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
    );
  }
}
