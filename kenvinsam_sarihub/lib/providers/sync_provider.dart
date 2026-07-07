import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/services/lan_server_service.dart';
import 'package:kenvinsam_sarihub/services/lan_client_service.dart';
import 'package:kenvinsam_sarihub/services/realtime_sync_server.dart';
import 'package:kenvinsam_sarihub/models/connected_device.dart';

// ─── Server Provider (Admin) ───

final lanServerProvider = StateNotifierProvider<LanServerNotifier, LanServerState>((ref) {
  return LanServerNotifier();
});

class LanServerState {
  final bool isRunning;
  final String? localIp;
  final int port;
  final int wsPort;
  final String pairingCode;
  final int connectedClients;
  final List<ConnectedDevice> devices;
  final List<SyncLog> syncLogs;
  final List<String> recentEvents;

  LanServerState({
    this.isRunning = false,
    this.localIp,
    this.port = 8642,
    this.wsPort = 8643,
    this.pairingCode = '',
    this.connectedClients = 0,
    this.devices = const [],
    this.syncLogs = const [],
    this.recentEvents = const [],
  });

  LanServerState copyWith({
    bool? isRunning,
    String? localIp,
    int? port,
    int? wsPort,
    String? pairingCode,
    int? connectedClients,
    List<ConnectedDevice>? devices,
    List<SyncLog>? syncLogs,
    List<String>? recentEvents,
  }) {
    return LanServerState(
      isRunning: isRunning ?? this.isRunning,
      localIp: localIp ?? this.localIp,
      port: port ?? this.port,
      wsPort: wsPort ?? this.wsPort,
      pairingCode: pairingCode ?? this.pairingCode,
      connectedClients: connectedClients ?? this.connectedClients,
      devices: devices ?? this.devices,
      syncLogs: syncLogs ?? this.syncLogs,
      recentEvents: recentEvents ?? this.recentEvents,
    );
  }
}

class LanServerNotifier extends StateNotifier<LanServerState> {
  LanServerNotifier() : super(LanServerState());

  final _server = LanServerService.instance;
  StreamSubscription? _eventSub;
  StreamSubscription? _clientCountSub;

  Future<bool> startServer() async {
    final success = await _server.startServer();
    if (success) {
      state = state.copyWith(
        isRunning: true,
        localIp: _server.localIp,
        port: _server.port,
        wsPort: _server.wsPort,
        pairingCode: _server.pairingCode,
      );
      await refreshDevices();

      // Listen for real-time events
      _eventSub = _server.eventStream.listen((event) {
        final events = [...state.recentEvents, '${event.event}: ${event.data}'];
        if (events.length > 20) events.removeRange(0, events.length - 20);
        state = state.copyWith(recentEvents: events);
      });

      // Listen for client count changes
      _clientCountSub = _server.clientCountStream.listen((count) {
        state = state.copyWith(connectedClients: count);
        refreshDevices();
      });
    }
    return success;
  }

  Future<void> stopServer() async {
    _eventSub?.cancel();
    _clientCountSub?.cancel();
    await _server.stopServer();
    state = state.copyWith(isRunning: false, connectedClients: 0);
  }

  Future<void> refreshDevices() async {
    final devices = await _server.getConnectedDevices();
    final logs = await _server.getSyncLogs();
    state = state.copyWith(
      devices: devices,
      syncLogs: logs,
      connectedClients: _server.connectedClients,
    );
  }

  Future<void> removeDevice(int id) async {
    await _server.removeDevice(id);
    await refreshDevices();
  }

  Future<void> setDeviceApproval(int id, bool approved) async {
    await _server.setDeviceApproval(id, approved);
    await refreshDevices();
  }

  void regenerateCode() {
    _server.regeneratePairingCode();
    state = state.copyWith(pairingCode: _server.pairingCode);
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    _clientCountSub?.cancel();
    super.dispose();
  }
}

// ─── Client Provider (Family) ───

final lanClientProvider = StateNotifierProvider<LanClientNotifier, LanClientState>((ref) {
  return LanClientNotifier();
});

class LanClientState {
  final String status; // 'connected', 'syncing', 'offline', 'reconnecting'
  final String? serverIp;
  final bool isPaired;
  final bool isRealtimeConnected;
  final DateTime? lastSynced;
  final String? lastSyncMessage;
  final List<String> notifications;

  LanClientState({
    this.status = 'offline',
    this.serverIp,
    this.isPaired = false,
    this.isRealtimeConnected = false,
    this.lastSynced,
    this.lastSyncMessage,
    this.notifications = const [],
  });

  LanClientState copyWith({
    String? status,
    String? serverIp,
    bool? isPaired,
    bool? isRealtimeConnected,
    DateTime? lastSynced,
    String? lastSyncMessage,
    List<String>? notifications,
  }) {
    return LanClientState(
      status: status ?? this.status,
      serverIp: serverIp ?? this.serverIp,
      isPaired: isPaired ?? this.isPaired,
      isRealtimeConnected: isRealtimeConnected ?? this.isRealtimeConnected,
      lastSynced: lastSynced ?? this.lastSynced,
      lastSyncMessage: lastSyncMessage ?? this.lastSyncMessage,
      notifications: notifications ?? this.notifications,
    );
  }
}

class LanClientNotifier extends StateNotifier<LanClientState> {
  LanClientNotifier() : super(LanClientState()) {
    _init();
  }

  final _client = LanClientService.instance;
  StreamSubscription? _statusSub;
  StreamSubscription? _notifSub;

  Future<void> _init() async {
<<<<<<< HEAD
    // Subscribe to streams FIRST, before loadSettings triggers auto-connect
=======
    await _client.loadSettings();
    state = state.copyWith(
      serverIp: _client.serverIp,
      isPaired: _client.isPaired,
      lastSynced: _client.lastSynced,
      status: _client.status,
      isRealtimeConnected: _client.isRealtimeConnected,
    );

    // Listen for real-time status changes
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    _statusSub = _client.statusStream.listen((status) {
      state = state.copyWith(
        status: status,
        isRealtimeConnected: status == 'connected',
      );
    });

    // Listen for sync notifications
    _notifSub = _client.notificationStream.listen((notification) {
      final notifs = [...state.notifications, notification];
      if (notifs.length > 30) notifs.removeRange(0, notifs.length - 30);
      state = state.copyWith(
        notifications: notifs,
        lastSyncMessage: notification,
        lastSynced: DateTime.now(),
      );
    });
<<<<<<< HEAD

    // Now load settings (which may trigger auto-connect via WebSocket)
    await _client.loadSettings();

    // Set initial state after settings are loaded
    state = state.copyWith(
      serverIp: _client.serverIp,
      isPaired: _client.isPaired,
      lastSynced: _client.lastSynced,
      status: _client.status,
      isRealtimeConnected: _client.isRealtimeConnected,
    );

    // If previously paired, give the WebSocket time to connect then update state
    if (_client.isPaired && _client.serverIp != null) {
      // Small delay to allow the auto-reconnect from loadSettings to complete
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        state = state.copyWith(
          status: _client.status,
          isRealtimeConnected: _client.isRealtimeConnected,
        );
      }
    }
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  Future<void> setServer(String ip, {int port = 8642, String? deviceName}) async {
    await _client.saveSettings(serverIp: ip, serverPort: port, deviceName: deviceName);
    state = state.copyWith(serverIp: ip);
  }

  Future<bool> pingServer() async {
    final connected = await _client.pingServer();
    state = state.copyWith(status: connected ? 'connected' : 'offline');
    return connected;
  }

  Future<Map<String, dynamic>> pair(String pairingCode) async {
    final result = await _client.pairWithServer(pairingCode);
    if (result['success'] == true) {
      state = state.copyWith(
        isPaired: true,
        status: 'connected',
        isRealtimeConnected: _client.isRealtimeConnected,
      );
    }
    return result;
  }

  Future<Map<String, dynamic>> syncAll() async {
    state = state.copyWith(status: 'syncing');
    final result = await _client.syncAll();
    state = state.copyWith(
      status: result['success'] == true ? 'connected' : 'offline',
      lastSynced: result['success'] == true ? DateTime.now() : state.lastSynced,
      lastSyncMessage: result['message'] as String?,
      isRealtimeConnected: _client.isRealtimeConnected,
    );
    return result;
  }

  Future<Map<String, dynamic>> syncProducts() async {
    state = state.copyWith(status: 'syncing');
    final result = await _client.syncProducts();
    state = state.copyWith(
      status: result['success'] == true ? 'connected' : 'offline',
      lastSynced: result['success'] == true ? DateTime.now() : state.lastSynced,
      lastSyncMessage: result['message'] as String?,
    );
    return result;
  }

  /// Request real-time full sync via WebSocket
  void requestRealtimeSync() {
    _client.requestRealtimeFullSync();
  }

  Future<void> disconnect() async {
    await _client.disconnect();
    state = LanClientState();
  }

  void clearNotifications() {
    state = state.copyWith(notifications: []);
  }

  @override
  void dispose() {
    _statusSub?.cancel();
    _notifSub?.cancel();
    super.dispose();
  }
}
