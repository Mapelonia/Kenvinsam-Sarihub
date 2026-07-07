import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Product list card used in home tab and search results.
=======
import 'package:kenvinsam_sarihub/widgets/pressable_scale.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Premium product list card with image, price, profit indicator and margin badge.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
    final profit = Helpers.calculateProfit(product.capitalPrice, product.sellingPrice);
    final isProfit = profit > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
          ),
          child: Row(
            children: [
              // Product image
              _buildImage(isDark),
              const SizedBox(width: AppTheme.spaceLg),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTheme.headingSm.copyWith(
                        color: context.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                    if (product.description != null &&
                        product.description!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        product.description!,
                        style: AppTheme.caption.copyWith(
                          color: context.textSecondary,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      product.category,
                      style: AppTheme.caption.copyWith(
                        color: context.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceSm),
                    Row(
                      children: [
                        Text(
                          Helpers.formatCurrency(product.sellingPrice),
                          style: AppTheme.bodyMd.copyWith(
                            color: context.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spaceSm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isProfit
                                ? AppTheme.success.withOpacity(0.1)
                                : AppTheme.error.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusFull),
                          ),
                          child: Text(
                            '${isProfit ? '+' : ''}${Helpers.formatCurrency(profit)}',
                            style: AppTheme.caption.copyWith(
                              color: isProfit ? AppTheme.success : AppTheme.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.chevron_right_rounded,
                color: context.textMuted,
                size: 20,
              ),
            ],
=======
    final categoryIcon =
        AppConstants.categoryIcons[product.category] ?? Icons.inventory_2_outlined;
    final isPositive = product.profit >= 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasImage =
        product.imagePath != null && File(product.imagePath!).existsSync();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: PressableScale(
        onTap: onTap,
        scaleAmount: 0.98,
        child: Container(
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
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product image
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: hasImage
                        ? null
                        : LinearGradient(
                            colors: [
                              AppTheme.paleGreen,
                              AppTheme.lightGreen.withOpacity(0.25),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: hasImage
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMd),
                          child: Image.file(
                            File(product.imagePath!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(categoryIcon,
                          color: AppTheme.primaryGreen, size: 28),
                ),
                const SizedBox(width: AppTheme.spaceMd),

                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        style: AppTheme.bodyLg.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.1,
                          color: context.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            categoryIcon,
                            size: 12,
                            color: context.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              product.category,
                              style: AppTheme.caption.copyWith(
                                color: context.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spaceSm),
                      Row(
                        children: [
                          Text(
                            Helpers.formatCurrency(product.sellingPrice),
                            style: AppTheme.headingSm.copyWith(
                              color: AppTheme.primaryGreen,
                              fontSize: 17,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spaceSm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (isPositive
                                      ? AppTheme.success
                                      : AppTheme.error)
                                  .withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  size: 10,
                                  color: isPositive
                                      ? AppTheme.success
                                      : AppTheme.error,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  Helpers.formatCurrency(product.profit),
                                  style: AppTheme.caption.copyWith(
                                    color: isPositive
                                        ? AppTheme.success
                                        : AppTheme.error,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Margin badge with gradient
                Container(
                  width: 56,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryGreen, AppTheme.lightGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${product.profitPercentage.toStringAsFixed(0)}%',
                        style: AppTheme.label.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'margin',
                        style: AppTheme.caption.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildImage(bool isDark) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        color: isDark
            ? AppTheme.cardDarkElevated
            : const Color(0xFFE8ECF0),
      ),
      clipBehavior: Clip.antiAlias,
      child: product.imagePath != null && File(product.imagePath!).existsSync()
          ? Image.file(
              File(product.imagePath!),
              fit: BoxFit.cover,
            )
          : Icon(
              Icons.shopping_bag_rounded,
              color: isDark ? AppTheme.textMutedDark : AppTheme.textMuted,
              size: 24,
            ),
    );
  }
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
