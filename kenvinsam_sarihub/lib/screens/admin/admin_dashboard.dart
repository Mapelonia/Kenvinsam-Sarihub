import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/services/product_service.dart';
import 'package:kenvinsam_sarihub/models/price_history.dart';
import 'package:kenvinsam_sarihub/screens/products/add_product_screen.dart';
import 'package:kenvinsam_sarihub/screens/products/product_search_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/user_management_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/category_management_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/backup_restore_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_server_screen.dart';
import 'package:kenvinsam_sarihub/widgets/section_header.dart';
import 'package:kenvinsam_sarihub/widgets/stat_card.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  List<PriceHistory> _priceAlerts = [];
  bool _loadingAnalytics = true;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _loadingAnalytics = true);
    final productService = ProductService();
    _priceAlerts = await productService.getPriceAlerts();
    if (mounted) setState(() => _loadingAnalytics = false);
  }

  @override
  Widget build(BuildContext context) {
    final totalProducts = ref.watch(totalProductCountProvider);
    final user = ref.watch(currentUserProvider);

    return RefreshIndicator(
      color: AppTheme.primaryGreen,
      onRefresh: () async {
        refreshProducts(ref);
        await _loadAnalytics();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(
          AppTheme.spaceLg,
<<<<<<< HEAD
          AppTheme.space2xl,
          AppTheme.spaceLg,
          AppTheme.space3xl + 70,
        ),
        children: [
          // Title
          Text(
            'Dashboard',
            style: AppTheme.headingLg.copyWith(
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage your store',
            style: AppTheme.bodySm.copyWith(
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.space2xl),

          // Header banner
=======
          AppTheme.spaceLg,
          AppTheme.spaceLg,
          AppTheme.space3xl,
        ),
        children: [
          // Header
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          _buildHeaderCard(user?.displayName ?? 'Admin'),
          const SizedBox(height: AppTheme.space2xl),

          // Overview
          const SectionHeader(
            title: 'Overview',
            subtitle: 'Store summary',
<<<<<<< HEAD
            icon: Icons.analytics_rounded,
          ),
          const SizedBox(height: AppTheme.spaceMd),
=======
            icon: Icons.dashboard_rounded,
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          _buildOverviewStats(totalProducts),
          const SizedBox(height: AppTheme.space2xl),

          // Quick management
          const SectionHeader(
            title: 'Quick Management',
<<<<<<< HEAD
            subtitle: 'Admin tools',
            icon: Icons.settings_rounded,
          ),
          const SizedBox(height: AppTheme.spaceMd),
=======
            subtitle: 'Manage your store',
            icon: Icons.settings_rounded,
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          _buildManagementGrid(context),
          const SizedBox(height: AppTheme.space2xl),

          // Price alerts
          if (_priceAlerts.isNotEmpty) ...[
            SectionHeader(
              title: 'Price Alerts',
              subtitle: '${_priceAlerts.length} recent change(s)',
              icon: Icons.notifications_active_rounded,
            ),
<<<<<<< HEAD
            const SizedBox(height: AppTheme.spaceMd),
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            _buildPriceAlerts(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderCard(String name) {
    return Container(
<<<<<<< HEAD
      padding: const EdgeInsets.all(AppTheme.spaceXl),
      decoration: BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowGreen,
=======
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.darkGreen, AppTheme.primaryGreen, AppTheme.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      child: Stack(
        children: [
          Positioned(
<<<<<<< HEAD
            top: -25,
            right: -15,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
=======
            top: -30,
            right: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
<<<<<<< HEAD
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Icon(
                  Icons.admin_panel_settings_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppTheme.spaceLg),
=======
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 1),
                ),
                child: const Icon(
                  Icons.dashboard_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
<<<<<<< HEAD
                      'Welcome back, $name',
                      style: AppTheme.headingSm.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Full admin access enabled',
                      style: AppTheme.bodySm.copyWith(
                        color: Colors.white.withOpacity(0.8),
=======
                      'Admin Dashboard',
                      style: AppTheme.headingMd.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Welcome back, $name',
                      style: AppTheme.bodySm.copyWith(
                        color: Colors.white.withOpacity(0.85),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStats(AsyncValue<int> totalProducts) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 300),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 20.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Products',
                    value: totalProducts.when(
                      data: (v) => '$v',
                      loading: () => '...',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.inventory_2_rounded,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Expanded(
                  child: StatCard(
                    title: 'Price Alerts',
                    value: _loadingAnalytics ? '...' : '${_priceAlerts.length}',
                    icon: Icons.notifications_active_rounded,
                    color: AppTheme.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementGrid(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final actions = [
      _MgmtAction(
        icon: Icons.category_rounded,
        label: 'Categories',
        color: AppTheme.primaryGreen,
        onTap: () async {
          await context.pushPage(const CategoryManagementScreen());
          refreshProducts(ref);
        },
      ),
      _MgmtAction(
        icon: Icons.add_box_rounded,
        label: 'Add Product',
        color: AppTheme.info,
        onTap: () => context.pushPage(const AddProductScreen()),
      ),
      _MgmtAction(
        icon: Icons.inventory_rounded,
        label: 'All Products',
<<<<<<< HEAD
        color: const Color(0xFF8B5CF6),
=======
        color: AppTheme.info,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        onTap: () => context.pushPage(const ProductSearchScreen()),
      ),
      _MgmtAction(
        icon: Icons.people_rounded,
<<<<<<< HEAD
        label: 'Users',
        color: const Color(0xFFEC4899),
=======
        label: 'Manage Users',
        color: const Color(0xFF8B5CF6),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        onTap: () => context.pushPage(const UserManagementScreen()),
      ),
      _MgmtAction(
        icon: Icons.wifi_tethering_rounded,
        label: 'LAN Sync',
        color: const Color(0xFF06B6D4),
        onTap: () => context.pushPage(const LanServerScreen()),
      ),
      _MgmtAction(
        icon: Icons.backup_rounded,
        label: 'Backup',
<<<<<<< HEAD
        color: AppTheme.warning,
=======
        color: AppTheme.info,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        onTap: () => context.pushPage(const BackupRestoreScreen()),
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
<<<<<<< HEAD
      crossAxisCount: 3,
      crossAxisSpacing: AppTheme.spaceMd,
      mainAxisSpacing: AppTheme.spaceMd,
      childAspectRatio: 0.95,
=======
      crossAxisCount: 2,
      crossAxisSpacing: AppTheme.spaceMd,
      mainAxisSpacing: AppTheme.spaceMd,
      childAspectRatio: 2.6,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      children: actions
          .map((a) => _MgmtCard(
                icon: a.icon,
                label: a.label,
                color: a.color,
                onTap: a.onTap,
<<<<<<< HEAD
                isDark: isDark,
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ))
          .toList(),
    );
  }

  Widget _buildPriceAlerts() {
    return Column(
      children: _priceAlerts.take(5).map((alert) {
<<<<<<< HEAD
        final isDark = context.isDark;
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
<<<<<<< HEAD
              color: isDark
                  ? AppTheme.warning.withOpacity(0.06)
                  : AppTheme.warning.withOpacity(0.04),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(
                color: AppTheme.warning.withOpacity(isDark ? 0.15 : 0.12),
              ),
=======
              color: AppTheme.warning.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(color: AppTheme.warning.withOpacity(0.2)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
<<<<<<< HEAD
                    color: AppTheme.warning.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: const Icon(Icons.arrow_upward_rounded,
                      color: AppTheme.warning, size: 16),
=======
                    color: AppTheme.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: const Icon(Icons.arrow_upward_rounded,
                      color: AppTheme.warning, size: 18),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.productName,
<<<<<<< HEAD
                        style: AppTheme.bodyMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
=======
                        style:
                            AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${Helpers.formatCurrency(alert.oldSellingPrice)} → ${Helpers.formatCurrency(alert.newSellingPrice)}',
<<<<<<< HEAD
                        style: AppTheme.caption.copyWith(
                          color: context.textMuted,
                        ),
=======
                        style: AppTheme.caption
                            .copyWith(color: context.textSecondary),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      ),
                    ],
                  ),
                ),
<<<<<<< HEAD
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                  child: Text(
                    '+${alert.percentageChange.toStringAsFixed(1)}%',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.error,
                      fontWeight: FontWeight.w700,
                    ),
=======
                Text(
                  '+${alert.percentageChange.toStringAsFixed(1)}%',
                  style: AppTheme.bodyMd.copyWith(
                    color: AppTheme.error,
                    fontWeight: FontWeight.w800,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MgmtAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _MgmtAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _MgmtCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
<<<<<<< HEAD
  final bool isDark;
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const _MgmtCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
<<<<<<< HEAD
    required this.isDark,
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark
                ? color.withOpacity(0.15)
                : color.withOpacity(0.1),
          ),
          boxShadow: isDark ? null : AppTheme.shadowSm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: context.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
=======
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceMd, vertical: AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.bodySm.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
    );
  }
}
