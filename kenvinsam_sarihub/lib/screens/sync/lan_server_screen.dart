import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/sync_provider.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class LanServerScreen extends ConsumerStatefulWidget {
  const LanServerScreen({super.key});

  @override
  ConsumerState<LanServerScreen> createState() => _LanServerScreenState();
}

class _LanServerScreenState extends ConsumerState<LanServerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverState = ref.watch(lanServerProvider);

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text(
          'LAN Sync Server',
          style: AppTheme.headingMd.copyWith(color: context.textPrimary),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: context.primaryColor,
          unselectedLabelColor: context.textMuted,
          indicatorColor: context.primaryColor,
          tabs: const [
            Tab(text: 'Server', icon: Icon(Icons.dns_rounded, size: 20)),
            Tab(text: 'Devices', icon: Icon(Icons.devices_rounded, size: 20)),
            Tab(text: 'Sync Log', icon: Icon(Icons.history_rounded, size: 20)),
=======
        title: const Text('LAN Sync Server'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Server', icon: Icon(Icons.dns)),
            Tab(text: 'Devices', icon: Icon(Icons.devices)),
            Tab(text: 'Sync Log', icon: Icon(Icons.history)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildServerTab(serverState),
          _buildDevicesTab(serverState),
          _buildSyncLogTab(serverState),
        ],
      ),
    );
  }

  Widget _buildServerTab(LanServerState serverState) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Server Status Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    serverState.isRunning ? Icons.wifi_tethering : Icons.wifi_tethering_off,
                    size: 64,
                    color: serverState.isRunning ? AppTheme.primaryGreen : Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    serverState.isRunning ? 'Server Running' : 'Server Stopped',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: serverState.isRunning ? AppTheme.primaryGreen : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    serverState.isRunning
                        ? 'Family devices can connect to this device'
                        : 'Start the server to allow sync',
                    style: TextStyle(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (serverState.isRunning) {
                          await ref.read(lanServerProvider.notifier).stopServer();
                        } else {
                          final success =
                              await ref.read(lanServerProvider.notifier).startServer();
                          if (!success && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to start server. Make sure you are connected to Wi-Fi.',
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: Icon(serverState.isRunning ? Icons.stop : Icons.play_arrow),
                      label: Text(serverState.isRunning ? 'Stop Server' : 'Start Server'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            serverState.isRunning ? Colors.red : AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Connection Info Card
          if (serverState.isRunning) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connection Info',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Share these details with Family devices',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    _InfoRow(
                      icon: Icons.wifi,
                      label: 'IP Address',
                      value: serverState.localIp ?? 'Unknown',
                      onCopy: () => _copyToClipboard(serverState.localIp ?? ''),
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      icon: Icons.numbers,
                      label: 'Port',
                      value: '${serverState.port}',
                      onCopy: () => _copyToClipboard('${serverState.port}'),
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      icon: Icons.vpn_key,
                      label: 'Pairing Code',
                      value: serverState.pairingCode,
                      onCopy: () => _copyToClipboard(serverState.pairingCode),
                      valueStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Real-time status
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wifi_tethering, color: AppTheme.primaryGreen, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Real-time sync active • ${serverState.connectedClients} client(s) connected',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(lanServerProvider.notifier).regenerateCode();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('New pairing code generated')),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Generate New Code'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Instructions Card
            Card(
              color: Colors.blue.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'How to Connect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _InstructionStep(number: '1', text: 'Both devices must be on the same Wi-Fi'),
                    _InstructionStep(number: '2', text: 'Open the app on the Family device'),
                    _InstructionStep(number: '3', text: 'Go to Sync > Connect to Server'),
                    _InstructionStep(number: '4', text: 'Enter the IP address and pairing code'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDevicesTab(LanServerState serverState) {
    final devices = serverState.devices;

    if (devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No devices connected yet',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'Start the server and share the pairing code',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(lanServerProvider.notifier).refreshDevices(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: device.isApproved
                    ? AppTheme.primaryGreen.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                child: Icon(
                  device.isApproved ? Icons.phone_android : Icons.phone_android,
                  color: device.isApproved ? AppTheme.primaryGreen : Colors.orange,
                ),
              ),
              title: Text(
                device.deviceName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.deviceIp),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StatusBadge(status: device.status),
                      const SizedBox(width: 8),
                      if (device.lastSynced != null)
                        Text(
                          'Last sync: ${Helpers.timeAgo(device.lastSynced!)}',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'approve':
                      ref
                          .read(lanServerProvider.notifier)
                          .setDeviceApproval(device.id!, true);
                      break;
                    case 'revoke':
                      ref
                          .read(lanServerProvider.notifier)
                          .setDeviceApproval(device.id!, false);
                      break;
                    case 'remove':
                      _confirmRemoveDevice(device.id!, device.deviceName);
                      break;
                  }
                },
                itemBuilder: (_) => [
                  if (!device.isApproved)
                    const PopupMenuItem(
                      value: 'approve',
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 18),
                          SizedBox(width: 8),
                          Text('Approve'),
                        ],
                      ),
                    ),
                  if (device.isApproved)
                    const PopupMenuItem(
                      value: 'revoke',
                      child: Row(
                        children: [
                          Icon(Icons.block, color: Colors.orange, size: 18),
                          SizedBox(width: 8),
                          Text('Revoke Access'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text('Remove', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSyncLogTab(LanServerState serverState) {
    final logs = serverState.syncLogs;

    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sync, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No sync activity yet',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: log.status == 'success'
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              child: Icon(
                log.status == 'success' ? Icons.check : Icons.error,
                color: log.status == 'success' ? Colors.green : Colors.red,
                size: 20,
              ),
            ),
            title: Text(
              '${log.deviceName} - ${log.syncType}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              '${log.itemsSynced} items • ${Helpers.formatDateTime(log.syncedAt)}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard'), duration: Duration(seconds: 1)),
    );
  }

  void _confirmRemoveDevice(int id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Device'),
        content: Text('Remove "$name" from connected devices?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(lanServerProvider.notifier).removeDevice(id);
              Navigator.pop(ctx);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onCopy;
  final TextStyle? valueStyle;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onCopy,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(height: 2),
              Text(value, style: valueStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (onCopy != null)
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            onPressed: onCopy,
            tooltip: 'Copy',
          ),
      ],
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.blue.shade100,
            child: Text(number, style: TextStyle(fontSize: 11, color: Colors.blue.shade700)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case 'connected':
        color = Colors.green;
        label = 'Connected';
        break;
      case 'syncing':
        color = Colors.blue;
        label = 'Syncing';
        break;
      default:
        color = Colors.grey;
        label = 'Offline';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
