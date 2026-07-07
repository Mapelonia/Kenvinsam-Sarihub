import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
<<<<<<< HEAD
=======
import 'package:path_provider/path_provider.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/connected_device.dart';
import 'package:kenvinsam_sarihub/services/realtime_sync_server.dart';

/// LAN HTTP + WebSocket Server that runs on the Admin device.
/// HTTP handles pairing and initial sync.
/// WebSocket handles real-time broadcasting.
class LanServerService {
  static final LanServerService instance = LanServerService._();
  LanServerService._();

  HttpServer? _server;
  bool _isRunning = false;
  String? _localIp;
  int _port = 8642;
  String _pairingCode = '';

  final RealtimeSyncServer _wsServer = RealtimeSyncServer.instance;

  bool get isRunning => _isRunning;
  String? get localIp => _localIp;
  int get port => _port;
  int get wsPort => _wsServer.wsPort;
  String get pairingCode => _pairingCode;
  String get serverAddress => '$_localIp:$_port';
  int get connectedClients => _wsServer.connectedClientCount;
  Stream<SyncMessage> get eventStream => _wsServer.eventStream;
  Stream<int> get clientCountStream => _wsServer.clientCountStream;

  /// Generate a 6-digit pairing code
  String _generatePairingCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  /// Get the device's local IP address
<<<<<<< HEAD
  /// Checks common LAN ranges: 192.168.x.x, 10.x.x.x, 172.16-31.x.x
  /// Prioritizes Wi-Fi interfaces (wlan) over mobile data (rmnet)
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Future<String?> getLocalIpAddress() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLinkLocal: false,
      );
<<<<<<< HEAD

      // Priority 1: Wi-Fi interface with 192.168.x.x
      for (final interface in interfaces) {
        final name = interface.name.toLowerCase();
        if (name.contains('wlan') || name.contains('wifi') || name.contains('en0')) {
          for (final addr in interface.addresses) {
            if (!addr.isLoopback && _isPrivateIp(addr.address)) {
              return addr.address;
            }
          }
        }
      }

      // Priority 2: Any interface with 192.168.x.x (common home Wi-Fi)
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback && addr.address.startsWith('192.168')) {
            return addr.address;
          }
        }
      }
<<<<<<< HEAD

      // Priority 3: Other private LAN ranges (10.x.x.x, 172.16-31.x.x)
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback && _isPrivateIp(addr.address)) {
            return addr.address;
          }
        }
      }

      // Priority 4: Any non-loopback address
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print('Error getting local IP: $e');
    }
    return null;
  }

<<<<<<< HEAD
  /// Check if an IP address is in a private/LAN range
  bool _isPrivateIp(String ip) {
    final parts = ip.split('.');
    if (parts.length != 4) return false;
    final first = int.tryParse(parts[0]) ?? 0;
    final second = int.tryParse(parts[1]) ?? 0;

    // 10.0.0.0 – 10.255.255.255
    if (first == 10) return true;
    // 172.16.0.0 – 172.31.255.255
    if (first == 172 && second >= 16 && second <= 31) return true;
    // 192.168.0.0 – 192.168.255.255
    if (first == 192 && second == 168) return true;
    return false;
  }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  /// Start both HTTP and WebSocket servers
  Future<bool> startServer() async {
    if (_isRunning) return true;

    try {
      _localIp = await getLocalIpAddress();
<<<<<<< HEAD
      if (_localIp == null) {
        print('Failed to get local IP address - not connected to Wi-Fi?');
        return false;
      }

      _pairingCode = _generatePairingCode();

      // Start HTTP server - bind to all interfaces so clients can reach us
      _server = await HttpServer.bind(InternetAddress.anyIPv4, _port, shared: true);
=======
      if (_localIp == null) return false;

      _pairingCode = _generatePairingCode();

      // Start HTTP server for pairing and manual sync
      _server = await HttpServer.bind(InternetAddress.anyIPv4, _port);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      _server!.listen(_handleRequest);

      // Start WebSocket server for real-time sync
      await _wsServer.startServer();

      _isRunning = true;
      print('LAN Server started at $_localIp:$_port (WS: ${_wsServer.wsPort}, Code: $_pairingCode)');
      return true;
    } catch (e) {
      print('Failed to start server: $e');
      _isRunning = false;
      return false;
    }
  }

  /// Stop both servers
  Future<void> stopServer() async {
    await _wsServer.stopServer();
    await _server?.close(force: true);
    _server = null;
    _isRunning = false;
    print('LAN Server stopped');
  }

  // ─── Real-time broadcast methods (called by product service) ───

  /// Broadcast product created
  Future<void> broadcastProductCreated(Map<String, dynamic> product) async {
    if (_isRunning) {
      await _wsServer.broadcastProductCreated(product);
    }
  }

  /// Broadcast product updated
  Future<void> broadcastProductUpdated(Map<String, dynamic> product) async {
    if (_isRunning) {
      await _wsServer.broadcastProductUpdated(product);
    }
  }

  /// Broadcast product deleted
  Future<void> broadcastProductDeleted(int productId) async {
    if (_isRunning) {
      await _wsServer.broadcastProductDeleted(productId);
    }
  }

  /// Broadcast price change
  Future<void> broadcastPriceChanged(Map<String, dynamic> product, Map<String, dynamic> priceHistory) async {
    if (_isRunning) {
      await _wsServer.broadcastPriceChanged(product, priceHistory);
    }
  }

  /// Broadcast stock update
  Future<void> broadcastStockUpdated(int productId, int newStock) async {
    if (_isRunning) {
      await _wsServer.broadcastStockUpdated(productId, newStock);
    }
  }

  /// Broadcast category update
  Future<void> broadcastCategoryUpdated() async {
    if (_isRunning) {
      final db = await DatabaseHelper.instance.database;
      final categories = await db.query('categories');
      await _wsServer.broadcastCategoryUpdated(categories);
    }
  }

  /// Broadcast image update
  Future<void> broadcastImageUpdated(int productId, String? imagePath) async {
    if (_isRunning) {
      await _wsServer.broadcastImageUpdated(productId, imagePath);
    }
  }

  // ─── HTTP Request Handlers ───

  Future<void> _handleRequest(HttpRequest request) async {
    request.response.headers.add('Access-Control-Allow-Origin', '*');
<<<<<<< HEAD
=======
    request.response.headers.add('Content-Type', 'application/json');
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

    final path = request.uri.path;
    final method = request.method;

    try {
      if (method == 'GET') {
        switch (path) {
          case '/ping':
<<<<<<< HEAD
            request.response.headers.set('Content-Type', 'application/json');
            await _handlePing(request);
            break;
          case '/sync/products':
            request.response.headers.set('Content-Type', 'application/json');
            await _handleSyncProducts(request);
            break;
          case '/sync/categories':
            request.response.headers.set('Content-Type', 'application/json');
            await _handleSyncCategories(request);
            break;
          case '/sync/all':
            request.response.headers.set('Content-Type', 'application/json');
            await _handleSyncAll(request);
            break;
          case '/sync/image':
            // _handleSyncImage manages its own response lifecycle (pipe or close)
            try {
              await _handleSyncImage(request);
            } catch (e) {
              // If piping failed, the response may already be closed — ignore
              print('Image sync error: $e');
            }
            return; // Don't close response again
          default:
            request.response.headers.set('Content-Type', 'application/json');
=======
            await _handlePing(request);
            break;
          case '/sync/products':
            await _handleSyncProducts(request);
            break;
          case '/sync/categories':
            await _handleSyncCategories(request);
            break;
          case '/sync/all':
            await _handleSyncAll(request);
            break;
          case '/sync/image':
            await _handleSyncImage(request);
            break;
          default:
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            request.response.statusCode = 404;
            request.response.write(jsonEncode({'error': 'Not found'}));
        }
      } else if (method == 'POST') {
<<<<<<< HEAD
        request.response.headers.set('Content-Type', 'application/json');
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        switch (path) {
          case '/pair':
            await _handlePairRequest(request);
            break;
          default:
            request.response.statusCode = 404;
            request.response.write(jsonEncode({'error': 'Not found'}));
        }
      } else {
<<<<<<< HEAD
        request.response.headers.set('Content-Type', 'application/json');
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        request.response.statusCode = 405;
        request.response.write(jsonEncode({'error': 'Method not allowed'}));
      }
    } catch (e) {
<<<<<<< HEAD
      request.response.headers.set('Content-Type', 'application/json');
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      request.response.statusCode = 500;
      request.response.write(jsonEncode({'error': 'Internal server error'}));
    }

    await request.response.close();
  }

  Future<void> _handlePing(HttpRequest request) async {
    request.response.write(jsonEncode({
      'status': 'ok',
      'app': 'Kenvinsam SariHub',
      'role': 'server',
      'ws_port': _wsServer.wsPort,
      'connected_clients': _wsServer.connectedClientCount,
      'timestamp': DateTime.now().toIso8601String(),
    }));
  }

  Future<void> _handlePairRequest(HttpRequest request) async {
    final body = await utf8.decoder.bind(request).join();
    final data = jsonDecode(body) as Map<String, dynamic>;

    final code = data['pairing_code'] as String?;
    final deviceName = data['device_name'] as String? ?? 'Unknown Device';
    final deviceIp = request.connectionInfo?.remoteAddress.address ?? 'unknown';

    if (code == null || code != _pairingCode) {
      request.response.statusCode = 403;
      request.response.write(jsonEncode({
        'error': 'Invalid pairing code',
        'paired': false,
      }));
      return;
    }

    final db = await DatabaseHelper.instance.database;
    final existing = await db.query(
      'connected_devices',
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );

    if (existing.isEmpty) {
      await db.insert('connected_devices', {
        'device_name': deviceName,
        'device_ip': deviceIp,
        'pairing_code': code,
        'is_approved': 1,
        'connected_at': DateTime.now().toIso8601String(),
        'status': 'connected',
      });
    } else {
      await db.update(
        'connected_devices',
        {'status': 'connected', 'is_approved': 1, 'device_name': deviceName},
        where: 'device_ip = ?',
        whereArgs: [deviceIp],
      );
    }

    request.response.write(jsonEncode({
      'paired': true,
      'message': 'Device paired successfully',
      'server_name': 'Kenvinsam SariHub Admin',
      'ws_port': _wsServer.wsPort,
    }));
  }

  Future<bool> _isDeviceApproved(HttpRequest request) async {
    final deviceIp = request.connectionInfo?.remoteAddress.address ?? '';
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'connected_devices',
      where: 'device_ip = ? AND is_approved = 1',
      whereArgs: [deviceIp],
    );
<<<<<<< HEAD
    if (results.isNotEmpty) return true;

    // Fallback: if only one device is registered and approved, update its IP
    // This handles DHCP IP changes between sessions
    final allApproved = await db.query(
      'connected_devices',
      where: 'is_approved = 1',
    );
    if (allApproved.length == 1) {
      await db.update(
        'connected_devices',
        {'device_ip': deviceIp},
        where: 'id = ?',
        whereArgs: [allApproved.first['id']],
      );
      return true;
    }

    return false;
=======
    return results.isNotEmpty;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  Future<void> _handleSyncProducts(HttpRequest request) async {
    if (!await _isDeviceApproved(request)) {
      request.response.statusCode = 403;
      request.response.write(jsonEncode({'error': 'Device not approved'}));
      return;
    }

    final db = await DatabaseHelper.instance.database;
    final products = await db.query('products');
    final deviceIp = request.connectionInfo?.remoteAddress.address ?? '';

    await db.update(
      'connected_devices',
      {'status': 'syncing', 'last_synced': DateTime.now().toIso8601String()},
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );

    await _logSync(deviceIp, 'products', products.length, 'success');

    await db.update(
      'connected_devices',
      {'status': 'connected'},
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );

    request.response.write(jsonEncode({
      'products': products,
      'count': products.length,
      'synced_at': DateTime.now().toIso8601String(),
    }));
  }

  Future<void> _handleSyncCategories(HttpRequest request) async {
    if (!await _isDeviceApproved(request)) {
      request.response.statusCode = 403;
      request.response.write(jsonEncode({'error': 'Device not approved'}));
      return;
    }

    final db = await DatabaseHelper.instance.database;
    final categories = await db.query('categories');
    final deviceIp = request.connectionInfo?.remoteAddress.address ?? '';
    await _logSync(deviceIp, 'categories', categories.length, 'success');

    request.response.write(jsonEncode({
      'categories': categories,
      'count': categories.length,
      'synced_at': DateTime.now().toIso8601String(),
    }));
  }

  Future<void> _handleSyncAll(HttpRequest request) async {
    if (!await _isDeviceApproved(request)) {
      request.response.statusCode = 403;
      request.response.write(jsonEncode({'error': 'Device not approved'}));
      return;
    }

    final db = await DatabaseHelper.instance.database;
    final products = await db.query('products');
    final categories = await db.query('categories');
    final priceHistory = await db.query('price_history', orderBy: 'changed_at DESC', limit: 50);
    final electricUnits = await db.query('electric_units');
    final electricBills = await db.query('electric_bill_history', orderBy: 'created_at DESC');
    final deviceIp = request.connectionInfo?.remoteAddress.address ?? '';

    await db.update(
      'connected_devices',
      {'status': 'syncing', 'last_synced': DateTime.now().toIso8601String()},
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );

    final totalItems = products.length + categories.length +
        electricUnits.length + electricBills.length;
    await _logSync(deviceIp, 'full_sync', totalItems, 'success');

    await db.update(
      'connected_devices',
      {'status': 'connected'},
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );

    request.response.write(jsonEncode({
      'products': products,
      'categories': categories,
      'price_history': priceHistory,
      'electric_units': electricUnits,
      'electric_bills': electricBills,
      'synced_at': DateTime.now().toIso8601String(),
      'total_items': totalItems,
    }));
  }

  Future<void> _handleSyncImage(HttpRequest request) async {
    if (!await _isDeviceApproved(request)) {
<<<<<<< HEAD
      request.response.headers.set('Content-Type', 'application/json');
      request.response.statusCode = 403;
      request.response.write(jsonEncode({'error': 'Device not approved'}));
      await request.response.close();
=======
      request.response.statusCode = 403;
      request.response.write(jsonEncode({'error': 'Device not approved'}));
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      return;
    }

    final imagePath = request.uri.queryParameters['path'];
    if (imagePath == null || imagePath.isEmpty) {
<<<<<<< HEAD
      request.response.headers.set('Content-Type', 'application/json');
      request.response.statusCode = 400;
      request.response.write(jsonEncode({'error': 'No image path provided'}));
      await request.response.close();
=======
      request.response.statusCode = 400;
      request.response.write(jsonEncode({'error': 'No image path provided'}));
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      return;
    }

    final file = File(imagePath);
    if (!await file.exists()) {
<<<<<<< HEAD
      request.response.headers.set('Content-Type', 'application/json');
      request.response.statusCode = 404;
      request.response.write(jsonEncode({'error': 'Image not found'}));
      await request.response.close();
      return;
    }

    // Determine content type from extension
    final ext = imagePath.toLowerCase().split('.').last;
    final contentType = ext == 'png' ? 'image/png' : 'image/jpeg';
    request.response.headers.set('Content-Type', contentType);
    request.response.headers.set('Content-Length', '${await file.length()}');
    await file.openRead().pipe(request.response);
    // pipe() closes the response automatically
=======
      request.response.statusCode = 404;
      request.response.write(jsonEncode({'error': 'Image not found'}));
      return;
    }

    request.response.headers.set('Content-Type', 'image/jpeg');
    await file.openRead().pipe(request.response);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  Future<void> _logSync(String deviceIp, String syncType, int itemCount, String status) async {
    final db = await DatabaseHelper.instance.database;
    final devices = await db.query(
      'connected_devices',
      where: 'device_ip = ?',
      whereArgs: [deviceIp],
    );
    final deviceName = devices.isNotEmpty ? devices.first['device_name'] as String : 'Unknown';

    await db.insert('sync_log', {
      'device_name': deviceName,
      'device_ip': deviceIp,
      'sync_type': syncType,
      'items_synced': itemCount,
      'status': status,
      'synced_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<ConnectedDevice>> getConnectedDevices() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('connected_devices', orderBy: 'connected_at DESC');
    return results.map((m) => ConnectedDevice.fromMap(m)).toList();
  }

  Future<List<SyncLog>> getSyncLogs({int limit = 50}) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('sync_log', orderBy: 'synced_at DESC', limit: limit);
    return results.map((m) => SyncLog.fromMap(m)).toList();
  }

  Future<void> removeDevice(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('connected_devices', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> setDeviceApproval(int id, bool approved) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'connected_devices',
      {'is_approved': approved ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void regeneratePairingCode() {
    _pairingCode = _generatePairingCode();
  }
}
