import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/models/user.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/providers/theme_provider.dart';
=======
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/screens/products/product_search_screen.dart';
import 'package:kenvinsam_sarihub/screens/products/product_detail_screen.dart';
import 'package:kenvinsam_sarihub/screens/products/add_product_screen.dart';
import 'package:kenvinsam_sarihub/screens/calculator/electric_bill_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_server_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_client_screen.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/screens/auth/login_screen.dart';
import 'package:kenvinsam_sarihub/screens/auth/change_password_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/backup_restore_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/user_management_screen.dart';
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/widgets/product_card.dart';
import 'package:kenvinsam_sarihub/widgets/featured_product_card.dart';
import 'package:kenvinsam_sarihub/widgets/section_header.dart';
import 'package:kenvinsam_sarihub/widgets/app_search_bar.dart';
import 'package:kenvinsam_sarihub/widgets/quick_action_card.dart';
import 'package:kenvinsam_sarihub/widgets/empty_state_widget.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/widgets/skeleton_loader.dart';
import 'package:kenvinsam_sarihub/widgets/sync_indicator.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
=======
import 'package:kenvinsam_sarihub/widgets/welcome_header.dart';
import 'package:kenvinsam_sarihub/widgets/skeleton_loader.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProducts = ref.watch(recentProductsProvider);
    final user = ref.watch(currentUserProvider);
    final isAdmin = user?.isAdmin ?? false;

    return RefreshIndicator(
      onRefresh: () async => refreshProducts(ref),
      color: AppTheme.primaryGreen,
<<<<<<< HEAD
      backgroundColor: context.cardBg,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          // Custom App Bar
          _buildSliverAppBar(context, ref, user, isAdmin),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.spaceLg),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceLg),
                    child: AppSearchBar(
                      hintText: 'Search products, categories...',
                      readOnly: true,
                      onTap: () =>
                          context.pushPage(const ProductSearchScreen()),
                    ),
                  ),
                  const SizedBox(height: AppTheme.space2xl),

                  // Quick Actions
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceLg),
                    child: const SectionHeader(
                      title: 'Quick Actions',
                      subtitle: 'Common tasks at a glance',
                      icon: Icons.bolt_rounded,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  _buildQuickActions(context, isAdmin),
                  const SizedBox(height: AppTheme.space2xl),

                  // Recently Updated Products
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceLg),
                    child: SectionHeader(
                      title: 'Recently Updated',
                      subtitle: 'Latest product changes',
                      icon: Icons.history_rounded,
                      actionLabel: 'See All',
                      onAction: () =>
                          context.pushPage(const ProductSearchScreen()),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  _buildProducts(context, recentProducts),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(
      BuildContext context, WidgetRef ref, User? user, bool isAdmin) {

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: context.surfaceBg,
      toolbarHeight: 70,
      titleSpacing: AppTheme.spaceLg,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getGreeting(),
            style: AppTheme.bodySm.copyWith(
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            user?.displayName ?? 'User',
            style: AppTheme.headingMd.copyWith(
              color: context.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        const SyncIndicator(),
        const SizedBox(width: 4),
        IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                RotationTransition(turns: anim, child: child),
            child: Icon(
              ref.watch(themeProvider)
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(ref.watch(themeProvider)),
              size: 22,
            ),
          ),
          onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          tooltip: 'Toggle Theme',
        ),
        _buildProfileMenu(context, ref, user, isAdmin),
        const SizedBox(width: AppTheme.spaceSm),
      ],
    );
  }

  Widget _buildProfileMenu(
      BuildContext context, WidgetRef ref, User? user, bool isAdmin) {
    return PopupMenuButton<String>(
      icon: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: context.isDark
              ? AppTheme.lightGreen.withOpacity(0.15)
              : AppTheme.primaryGreen.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person_rounded,
          size: 18,
          color: context.primaryColor,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      offset: const Offset(0, 50),
      elevation: 12,
      onSelected: (value) async {
        switch (value) {
          case 'logout':
            _confirmLogout(context, ref);
            break;
          case 'change_password':
            context.pushPage(const ChangePasswordScreen());
            break;
          case 'manage_users':
            context.pushPage(const UserManagementScreen());
            break;
          case 'backup':
            context.pushPage(const BackupRestoreScreen());
            break;
          case 'sync':
            context.pushPage(
              isAdmin ? const LanServerScreen() : const LanClientScreen(),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (user?.displayName ?? 'U')[0].toUpperCase(),
                      style: AppTheme.headingSm.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? 'User',
                      style: AppTheme.headingSm.copyWith(
                        color: context.textPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isAdmin
                            ? AppTheme.primaryGreen.withOpacity(0.1)
                            : AppTheme.info.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: Text(
                        isAdmin ? 'Admin' : 'Family',
                        style: AppTheme.caption.copyWith(
                          color: isAdmin ? AppTheme.primaryGreen : AppTheme.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const PopupMenuDivider(),
        if (isAdmin)
          _menuItem(Icons.backup_rounded, 'Backup & Restore',
              color: AppTheme.info, value: 'backup'),
        _menuItem(
          Icons.sync_rounded,
          isAdmin ? 'LAN Sync Server' : 'Sync with Admin',
          color: AppTheme.primaryGreen,
          value: 'sync',
        ),
        _menuItem(Icons.key_rounded, 'Change Password', value: 'change_password'),
        if (isAdmin)
          _menuItem(Icons.people_rounded, 'Manage Users', value: 'manage_users'),
        const PopupMenuDivider(),
        _menuItem(Icons.logout_rounded, 'Logout',
            color: AppTheme.error, value: 'logout'),
      ],
    );
  }

  PopupMenuItem<String> _menuItem(IconData icon, String label,
      {Color? color, required String value}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: AppTheme.bodyMd.copyWith(color: color)),
        ],
=======
      backgroundColor: Theme.of(context).cardTheme.color,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
            0, AppTheme.spaceLg, 0, AppTheme.space3xl + 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
              child: WelcomeHeader(
                name: user?.displayName ?? 'User',
                role: user?.role ?? '',
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
              child: AppSearchBar(
                hintText: 'Search products...',
                readOnly: true,
                onTap: () => context.pushPage(const ProductSearchScreen()),
              ),
            ),
            const SizedBox(height: AppTheme.space2xl),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
              child: const SectionHeader(
                title: 'Quick Actions',
                subtitle: 'Common tasks at a glance',
                icon: Icons.bolt_rounded,
              ),
            ),
            _buildQuickActions(context, isAdmin),
            const SizedBox(height: AppTheme.space2xl),

            // Recently Updated Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
              child: SectionHeader(
                title: 'Recently Updated',
                subtitle: 'Latest product changes',
                icon: Icons.history_rounded,
                actionLabel: 'See All',
                onAction: () => context.pushPage(const ProductSearchScreen()),
              ),
            ),
            recentProducts.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
                    child: EmptyStateWidget(
                      icon: Icons.inventory_2_outlined,
                      title: 'No products yet',
                      subtitle:
                          'Add your first product\nto get started',
                    ),
                  );
                }
                final featured = products.take(6).toList();
                final all = products.skip(featured.length).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 230,
                      child: AnimationLimiter(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceLg),
                          physics: const BouncingScrollPhysics(),
                          itemCount: featured.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: AppTheme.spaceMd),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 380),
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: FeaturedProductCard(
                                    product: featured[index],
                                    onTap: () => context.pushPage(
                                      ProductDetailScreen(
                                          product: featured[index]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (all.isNotEmpty) ...[
                      const SizedBox(height: AppTheme.space2xl),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceLg),
                        child: const SectionHeader(
                          title: 'All Products',
                          subtitle: 'Browse the rest of your inventory',
                          icon: Icons.inventory_2_rounded,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceLg),
                        child: AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: all.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 350),
                                child: SlideAnimation(
                                  verticalOffset: 30.0,
                                  child: FadeInAnimation(
                                    child: ProductCard(
                                      product: all[index],
                                      onTap: () => context.pushPage(
                                        ProductDetailScreen(
                                            product: all[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
                child: SkeletonLoader(type: SkeletonType.featured, count: 4),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(AppTheme.spaceLg),
                child: Text('Error: $e', style: AppTheme.bodyMd),
              ),
            ),
          ],
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 👋';
    return 'Good evening 🌙';
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.confirm(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      icon: Icons.logout_rounded,
      confirmLabel: 'Logout',
      destructive: true,
    );

    if (!confirmed || !context.mounted) return;
    await ref.read(currentUserProvider.notifier).logout();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Widget _buildQuickActions(BuildContext context, bool isAdmin) {
    final actions = <_ActionConfig>[
      _ActionConfig(
        icon: Icons.search_rounded,
        label: 'Search',
        color: AppTheme.primaryGreen,
        builder: (_) => const ProductSearchScreen(),
      ),
      if (isAdmin)
        _ActionConfig(
          icon: Icons.add_circle_rounded,
          label: 'Add Product',
          color: AppTheme.info,
          builder: (_) => const AddProductScreen(),
        ),
      _ActionConfig(
        icon: Icons.electric_bolt_rounded,
        label: 'Electric',
<<<<<<< HEAD
        color: AppTheme.warning,
=======
        color: const Color(0xFFF59E0B),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        builder: (_) => const ElectricBillScreen(),
      ),
      _ActionConfig(
        icon: Icons.sync_rounded,
        label: isAdmin ? 'Sync Server' : 'Sync Data',
        color: const Color(0xFF06B6D4),
        builder: (_) =>
            isAdmin ? const LanServerScreen() : const LanClientScreen(),
      ),
    ];

    return SizedBox(
<<<<<<< HEAD
      height: 110,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding:
              const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
          physics: const BouncingScrollPhysics(),
          itemCount: actions.length,
          separatorBuilder: (_, __) =>
              const SizedBox(width: AppTheme.spaceMd),
=======
      height: 116,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
          physics: const BouncingScrollPhysics(),
          itemCount: actions.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppTheme.spaceMd),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          itemBuilder: (context, index) {
            final action = actions[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                horizontalOffset: 30,
                child: FadeInAnimation(
                  child: QuickActionCard(
                    icon: action.icon,
                    label: action.label,
                    color: action.color,
                    onTap: () => context.pushPage(action.builder(context)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildProducts(
      BuildContext context, AsyncValue<List<Product>> recentProducts) {
    return recentProducts.when(
      data: (products) {
        if (products.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
            child: EmptyStateWidget(
              icon: Icons.inventory_2_outlined,
              title: 'No products yet',
              subtitle: 'Add your first product to get started',
            ),
          );
        }
        final featured = products.take(6).toList();
        final rest = products.skip(featured.length).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured horizontal scroll
            SizedBox(
              height: 230,
              child: AnimationLimiter(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spaceLg),
                  physics: const BouncingScrollPhysics(),
                  itemCount: featured.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppTheme.spaceMd),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 380),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: FeaturedProductCard(
                            product: featured[index],
                            onTap: () => context.pushPage(
                              ProductDetailScreen(product: featured[index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // All products list
            if (rest.isNotEmpty) ...[
              const SizedBox(height: AppTheme.space2xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spaceLg),
                child: const SectionHeader(
                  title: 'All Products',
                  subtitle: 'Browse your inventory',
                  icon: Icons.inventory_2_rounded,
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spaceLg),
                child: AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rest.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 350),
                        child: SlideAnimation(
                          verticalOffset: 30.0,
                          child: FadeInAnimation(
                            child: ProductCard(
                              product: rest[index],
                              onTap: () => context.pushPage(
                                ProductDetailScreen(product: rest[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
        child: SkeletonLoader(type: SkeletonType.featured, count: 4),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        child: Text('Error: $e', style: AppTheme.bodyMd),
      ),
    );
  }
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}

class _ActionConfig {
  final IconData icon;
  final String label;
  final Color color;
  final WidgetBuilder builder;

  _ActionConfig({
    required this.icon,
    required this.label,
    required this.color,
    required this.builder,
  });
}
