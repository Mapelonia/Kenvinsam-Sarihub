import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/services/realtime_sync_client.dart';
<<<<<<< HEAD
=======
import 'package:kenvinsam_sarihub/services/realtime_sync_client.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

/// LAN HTTP Client + WebSocket Client for Family devices.
/// HTTP handles pairing and manual sync.
/// WebSocket handles real-time automatic updates.
class LanClientService {
  static final LanClientService instance = LanClientService._();
  LanClientService._();

  static const String _keyServerIp = 'lan_server_ip';
  static const String _keyServerPort = 'lan_server_port';
  static const String _keyWsPort = 'lan_ws_port';
  static const String _keyDeviceName = 'lan_device_name';
  static const String _keyIsPaired = 'lan_is_paired';
  static const String _keyLastSynced = 'lan_last_synced';

  String? _serverIp;
  int _serverPort = 8642;
  int _wsPort = 8643;
  String? _deviceName;
  bool _isPaired = false;
  DateTime? _lastSynced;
  String _status = 'offline';

  final RealtimeSyncClient _wsClient = RealtimeSyncClient.instance;

  String? get serverIp => _serverIp;
  int get serverPort => _serverPort;
  int get wsPort => _wsPort;
  String? get deviceName => _deviceName;
  bool get isPaired => _isPaired;
  DateTime? get lastSynced => _lastSynced;
  String get status => _wsClient.isConnected ? 'connected' : _status;
  String get serverAddress => '$_serverIp:$_serverPort';
  bool get isRealtimeConnected => _wsClient.isConnected;

  // Expose WebSocket streams
  Stream<String> get statusStream => _wsClient.statusStream;
  Stream<String> get notificationStream => _wsClient.notificationStream;

  /// Load saved connection settings
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _serverIp = prefs.getString(_keyServerIp);
    _serverPort = prefs.getInt(_keyServerPort) ?? 8642;
    _wsPort = prefs.getInt(_keyWsPort) ?? 8643;
    _deviceName = prefs.getString(_keyDeviceName) ?? 'Family Device';
    _isPaired = prefs.getBool(_keyIsPaired) ?? false;
    final lastSyncedStr = prefs.getString(_keyLastSynced);
    if (lastSyncedStr != null) {
      _lastSynced = DateTime.parse(lastSyncedStr);
    }

    // Auto-connect WebSocket if previously paired
    if (_isPaired && _serverIp != null) {
      _connectWebSocket();
    }
  }

  /// Save connection settings
  Future<void> saveSettings({
    required String serverIp,
    int? serverPort,
    int? wsPort,
    String? deviceName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    _serverIp = serverIp;
    if (serverPort != null) _serverPort = serverPort;
    if (wsPort != null) _wsPort = wsPort;
    if (deviceName != null) _deviceName = deviceName;

    await prefs.setString(_keyServerIp, _serverIp!);
    await prefs.setInt(_keyServerPort, _serverPort);
    await prefs.setInt(_keyWsPort, _wsPort);
    await prefs.setString(_keyDeviceName, _deviceName!);
  }

  /// Connect to WebSocket for real-time updates
  Future<bool> _connectWebSocket() async {
    if (_serverIp == null) return false;
    return await _wsClient.connect(_serverIp!, port: _wsPort);
  }

  /// Ping the server to check connection
  Future<bool> pingServer() async {
    if (_serverIp == null) return false;

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 5);
      final request = await client.getUrl(
        Uri.parse('http://$_serverIp:$_serverPort/ping'),
      );
<<<<<<< HEAD
      final response = await request.close().timeout(const Duration(seconds: 8));
=======
      final response = await request.close();
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      client.close();

      if (data['status'] == 'ok') {
        _status = 'connected';
        // Get WebSocket port from server
        if (data['ws_port'] != null) {
          _wsPort = data['ws_port'] as int;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt(_keyWsPort, _wsPort);
        }
        return true;
      }
    } catch (e) {
      _status = 'offline';
<<<<<<< HEAD
      print('Ping failed: $e');
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    }
    return false;
  }

  /// Pair with the admin server using a pairing code
  Future<Map<String, dynamic>> pairWithServer(String pairingCode) async {
    if (_serverIp == null) {
      return {'success': false, 'message': 'Server IP not set'};
    }

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 10);
      final request = await client.postUrl(
        Uri.parse('http://$_serverIp:$_serverPort/pair'),
      );
      request.headers.set('Content-Type', 'application/json');
      request.write(jsonEncode({
        'pairing_code': pairingCode,
        'device_name': _deviceName ?? 'Family Device',
      }));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      client.close();

      if (data['paired'] == true) {
        _isPaired = true;
        _status = 'connected';

        // Get WebSocket port
        if (data['ws_port'] != null) {
          _wsPort = data['ws_port'] as int;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_keyIsPaired, true);
        await prefs.setInt(_keyWsPort, _wsPort);

        // Connect WebSocket for real-time updates
        await _connectWebSocket();

        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'message': data['error'] ?? 'Pairing failed'};
      }
<<<<<<< HEAD
    } on SocketException catch (e) {
      return {
        'success': false,
        'message': 'Cannot reach server at $_serverIp:$_serverPort. '
            'Make sure both devices are on the same Wi-Fi network and the server is running. '
            '(${e.message})',
      };
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    } catch (e) {
      return {'success': false, 'message': 'Connection failed: $e'};
    }
  }

  /// Sync all data from the admin server (manual/initial sync via HTTP)
  Future<Map<String, dynamic>> syncAll() async {
    if (_serverIp == null || !_isPaired) {
      return {'success': false, 'message': 'Not connected or paired'};
    }

    _status = 'syncing';

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 30);
      final request = await client.getUrl(
        Uri.parse('http://$_serverIp:$_serverPort/sync/all'),
      );
      final response = await request.close();

      if (response.statusCode == 403) {
        _status = 'offline';
        client.close();
        return {'success': false, 'message': 'Device not approved by admin'};
      }

      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      client.close();

      await _applySyncData(data);

      _lastSynced = DateTime.now();
      _status = 'connected';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyLastSynced, _lastSynced!.toIso8601String());

      // Ensure WebSocket is connected for real-time updates
      if (!_wsClient.isConnected) {
        await _connectWebSocket();
      }

      return {
        'success': true,
        'message': 'Synced ${data['total_items']} items',
        'total_items': data['total_items'],
        'synced_at': _lastSynced!.toIso8601String(),
      };
    } catch (e) {
      _status = 'offline';
      return {'success': false, 'message': 'Sync failed: $e'};
    }
  }

  /// Sync only products via HTTP
  Future<Map<String, dynamic>> syncProducts() async {
    if (_serverIp == null || !_isPaired) {
      return {'success': false, 'message': 'Not connected or paired'};
    }

    _status = 'syncing';

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 15);
      final request = await client.getUrl(
        Uri.parse('http://$_serverIp:$_serverPort/sync/products'),
      );
      final response = await request.close();

      if (response.statusCode == 403) {
        _status = 'offline';
        client.close();
        return {'success': false, 'message': 'Device not approved'};
      }

      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      client.close();

      final products = data['products'] as List<dynamic>;
      await _syncProducts(products);

      _lastSynced = DateTime.now();
      _status = 'connected';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyLastSynced, _lastSynced!.toIso8601String());

      return {
        'success': true,
        'message': 'Synced ${products.length} products',
        'count': products.length,
      };
    } catch (e) {
      _status = 'offline';
      return {'success': false, 'message': 'Sync failed: $e'};
    }
  }

  /// Request full sync via WebSocket (real-time)
  void requestRealtimeFullSync() {
    _wsClient.requestFullSync();
  }

  /// Download a product image from the server
  Future<String?> syncImage(String remotePath) async {
    if (_serverIp == null || !_isPaired) return null;

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 10);
      final uri = Uri.parse(
        'http://$_serverIp:$_serverPort/sync/image?path=${Uri.encodeComponent(remotePath)}',
      );
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode != 200) {
        client.close();
        return null;
      }

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'synced_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final localFile = File('${appDir.path}/$fileName');
      await response.pipe(localFile.openWrite());
      client.close();

      return localFile.path;
    } catch (e) {
      return null;
    }
  }

  /// Apply full sync data to local database
  Future<void> _applySyncData(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;

    await db.transaction((txn) async {
      if (data['products'] != null) {
        final products = data['products'] as List<dynamic>;
        await txn.delete('products');
        for (final p in products) {
          await txn.insert('products', Map<String, dynamic>.from(p as Map));
        }
      }

      if (data['categories'] != null) {
        final categories = data['categories'] as List<dynamic>;
        await txn.delete('categories');
        for (final cat in categories) {
          await txn.insert('categories', Map<String, dynamic>.from(cat as Map));
        }
      }

      // Merge electric units from Admin
      if (data['electric_units'] != null) {
        final units = data['electric_units'] as List<dynamic>;
        for (final u in units) {
          final unitMap = Map<String, dynamic>.from(u as Map);
          final existing = await txn.query('electric_units',
              where: 'id = ?', whereArgs: [unitMap['id']]);
          if (existing.isEmpty) {
            await txn.insert('electric_units', unitMap);
          }
        }
      }

      // Merge electric bills from Admin (don't replace local ones)
      if (data['electric_bills'] != null) {
        final bills = data['electric_bills'] as List<dynamic>;
        for (final b in bills) {
          final billMap = Map<String, dynamic>.from(b as Map);
          final existing = await txn.query('electric_bill_history',
              where: 'id = ?', whereArgs: [billMap['id']]);
          if (existing.isEmpty) {
            await txn.insert('electric_bill_history', billMap);
          }
        }
      }
    });

    // Push our local electric bills back to Admin
    RealtimeSyncClient.instance.pushElectricBillsNow();
  }

  /// Sync products to local database
  Future<void> _syncProducts(List<dynamic> products) async {
    final db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      await txn.delete('products');
      for (final product in products) {
        await txn.insert('products', Map<String, dynamic>.from(product as Map));
      }
    });
  }

  /// Disconnect from server (both HTTP and WebSocket)
  Future<void> disconnect() async {
    await _wsClient.disconnect();
    _isPaired = false;
    _status = 'offline';
    _serverIp = null;
    _lastSynced = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyServerIp);
    await prefs.remove(_keyServerPort);
    await prefs.remove(_keyWsPort);
    await prefs.remove(_keyIsPaired);
    await prefs.remove(_keyLastSynced);
  }
}
