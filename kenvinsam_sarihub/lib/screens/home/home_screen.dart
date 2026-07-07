import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/providers/theme_provider.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/screens/home/home_tab.dart';
import 'package:kenvinsam_sarihub/screens/categories/categories_screen.dart';
import 'package:kenvinsam_sarihub/screens/calculator/calculator_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/admin_dashboard.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/screens/admin/backup_restore_screen.dart';
import 'package:kenvinsam_sarihub/screens/products/add_product_screen.dart';
import 'package:kenvinsam_sarihub/services/backup_service.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
=======
import 'package:kenvinsam_sarihub/screens/auth/login_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/user_management_screen.dart';
import 'package:kenvinsam_sarihub/screens/auth/change_password_screen.dart';
import 'package:kenvinsam_sarihub/screens/admin/backup_restore_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_server_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_client_screen.dart';
import 'package:kenvinsam_sarihub/screens/products/add_product_screen.dart';
import 'package:kenvinsam_sarihub/widgets/sync_indicator.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/widgets/info_pill.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

<<<<<<< HEAD
class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkBackupReminder());
  }

  Future<void> _checkBackupReminder() async {
    final user = ref.read(currentUserProvider);
    if (user == null || !user.isAdmin) return;

    final now = DateTime.now();
    if (now.weekday != DateTime.sunday) return;

    final prefs = await SharedPreferences.getInstance();
    final lastReminder = prefs.getString('last_backup_reminder');

    // Only show once per Sunday
    if (lastReminder != null) {
      final lastDate = DateTime.tryParse(lastReminder);
      if (lastDate != null &&
          lastDate.year == now.year &&
          lastDate.month == now.month &&
          lastDate.day == now.day) {
        return;
      }
    }

    // Mark as reminded today
    await prefs.setString('last_backup_reminder', now.toIso8601String());

    if (!mounted) return;
    _showBackupReminderDialog();
  }

  void _showBackupReminderDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.backup_rounded,
                  color: AppTheme.warning,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppTheme.spaceLg),
              Text(
                'Weekly Backup Reminder',
                style: AppTheme.headingMd,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'It\'s Sunday! Would you like to create a backup of your data?',
                style: AppTheme.bodySm.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.space2xl),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Later'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _runQuickBackup();
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Backup'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spaceSm),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.pushPage(const BackupRestoreScreen());
                },
                child: const Text('Open Backup Settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _runQuickBackup() async {
    final result = await BackupService().exportBackup();
    if (!mounted) return;
    if (result.success) {
      AppSnackbar.show(context, 'Backup saved successfully!',
          type: SnackbarType.success);
    } else {
      AppSnackbar.show(context, result.message, type: SnackbarType.error);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }
=======
class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final isAdmin = user?.isAdmin ?? false;
<<<<<<< HEAD
    final isDark = context.isDark;
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

    final screens = [
      const HomeTab(),
      const CategoriesScreen(),
      const CalculatorScreen(),
      if (isAdmin) const AdminDashboard(),
    ];

<<<<<<< HEAD
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        floatingActionButton: isAdmin && _currentIndex == 0
            ? _AnimatedFAB(
                onPressed: () => context.pushPage(const AddProductScreen()),
              )
            : null,
        bottomNavigationBar: _buildBottomNav(isAdmin, isDark),
=======
    final destinations = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.category_outlined),
        selectedIcon: Icon(Icons.category_rounded),
        label: 'Categories',
      ),
      const NavigationDestination(
        icon: Icon(Icons.calculate_outlined),
        selectedIcon: Icon(Icons.calculate_rounded),
        label: 'Calculator',
      ),
      if (isAdmin)
        const NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: 'Dashboard',
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kenvinsam SariHub'),
        actions: [
          const SyncIndicator(),
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
              ),
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            offset: const Offset(0, 50),
            onSelected: (value) async {
              switch (value) {
                case 'logout':
                  _confirmLogout();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'User',
                        style: AppTheme.headingSm,
                      ),
                      const SizedBox(height: 6),
                      InfoPill(
                        label: user?.role.toUpperCase() ?? '',
                        color: isAdmin ? AppTheme.primaryGreen : AppTheme.info,
                        icon: isAdmin
                            ? Icons.admin_panel_settings_rounded
                            : Icons.family_restroom_rounded,
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuDivider(),
              if (isAdmin)
                PopupMenuItem(
                  value: 'backup',
                  child: _MenuRow(
                    icon: Icons.backup_rounded,
                    label: 'Backup & Restore',
                    iconColor: AppTheme.info,
                  ),
                ),
              PopupMenuItem(
                value: 'sync',
                child: _MenuRow(
                  icon: Icons.sync_rounded,
                  label: isAdmin ? 'LAN Sync Server' : 'Sync with Admin',
                  iconColor: AppTheme.primaryGreen,
                ),
              ),
              PopupMenuItem(
                value: 'change_password',
                child: _MenuRow(
                  icon: Icons.key_rounded,
                  label: 'Change Password',
                ),
              ),
              if (isAdmin)
                PopupMenuItem(
                  value: 'manage_users',
                  child: _MenuRow(
                    icon: Icons.people_rounded,
                    label: 'Manage Users',
                  ),
                ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: _MenuRow(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  iconColor: AppTheme.error,
                  textColor: AppTheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.025),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: screens[_currentIndex],
        ),
      ),
      floatingActionButton: isAdmin && _currentIndex == 0
          ? _AnimatedFAB(
              onPressed: () => context.pushPage(const AddProductScreen()),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) =>
                setState(() => _currentIndex = index),
            destinations: destinations,
          ),
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildBottomNav(bool isAdmin, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceLg,
            vertical: AppTheme.spaceSm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                outlinedIcon: Icons.home_outlined,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => _onTabChanged(0),
              ),
              _NavItem(
                icon: Icons.grid_view_rounded,
                outlinedIcon: Icons.grid_view_outlined,
                label: 'Categories',
                isSelected: _currentIndex == 1,
                onTap: () => _onTabChanged(1),
              ),
              _NavItem(
                icon: Icons.calculate_rounded,
                outlinedIcon: Icons.calculate_outlined,
                label: 'Calculator',
                isSelected: _currentIndex == 2,
                onTap: () => _onTabChanged(2),
              ),
              if (isAdmin)
                _NavItem(
                  icon: Icons.dashboard_rounded,
                  outlinedIcon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  isSelected: _currentIndex == 3,
                  onTap: () => _onTabChanged(3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData outlinedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.outlinedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
=======
  void _confirmLogout() async {
    final confirmed = await AppDialog.confirm(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout? You will need to sign in again.',
      icon: Icons.logout_rounded,
      confirmLabel: 'Logout',
      destructive: true,
    );

    if (!confirmed || !mounted) return;
    await ref.read(currentUserProvider.notifier).logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? textColor;

  const _MenuRow({
    required this.icon,
    required this.label,
    this.iconColor,
    this.textColor,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
    final selectedColor = isDark ? AppTheme.lightGreen : AppTheme.primaryGreen;
    final unselectedColor = context.textMuted;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? icon : outlinedIcon,
                key: ValueKey(isSelected),
                color: isSelected ? selectedColor : unselectedColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: isSelected ? selectedColor : unselectedColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
=======
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary;
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor ?? defaultColor),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTheme.bodyMd.copyWith(color: textColor ?? defaultColor),
        ),
      ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
  }
}

class _AnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
<<<<<<< HEAD
=======

>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  const _AnimatedFAB({required this.onPressed});

  @override
  State<_AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<_AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(
<<<<<<< HEAD
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
=======
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        decoration: BoxDecoration(
<<<<<<< HEAD
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          gradient: AppTheme.primaryGradient,
          boxShadow: AppTheme.shadowGreen,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add Product',
                    style: AppTheme.label.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
=======
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: widget.onPressed,
          backgroundColor: AppTheme.primaryGreen,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
    );
  }
}
