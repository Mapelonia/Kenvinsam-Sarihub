import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/providers/category_provider.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/screens/products/product_search_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/category_management_screen.dart';
import 'package:kenvinsam_sarihub/widgets/skeleton_loader.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryCounts = ref.watch(categoryCountsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isAdmin = ref.watch(currentUserProvider)?.isAdmin ?? false;

    return RefreshIndicator(
      onRefresh: () async {
        refreshProducts(ref);
        refreshCategories(ref);
      },
      color: AppTheme.primaryGreen,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: [
          // Header
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
<<<<<<< HEAD
                AppTheme.spaceLg, AppTheme.space2xl,
=======
                AppTheme.spaceLg, AppTheme.spaceLg,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                AppTheme.spaceLg, AppTheme.spaceMd),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
<<<<<<< HEAD
                        child: Text(
                          'Categories',
                          style: AppTheme.headingLg.copyWith(
                            color: context.textPrimary,
                          ),
                        ),
                      ),
                      if (isAdmin)
                        GestureDetector(
                          onTap: () async {
=======
                          child:
                              Text('Categories', style: AppTheme.headingLg)),
                      if (isAdmin)
                        TextButton.icon(
                          onPressed: () async {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                            await context
                                .pushPage(const CategoryManagementScreen());
                            refreshCategories(ref);
                            refreshProducts(ref);
                          },
<<<<<<< HEAD
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: context.isDark
                                  ? AppTheme.lightGreen.withOpacity(0.1)
                                  : AppTheme.primaryGreen.withOpacity(0.08),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.settings_rounded,
                                  size: 14,
                                  color: context.primaryColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Manage',
                                  style: AppTheme.caption.copyWith(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Browse products by category',
                    style: AppTheme.bodySm.copyWith(
                      color: context.textSecondary,
                    ),
=======
                          icon: const Icon(Icons.settings_rounded, size: 16),
                          label: const Text('Manage'),
                          style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primaryGreen),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Browse products by category',
                    style: AppTheme.bodySm
                        .copyWith(color: context.textSecondary),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  categoryCounts.when(
                    data: (counts) {
                      final total =
                          counts.values.fold<int>(0, (a, b) => a + b);
                      final catCount = counts.length;
                      return Container(
                        padding: const EdgeInsets.symmetric(
<<<<<<< HEAD
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: context.paleGreenAdapted,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusFull),
                          border: Border.all(
                            color: context.isDark
                                ? AppTheme.lightGreen.withOpacity(0.1)
                                : AppTheme.primaryGreen.withOpacity(0.1),
                          ),
=======
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.paleGreen,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusFull),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
<<<<<<< HEAD
                            Icon(
                              Icons.inventory_2_rounded,
                              size: 14,
                              color: context.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$total products across $catCount categories',
                              style: AppTheme.caption.copyWith(
                                color: context.primaryColor,
=======
                            const Icon(Icons.inventory_2_rounded,
                                size: 14, color: AppTheme.primaryGreen),
                            const SizedBox(width: 6),
                            Text(
                              '$total products across $catCount categories',
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryGreen,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // Grid from DB
          categoriesAsync.when(
            data: (categories) => SliverPadding(
              padding: const EdgeInsets.fromLTRB(AppTheme.spaceLg,
                  AppTheme.spaceMd, AppTheme.spaceLg, AppTheme.space3xl + 70),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppTheme.spaceMd,
                  mainAxisSpacing: AppTheme.spaceMd,
<<<<<<< HEAD
                  childAspectRatio: 1.0,
=======
                  childAspectRatio: 1.05,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
<<<<<<< HEAD
                    final icon = AppConstants.iconFor(category.name, iconName: category.iconName);
=======
                    final icon = AppConstants.iconFor(category.name);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                    final color = _getColorForIndex(index);
                    final count = ref.watch(categoryCountsProvider).when(
                          data: (counts) => counts[category.name] ?? 0,
                          loading: () => 0,
                          error: (_, __) => 0,
                        );

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      duration: const Duration(milliseconds: 350),
                      child: ScaleAnimation(
                        child: FadeInAnimation(
<<<<<<< HEAD
                          child: _CategoryTile(
=======
                          child: _ModernCategoryCard(
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                            name: category.name,
                            count: count,
                            icon: icon,
                            color: color,
                            onTap: () => context.pushPage(
                              ProductSearchScreen(
                                  initialCategory: category.name),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: categories.length,
                ),
              ),
            ),
            loading: () => const SliverPadding(
              padding: EdgeInsets.fromLTRB(AppTheme.spaceLg, AppTheme.spaceMd,
                  AppTheme.spaceLg, AppTheme.space3xl),
              sliver: SliverToBoxAdapter(
                child: SkeletonLoader(type: SkeletonType.grid, count: 6),
              ),
            ),
            error: (e, _) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Error: $e', style: AppTheme.bodyMd)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForIndex(int index) {
    const colors = [
      Color(0xFFEF4444), Color(0xFFF59E0B), Color(0xFFEAB308),
      Color(0xFF84CC16), Color(0xFF22C55E), Color(0xFF06B6D4),
      Color(0xFF3B82F6), Color(0xFF8B5CF6), Color(0xFFEC4899),
      Color(0xFFF97316), Color(0xFF14B8A6), Color(0xFF6366F1),
      Color(0xFF78716C), Color(0xFF10B981), Color(0xFFF43F5E),
      Color(0xFFD97706),
    ];
    return colors[index % colors.length];
  }
}

<<<<<<< HEAD
class _CategoryTile extends StatelessWidget {
=======
class _ModernCategoryCard extends StatelessWidget {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  final String name;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

<<<<<<< HEAD
  const _CategoryTile({
=======
  const _ModernCategoryCard({
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    required this.name,
    required this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

<<<<<<< HEAD
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? color.withOpacity(0.12)
                : color.withOpacity(0.08),
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
        ),
        child: Stack(
          children: [
            // Background accent
            Positioned(
              top: -15,
              right: -15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(isDark ? 0.06 : 0.04),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),

                // Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTheme.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$count ${count == 1 ? 'item' : 'items'}',
                          style: AppTheme.caption.copyWith(
                            color: context.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.18),
                          color.withOpacity(0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTheme.bodyMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$count item${count == 1 ? '' : 's'}',
                            style: AppTheme.caption.copyWith(
                              color: context.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
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
