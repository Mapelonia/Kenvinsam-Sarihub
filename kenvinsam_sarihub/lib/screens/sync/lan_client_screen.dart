import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/sync_provider.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class LanClientScreen extends ConsumerStatefulWidget {
  const LanClientScreen({super.key});

  @override
  ConsumerState<LanClientScreen> createState() => _LanClientScreenState();
}

class _LanClientScreenState extends ConsumerState<LanClientScreen> {
  final _ipController = TextEditingController();
  final _portController = TextEditingController(text: '8642');
  final _codeController = TextEditingController();
  final _deviceNameController = TextEditingController(text: 'Family Device');
  bool _isConnecting = false;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    final clientState = ref.read(lanClientProvider);
    if (clientState.serverIp != null) {
      _ipController.text = clientState.serverIp!;
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _codeController.dispose();
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientState = ref.watch(lanClientProvider);

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text(
          'Sync with Admin',
          style: AppTheme.headingMd.copyWith(color: context.textPrimary),
        ),
=======
        title: const Text('Sync with Admin'),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Connection Status Card
            _buildStatusCard(clientState),
            const SizedBox(height: 16),

            if (!clientState.isPaired) ...[
              // Connection Setup
              _buildConnectionSetup(clientState),
            ] else ...[
              // Sync Controls
              _buildSyncControls(clientState),
              const SizedBox(height: 16),
              // Disconnect option
              _buildDisconnectCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(LanClientState clientState) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (clientState.status) {
      case 'connected':
        statusColor = Colors.green;
        statusIcon = Icons.wifi;
        statusText = clientState.isRealtimeConnected ? 'Live Connected' : 'Connected';
        break;
      case 'syncing':
        statusColor = Colors.blue;
        statusIcon = Icons.sync;
        statusText = 'Syncing...';
        break;
      case 'reconnecting':
        statusColor = Colors.orange;
        statusIcon = Icons.sync_problem;
        statusText = 'Reconnecting...';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.wifi_off;
        statusText = 'Offline';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(statusIcon, size: 48, color: statusColor),
                if (clientState.isRealtimeConnected)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.bolt, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            if (clientState.isRealtimeConnected) ...[
              const SizedBox(height: 4),
              Text(
                'Real-time updates active',
                style: TextStyle(color: Colors.green.shade600, fontSize: 12),
              ),
            ],
            if (clientState.isPaired && clientState.serverIp != null) ...[
              const SizedBox(height: 4),
              Text(
                'Server: ${clientState.serverIp}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
            if (clientState.lastSynced != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Last synced: ${Helpers.timeAgo(clientState.lastSynced!)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
            ],
            if (clientState.lastSyncMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                clientState.lastSyncMessage!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionSetup(LanClientState clientState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connect to Admin Server',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Enter the connection details shown on the Admin device',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Device Name
            TextField(
              controller: _deviceNameController,
              decoration: const InputDecoration(
                labelText: 'Your Device Name',
                prefixIcon: Icon(Icons.phone_android),
                hintText: 'e.g. Razo Phone',
              ),
            ),
            const SizedBox(height: 12),

            // IP Address
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'Admin IP Address *',
                prefixIcon: Icon(Icons.wifi),
                hintText: '192.168.1.xxx',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // Port
            TextField(
              controller: _portController,
              decoration: const InputDecoration(
                labelText: 'Port',
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // Pairing Code
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Pairing Code *',
                prefixIcon: Icon(Icons.vpn_key),
                hintText: '6-digit code',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 16),

            // Test Connection Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isConnecting ? null : _testConnection,
                icon: _isConnecting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.wifi_find),
                label: const Text('Test Connection'),
              ),
            ),
            const SizedBox(height: 12),

            // Pair Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _isConnecting ? null : _pairWithServer,
                icon: _isConnecting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.link),
                label: const Text('Connect & Pair'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncControls(LanClientState clientState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Synchronization',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (clientState.isRealtimeConnected)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bolt, size: 12, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'LIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              clientState.isRealtimeConnected
                  ? 'Real-time sync active. Updates arrive automatically.'
                  : 'Pull the latest data from the Admin device',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Sync All Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _isSyncing ? null : _syncAll,
                icon: _isSyncing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.sync),
                label: Text(_isSyncing ? 'Syncing...' : 'Full Sync Now'),
              ),
            ),
            const SizedBox(height: 12),

            // Sync Products Only
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isSyncing ? null : _syncProducts,
                icon: const Icon(Icons.inventory_2),
                label: const Text('Refresh Products Only'),
              ),
            ),
            const SizedBox(height: 12),

            // Test Connection
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isConnecting ? null : () async {
                  final connected = await ref.read(lanClientProvider.notifier).pingServer();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(connected ? 'Server is reachable' : 'Cannot reach server'),
                        backgroundColor: connected ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.wifi_find),
                label: const Text('Test Connection'),
              ),
            ),

            // Recent notifications
            if (clientState.notifications.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () => ref.read(lanClientProvider.notifier).clearNotifications(),
                    child: const Text('Clear', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ...clientState.notifications.reversed.take(5).map((n) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 6, color: Colors.grey.shade400),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(n, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDisconnectCard() {
    return Card(
      color: Colors.red.withOpacity(0.02),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _confirmDisconnect,
                icon: const Icon(Icons.link_off, color: Colors.red),
                label: const Text('Disconnect from Server',
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testConnection() async {
    if (_ipController.text.isEmpty) {
      _showSnackBar('Please enter the Admin IP address', isError: true);
      return;
    }

    setState(() => _isConnecting = true);

    await ref.read(lanClientProvider.notifier).setServer(
          _ipController.text.trim(),
          port: int.tryParse(_portController.text) ?? 8642,
          deviceName: _deviceNameController.text.trim(),
        );

    final connected = await ref.read(lanClientProvider.notifier).pingServer();

    setState(() => _isConnecting = false);

    if (mounted) {
      _showSnackBar(
        connected ? 'Server found! You can now pair.' : 'Cannot reach server. Check IP and Wi-Fi.',
        isError: !connected,
      );
    }
  }

  Future<void> _pairWithServer() async {
    if (_ipController.text.isEmpty || _codeController.text.isEmpty) {
      _showSnackBar('Please enter IP address and pairing code', isError: true);
      return;
    }

    setState(() => _isConnecting = true);

    await ref.read(lanClientProvider.notifier).setServer(
          _ipController.text.trim(),
          port: int.tryParse(_portController.text) ?? 8642,
          deviceName: _deviceNameController.text.trim(),
        );

    final result = await ref.read(lanClientProvider.notifier).pair(_codeController.text.trim());

    setState(() => _isConnecting = false);

    if (mounted) {
      _showSnackBar(
        result['message'] as String,
        isError: result['success'] != true,
      );
    }
  }

  Future<void> _syncAll() async {
    setState(() => _isSyncing = true);

    final result = await ref.read(lanClientProvider.notifier).syncAll();

    setState(() => _isSyncing = false);

    // Refresh local product providers
    refreshProducts(ref);

    if (mounted) {
      _showSnackBar(
        result['message'] as String,
        isError: result['success'] != true,
      );
    }
  }

  Future<void> _syncProducts() async {
    setState(() => _isSyncing = true);

    final result = await ref.read(lanClientProvider.notifier).syncProducts();

    setState(() => _isSyncing = false);

    refreshProducts(ref);

    if (mounted) {
      _showSnackBar(
        result['message'] as String,
        isError: result['success'] != true,
      );
    }
  }

  void _confirmDisconnect() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Disconnect'),
        content: const Text('Disconnect from the Admin server? Your local data will be kept.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(lanClientProvider.notifier).disconnect();
              Navigator.pop(ctx);
            },
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
