import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Featured product card for horizontal scroll.
class FeaturedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
=======
import 'package:kenvinsam_sarihub/widgets/pressable_scale.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// A premium featured product card used in horizontal carousels.
class FeaturedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final double width;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const FeaturedProductCard({
    super.key,
    required this.product,
    this.onTap,
<<<<<<< HEAD
=======
    this.width = 168,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
    final profit = Helpers.calculateProfit(product.capitalPrice, product.sellingPrice);
    final margin = Helpers.calculateProfitPercentage(
        product.capitalPrice, product.sellingPrice);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.grey.shade200,
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
=======
    final categoryIcon =
        AppConstants.categoryIcons[product.category] ?? Icons.inventory_2_outlined;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasImage =
        product.imagePath != null && File(product.imagePath!).existsSync();

    return PressableScale(
      onTap: onTap,
      scaleAmount: 0.97,
      child: Container(
        width: width,
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
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            // Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  color: isDark
                      ? AppTheme.cardDarkElevated
                      : const Color(0xFFE8ECF0),
                ),
                clipBehavior: Clip.antiAlias,
                child: product.imagePath != null &&
                        File(product.imagePath!).existsSync()
                    ? Image.file(
                        File(product.imagePath!),
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(
                          Icons.shopping_bag_rounded,
                          color: context.textMuted,
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),

            // Name
            Text(
              product.name,
              style: AppTheme.bodyMd.copyWith(
                color: context.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),

            // Category
            Text(
              product.category,
              style: AppTheme.caption.copyWith(color: context.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.spaceSm),

            // Price and margin
            Row(
              children: [
                Text(
                  Helpers.formatCurrency(product.sellingPrice),
                  style: AppTheme.bodyMd.copyWith(
                    color: context.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: profit >= 0
                        ? AppTheme.success.withOpacity(0.1)
                        : AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                  child: Text(
                    '${margin.toStringAsFixed(0)}%',
                    style: AppTheme.caption.copyWith(
                      color: profit >= 0 ? AppTheme.success : AppTheme.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
=======
            // Image area with gradient and overlays
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusLg),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: hasImage
                          ? null
                          : LinearGradient(
                              colors: [
                                AppTheme.paleGreen,
                                AppTheme.lightGreen.withOpacity(0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                    ),
                    child: hasImage
                        ? Image.file(
                            File(product.imagePath!),
                            width: double.infinity,
                            height: 110,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              categoryIcon,
                              size: 44,
                              color: AppTheme.primaryGreen.withOpacity(0.7),
                            ),
                          ),
                  ),

                  // Margin badge (top-right)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryGreen, AppTheme.lightGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusFull),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryGreen.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up_rounded,
                            size: 11,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${product.profitPercentage.toStringAsFixed(0)}%',
                            style: AppTheme.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Category icon (bottom-left)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        categoryIcon,
                        size: 14,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spaceMd,
                AppTheme.spaceMd,
                AppTheme.spaceMd,
                AppTheme.spaceMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTheme.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: context.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: AppTheme.caption.copyWith(
                      color: context.textSecondary,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Text(
                    Helpers.formatCurrency(product.sellingPrice),
                    style: AppTheme.headingSm.copyWith(
                      color: AppTheme.primaryGreen,
                      fontSize: 16,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
          ],
        ),
      ),
    );
  }
}
