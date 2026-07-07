import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/services/product_service.dart';
import 'package:kenvinsam_sarihub/screens/products/add_product_screen.dart';
import 'package:kenvinsam_sarihub/widgets/info_pill.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(currentUserProvider)?.isAdmin ?? false;
    final categoryIcon = AppConstants.iconFor(product.category);
    final hasImage =
        product.imagePath != null && File(product.imagePath!).existsSync();
<<<<<<< HEAD
    final isDark = context.isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: AppTheme.headingMd.copyWith(color: context.textPrimary),
        ),
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit_rounded, size: 20),
=======

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit_rounded),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              tooltip: 'Edit',
              onPressed: () => context.pushPage(
                AddProductScreen(product: product),
              ),
            ),
            IconButton(
<<<<<<< HEAD
              icon: Icon(Icons.delete_outline_rounded,
                  size: 20, color: AppTheme.error),
=======
              icon: const Icon(Icons.delete_outline_rounded),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              tooltip: 'Delete',
              onPressed: () => _confirmDelete(context, ref),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Hero image ───
<<<<<<< HEAD
            _buildHeroImage(context, hasImage, categoryIcon, isDark),
=======
            _buildHeroImage(context, hasImage, categoryIcon),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

            Padding(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Name & category ───
                  Text(
                    product.name,
                    style: AppTheme.headingLg.copyWith(
<<<<<<< HEAD
=======
                      letterSpacing: -0.3,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
<<<<<<< HEAD
                  InfoPill(
                    label: product.category,
                    color: context.primaryColor,
                    icon: categoryIcon,
                  ),

                  // ─── Description ───
                  if (product.description != null &&
                      product.description!.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spaceLg),
                    _buildDescriptionCard(context, isDark),
=======
                  Row(
                    children: [
                      InfoPill(
                        label: product.category,
                        color: AppTheme.primaryGreen,
                        icon: categoryIcon,
                      ),
                    ],
                  ),

                  // ─── Description (if present) ───
                  if (product.description != null &&
                      product.description!.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spaceLg),
                    _buildDescriptionCard(context),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  ],

                  const SizedBox(height: AppTheme.spaceLg),

                  // ─── Pricing card ───
<<<<<<< HEAD
                  _buildPricingCard(context, isDark),
                  const SizedBox(height: AppTheme.spaceMd),

                  // ─── Timestamps ───
                  _buildTimestamps(context, isDark),
=======
                  _buildPricingCard(context),
                  const SizedBox(height: AppTheme.spaceMd),

                  // ─── Timestamps ───
                  _buildInfoCard(context, [
                    _InfoRowData(
                      label: 'Created',
                      value: Helpers.formatDateTime(product.createdAt),
                      icon: Icons.calendar_today_rounded,
                      color: context.textSecondary,
                    ),
                    _InfoRowData(
                      label: 'Last Updated',
                      value: Helpers.formatDateTime(product.updatedAt),
                      icon: Icons.update_rounded,
                      color: context.textSecondary,
                      divider: false,
                    ),
                  ]),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

                  const SizedBox(height: AppTheme.space3xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(
<<<<<<< HEAD
      BuildContext context, bool hasImage, IconData categoryIcon, bool isDark) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        color: isDark ? AppTheme.cardDark : const Color(0xFFE8ECF0),
      ),
      clipBehavior: Clip.antiAlias,
=======
      BuildContext context, bool hasImage, IconData categoryIcon) {
    return SizedBox(
      width: double.infinity,
      height: 260,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      child: hasImage
          ? Hero(
              tag: 'product_image_${product.id}',
              child: Image.file(
                File(product.imagePath!),
                width: double.infinity,
<<<<<<< HEAD
                height: 240,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spaceLg),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppTheme.lightGreen.withOpacity(0.08)
                          : AppTheme.primaryGreen.withOpacity(0.06),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categoryIcon,
                      size: 48,
                      color: context.primaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  Text(
                    'No image',
                    style: AppTheme.bodySm.copyWith(color: context.textMuted),
                  ),
                ],
=======
                height: 260,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              color: context.isDark ? Colors.grey.shade900 : AppTheme.paleGreen,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spaceLg),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        categoryIcon,
                        size: 64,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceMd),
                    Text(
                      'No image',
                      style: AppTheme.bodySm.copyWith(
                          color: AppTheme.primaryGreen.withOpacity(0.6)),
                    ),
                  ],
                ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ),
            ),
    );
  }

<<<<<<< HEAD
  Widget _buildDescriptionCard(BuildContext context, bool isDark) {
=======
  Widget _buildDescriptionCard(BuildContext context) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
<<<<<<< HEAD
        color: isDark ? AppTheme.cardDark : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: context.borderColor),
=======
        color: context.isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: context.isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1,
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
<<<<<<< HEAD
              Icon(Icons.notes_rounded, size: 16, color: context.textMuted),
              const SizedBox(width: AppTheme.spaceSm),
              Text(
                'Description',
                style: AppTheme.label.copyWith(color: context.textMuted),
=======
              Icon(Icons.notes_rounded,
                  size: 16, color: context.textSecondary),
              const SizedBox(width: AppTheme.spaceSm),
              Text(
                'Description',
                style: AppTheme.label.copyWith(
                  color: context.textSecondary,
                  letterSpacing: 0.5,
                ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            product.description!,
            style: AppTheme.bodyMd.copyWith(
              color: context.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildPricingCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: context.borderColor),
        boxShadow: isDark ? null : AppTheme.shadowSm,
      ),
      child: Column(
        children: [
          _PriceRow(
            label: 'Capital Price',
            value: Helpers.formatCurrency(product.capitalPrice),
            icon: Icons.payments_outlined,
            color: AppTheme.warning,
          ),
          Divider(height: AppTheme.space2xl, color: context.borderColor),
          _PriceRow(
            label: 'Selling Price',
            value: Helpers.formatCurrency(product.sellingPrice),
            icon: Icons.sell_outlined,
            color: context.primaryColor,
            isBold: true,
          ),
          Divider(height: AppTheme.space2xl, color: context.borderColor),
          _PriceRow(
            label: 'Profit',
            value: Helpers.formatCurrency(product.profit),
            icon: Icons.trending_up_rounded,
            color: AppTheme.success,
          ),
          Divider(height: AppTheme.space2xl, color: context.borderColor),
          _PriceRow(
            label: 'Margin',
            value: '${product.profitPercentage.toStringAsFixed(1)}%',
            icon: Icons.percent_rounded,
            color: AppTheme.info,
          ),
        ],
=======
  Widget _buildPricingCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        child: Column(
          children: [
            _InfoRow(
              label: 'Capital Price',
              value: Helpers.formatCurrency(product.capitalPrice),
              icon: Icons.payments_outlined,
              color: AppTheme.warning,
              context: context,
            ),
            const Divider(height: AppTheme.space2xl),
            _InfoRow(
              label: 'Selling Price',
              value: Helpers.formatCurrency(product.sellingPrice),
              icon: Icons.sell_outlined,
              color: AppTheme.primaryGreen,
              context: context,
              valueBold: true,
            ),
            const Divider(height: AppTheme.space2xl),
            _InfoRow(
              label: 'Profit',
              value: Helpers.formatCurrency(product.profit),
              icon: Icons.trending_up_rounded,
              color: AppTheme.success,
              context: context,
            ),
            const Divider(height: AppTheme.space2xl),
            _InfoRow(
              label: 'Margin',
              value: '${product.profitPercentage.toStringAsFixed(1)}%',
              icon: Icons.percent_rounded,
              color: AppTheme.info,
              context: context,
            ),
          ],
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildTimestamps(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          _PriceRow(
            label: 'Created',
            value: Helpers.formatDateTime(product.createdAt),
            icon: Icons.calendar_today_rounded,
            color: context.textMuted,
          ),
          Divider(height: AppTheme.space2xl, color: context.borderColor),
          _PriceRow(
            label: 'Last Updated',
            value: Helpers.formatDateTime(product.updatedAt),
            icon: Icons.update_rounded,
            color: context.textMuted,
          ),
        ],
=======
  Widget _buildInfoCard(BuildContext context, List<_InfoRowData> rows) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        child: Column(
          children: rows
              .map((row) => Column(
                    children: [
                      _InfoRow(
                        label: row.label,
                        value: row.value,
                        icon: row.icon,
                        color: row.color,
                        context: context,
                      ),
                      if (row.divider != false) const Divider(height: AppTheme.space2xl),
                    ],
                  ))
              .toList(),
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.confirm(
      context: context,
      title: 'Delete Product',
      message: 'Delete "${product.name}"? This cannot be undone.',
      icon: Icons.delete_rounded,
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;

    await ProductService().deleteProduct(product.id!);
    refreshProducts(ref);
    if (context.mounted) {
      Navigator.pop(context);
      AppSnackbar.show(context, 'Product deleted', type: SnackbarType.success);
    }
  }
}

<<<<<<< HEAD
class _PriceRow extends StatelessWidget {
=======
class _InfoRowData {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  final String label;
  final String value;
  final IconData icon;
  final Color color;
<<<<<<< HEAD
  final bool isBold;

  const _PriceRow({
=======
  final bool? divider;

  const _InfoRowData({
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
<<<<<<< HEAD
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
=======
    this.divider,
  });
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final BuildContext context;
  final bool valueBold;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.context,
    this.valueBold = false,
  });

  @override
  Widget build(BuildContext ctx) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
<<<<<<< HEAD
            color: color.withOpacity(0.1),
=======
            color: color.withOpacity(0.12),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: AppTheme.spaceMd),
        Expanded(
          child: Text(
            label,
            style: AppTheme.bodyMd.copyWith(color: context.textSecondary),
          ),
        ),
        Text(
          value,
<<<<<<< HEAD
          style: (isBold ? AppTheme.headingSm : AppTheme.bodyMd).copyWith(
=======
          style: (valueBold ? AppTheme.headingSm : AppTheme.bodyMd).copyWith(
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
      ],
    );
  }
}
