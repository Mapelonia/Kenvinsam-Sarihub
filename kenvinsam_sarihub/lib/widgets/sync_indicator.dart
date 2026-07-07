import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/providers/sync_provider.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Compact sync status indicator for the app bar.
=======
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/providers/sync_provider.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_server_screen.dart';
import 'package:kenvinsam_sarihub/screens/sync/lan_client_screen.dart';
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Compact sync status indicator shown in the app bar.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< HEAD
    final user = ref.watch(currentUserProvider);
    final isAdmin = user?.isAdmin ?? false;
    final isDark = context.isDark;

    // Check connection status based on role
    final bool isConnected;
    final bool isSyncing;

    if (isAdmin) {
      final serverState = ref.watch(lanServerProvider);
      isConnected = serverState.isRunning && serverState.connectedClients > 0;
      isSyncing = false;
    } else {
      final clientState = ref.watch(lanClientProvider);
      isConnected = clientState.isRealtimeConnected ||
          clientState.status == 'connected';
      isSyncing = clientState.status == 'syncing';
    }

    if (!isConnected && !isSyncing) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSyncing
            ? AppTheme.warning.withOpacity(isDark ? 0.15 : 0.1)
            : AppTheme.success.withOpacity(isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSyncing)
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppTheme.warning,
              ),
            )
          else
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppTheme.success,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.success.withOpacity(0.4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(width: 6),
          Text(
            isSyncing ? 'Syncing' : 'Synced',
            style: AppTheme.caption.copyWith(
              color: isSyncing ? AppTheme.warning : AppTheme.success,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
=======
    final isAdmin = ref.watch(currentUserProvider)?.isAdmin ?? false;
    return isAdmin ? const _AdminSyncIndicator() : const _ClientSyncIndicator();
  }
}

class _AdminSyncIndicator extends ConsumerWidget {
  const _AdminSyncIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverState = ref.watch(lanServerProvider);
    if (!serverState.isRunning) return const SizedBox.shrink();

    return _IndicatorButton(
      icon: Icons.wifi_tethering_rounded,
      label: '${serverState.connectedClients}',
      pulse: true,
      onTap: () => context.pushPage(const LanServerScreen()),
    );
  }
}

class _ClientSyncIndicator extends ConsumerWidget {
  const _ClientSyncIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientState = ref.watch(lanClientProvider);
    if (!clientState.isPaired) return const SizedBox.shrink();

    Color statusColor;
    IconData statusIcon;

    switch (clientState.status) {
      case 'connected':
        statusColor = const Color(0xFF86EFAC);
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'syncing':
        statusColor = const Color(0xFF93C5FD);
        statusIcon = Icons.sync_rounded;
        break;
      case 'reconnecting':
        statusColor = const Color(0xFFFCD34D);
        statusIcon = Icons.sync_problem_rounded;
        break;
      default:
        statusColor = const Color(0xFFFCA5A5);
        statusIcon = Icons.sync_disabled_rounded;
    }

    return GestureDetector(
      onTap: () => context.pushPage(const LanClientScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (clientState.status == 'syncing')
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: statusColor,
                ),
              )
            else
              Icon(statusIcon, size: 14, color: statusColor),
            const SizedBox(width: 4),
            _PulsingDot(color: statusColor),
          ],
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}
<<<<<<< HEAD
=======

class _IndicatorButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool pulse;

  const _IndicatorButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.pulse = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pulse)
              const _PulsingDot(color: Color(0xFF86EFAC))
            else
              Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_animation.value),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_animation.value * 0.5),
                blurRadius: 4,
              ),
            ],
          ),
        );
      },
    );
  }
}
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
