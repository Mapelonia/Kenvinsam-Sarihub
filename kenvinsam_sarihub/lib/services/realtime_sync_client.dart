import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/services/realtime_sync_server.dart';

/// Real-time WebSocket client running on Family devices.
/// Receives live updates from the Admin server automatically.
class RealtimeSyncClient {
  static final RealtimeSyncClient instance = RealtimeSyncClient._();
  RealtimeSyncClient._();

  WebSocket? _socket;
  String? _serverIp;
  int _wsPort = 8643;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 50;
  static const String _keyPendingUpdates = 'pending_sync_updates';
<<<<<<< HEAD
  DateTime _lastPingReceived = DateTime.now();
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  // Stream controllers for UI updates
  final _statusController = StreamController<String>.broadcast();
  final _eventController = StreamController<SyncMessage>.broadcast();
  final _notificationController = StreamController<String>.broadcast();

  Stream<String> get statusStream => _statusController.stream;
  Stream<SyncMessage> get eventStream => _eventController.stream;
  Stream<String> get notificationStream => _notificationController.stream;

  bool get isConnected => _isConnected;
  String get status => _isConnected ? 'connected' : 'offline';

  /// Connect to the Admin WebSocket server
  Future<bool> connect(String serverIp, {int port = 8643}) async {
    _serverIp = serverIp;
    _wsPort = port;
    _shouldReconnect = true;
    return await _doConnect();
  }

  /// Internal connect logic
  Future<bool> _doConnect() async {
    if (_serverIp == null) return false;

    try {
      _socket = await WebSocket.connect(
        'ws://$_serverIp:$_wsPort',
      ).timeout(const Duration(seconds: 10));

      _isConnected = true;
      _reconnectAttempts = 0;
      _statusController.add('connected');

      // Listen for messages
      _socket!.listen(
        _handleMessage,
        onDone: _handleDisconnect,
        onError: (_) => _handleDisconnect(),
      );

      // Start heartbeat response
      _startHeartbeatListener();

      // Sync any pending offline updates
      await _syncPendingUpdates();

      _notificationController.add('Connected to Admin server');
      print('WebSocket client connected to $_serverIp:$_wsPort');
      return true;
    } catch (e) {
      _isConnected = false;
      _statusController.add('offline');
      print('WebSocket connection failed: $e');
      _scheduleReconnect();
      return false;
    }
  }

  /// Handle incoming WebSocket message
  void _handleMessage(dynamic rawData) {
    try {
      final message = SyncMessage.fromJson(rawData as String);

      switch (message.event) {
        case SyncEvent.ping:
<<<<<<< HEAD
          // Respond with pong and track last ping time
          _lastPingReceived = DateTime.now();
=======
          // Respond with pong
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          _send(SyncMessage(event: SyncEvent.pong, data: {}));
          break;

        case SyncEvent.connected:
          _notificationController.add('Connected: ${message.data['message']}');
          break;

        case SyncEvent.productCreated:
          _handleProductCreated(message.data);
          break;

        case SyncEvent.productUpdated:
          _handleProductUpdated(message.data);
          break;

        case SyncEvent.productDeleted:
          _handleProductDeleted(message.data);
          break;

        case SyncEvent.priceChanged:
          _handlePriceChanged(message.data);
          break;

        case SyncEvent.stockUpdated:
          _handleStockUpdated(message.data);
          break;

        case SyncEvent.categoryUpdated:
          _handleCategoryUpdated(message.data);
          break;

        case SyncEvent.imageUpdated:
          _handleImageUpdated(message.data);
          break;

        case SyncEvent.fullSync:
          _handleFullSync(message.data);
          break;

        case SyncEvent.electricBillsSync:
          _handleElectricBillsSync(message.data);
          break;

        default:
          break;
      }

      _eventController.add(message);
    } catch (e) {
      print('Error handling message: $e');
    }
  }

  /// Handle product created event
  Future<void> _handleProductCreated(Map<String, dynamic> data) async {
    final product = data['product'] as Map<String, dynamic>?;
    if (product == null) return;

    final db = await DatabaseHelper.instance.database;
    final productMap = Map<String, dynamic>.from(product);

    // Check if product already exists (prevent duplicates)
    final existing = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productMap['id']],
    );

    if (existing.isEmpty) {
      await db.insert('products', productMap);
      _notificationController.add('New product: ${productMap['name']}');
    }
  }

  /// Handle product updated event with conflict resolution (latest timestamp wins)
  Future<void> _handleProductUpdated(Map<String, dynamic> data) async {
    final product = data['product'] as Map<String, dynamic>?;
    if (product == null) return;

    final db = await DatabaseHelper.instance.database;
    final productMap = Map<String, dynamic>.from(product);
    final productId = productMap['id'];

    // Conflict resolution: compare timestamps
    final existing = await db.query('products', where: 'id = ?', whereArgs: [productId]);
    if (existing.isNotEmpty) {
      final localUpdatedAt = DateTime.parse(existing.first['updated_at'] as String);
      final remoteUpdatedAt = DateTime.parse(productMap['updated_at'] as String);

      // Only apply if remote is newer (latest timestamp wins)
      if (remoteUpdatedAt.isAfter(localUpdatedAt)) {
        await db.update('products', productMap, where: 'id = ?', whereArgs: [productId]);
        _notificationController.add('Updated: ${productMap['name']}');
      }
    } else {
      // Product doesn't exist locally, insert it
      await db.insert('products', productMap);
      _notificationController.add('New product synced: ${productMap['name']}');
    }
  }

  /// Handle product deleted event
  Future<void> _handleProductDeleted(Map<String, dynamic> data) async {
    final productId = data['product_id'];
    if (productId == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.delete('products', where: 'id = ?', whereArgs: [productId]);
    _notificationController.add('Product removed');
  }

<<<<<<< HEAD
  /// Handle price changed event (with conflict resolution)
=======
  /// Handle price changed event
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Future<void> _handlePriceChanged(Map<String, dynamic> data) async {
    final product = data['product'] as Map<String, dynamic>?;
    if (product == null) return;

    final db = await DatabaseHelper.instance.database;
    final productMap = Map<String, dynamic>.from(product);
    final productId = productMap['id'];

<<<<<<< HEAD
    // Conflict resolution: only apply if remote is newer
    final existing = await db.query('products', where: 'id = ?', whereArgs: [productId]);
    if (existing.isNotEmpty) {
      final localUpdatedAt = DateTime.parse(existing.first['updated_at'] as String);
      final remoteUpdatedAt = DateTime.parse(productMap['updated_at'] as String);

      if (remoteUpdatedAt.isAfter(localUpdatedAt)) {
        await db.update('products', productMap, where: 'id = ?', whereArgs: [productId]);
        _notificationController.add('Price updated: ${productMap['name']}');
      }
    } else {
      // Product doesn't exist locally, insert it
      await db.insert('products', productMap);
      _notificationController.add('New product synced: ${productMap['name']}');
    }
  }

  /// Handle stock updated event (legacy — stock was removed, ignore gracefully)
  Future<void> _handleStockUpdated(Map<String, dynamic> data) async {
    // stock_quantity column was removed in database migration v2.
    // This handler is kept as a no-op to avoid errors if an older
    // server still sends this event type.
=======
    await db.update('products', productMap, where: 'id = ?', whereArgs: [productId]);
    _notificationController.add('Price updated: ${productMap['name']}');
  }

  /// Handle stock updated event
  Future<void> _handleStockUpdated(Map<String, dynamic> data) async {
    final productId = data['product_id'];
    final newStock = data['stock_quantity'];
    if (productId == null || newStock == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.update(
      'products',
      {'stock_quantity': newStock, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [productId],
    );
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  /// Handle category updated event
  Future<void> _handleCategoryUpdated(Map<String, dynamic> data) async {
    final categories = data['categories'] as List<dynamic>?;
    if (categories == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      await txn.delete('categories');
      for (final cat in categories) {
        await txn.insert('categories', Map<String, dynamic>.from(cat as Map));
      }
    });
    _notificationController.add('Categories updated');
  }

  /// Handle image updated event
  Future<void> _handleImageUpdated(Map<String, dynamic> data) async {
    final productId = data['product_id'];
    final imagePath = data['image_path'];
    if (productId == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.update(
      'products',
      {'image_path': imagePath, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  /// Handle full sync response — now includes electric bills
  Future<void> _handleFullSync(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;

    await db.transaction((txn) async {
      // Sync products
      if (data['products'] != null) {
        final products = data['products'] as List<dynamic>;
        await txn.delete('products');
        for (final p in products) {
          await txn.insert('products', Map<String, dynamic>.from(p as Map));
        }
      }

      // Sync categories
      if (data['categories'] != null) {
        final categories = data['categories'] as List<dynamic>;
        await txn.delete('categories');
        for (final c in categories) {
          await txn.insert('categories', Map<String, dynamic>.from(c as Map));
        }
      }

      // Sync electric units from Admin
      if (data['electric_units'] != null) {
        final units = data['electric_units'] as List<dynamic>;
        for (final u in units) {
          final unitMap = Map<String, dynamic>.from(u as Map);
          final existing = await txn.query(
            'electric_units',
            where: 'id = ?',
            whereArgs: [unitMap['id']],
          );
          if (existing.isEmpty) {
            await txn.insert('electric_units', unitMap);
          }
        }
      }

      // Sync electric bills from Admin (merge, don't replace)
      if (data['electric_bills'] != null) {
        final bills = data['electric_bills'] as List<dynamic>;
        for (final b in bills) {
          final billMap = Map<String, dynamic>.from(b as Map);
          final existing = await txn.query(
            'electric_bill_history',
            where: 'id = ?',
            whereArgs: [billMap['id']],
          );
          if (existing.isEmpty) {
            await txn.insert('electric_bill_history', billMap);
          }
        }
      }
    });

    final total = data['total_items'] ?? 0;
    _notificationController.add('Full sync complete: $total items');

    // After receiving from Admin, push our local electric bills back up
    await _pushElectricBillsToAdmin();

    // Save last synced time
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lan_last_synced', DateTime.now().toIso8601String());
  }

  /// Push Family's electric bills and units up to Admin
  Future<void> _pushElectricBillsToAdmin() async {
    final db = await DatabaseHelper.instance.database;
    final bills = await db.query('electric_bill_history');
    final units = await db.query('electric_units');

    if (units.isNotEmpty) {
      _send(SyncMessage(
        event: SyncEvent.electricUnitsPush,
        data: {'units': units},
      ));
    }

    if (bills.isNotEmpty) {
      _send(SyncMessage(
        event: SyncEvent.electricBillsPush,
        data: {'bills': bills},
      ));
      _notificationController.add('Pushed ${bills.length} electric bill(s) to Admin');
    }
  }

  /// Manually push electric bills to Admin (call after adding a new bill)
  void pushElectricBillsNow() {
    _pushElectricBillsToAdmin();
  }

  /// Handle electric bills sync pushed down from Admin
  Future<void> _handleElectricBillsSync(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;
    final bills = data['bills'] as List<dynamic>?;
    final units = data['units'] as List<dynamic>?;

    await db.transaction((txn) async {
      if (units != null) {
        for (final u in units) {
          final unitMap = Map<String, dynamic>.from(u as Map);
          final existing = await txn.query('electric_units',
              where: 'id = ?', whereArgs: [unitMap['id']]);
          if (existing.isEmpty) {
            await txn.insert('electric_units', unitMap);
          }
        }
      }
      if (bills != null) {
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

    _notificationController.add('Electric bills synced from Admin');
  }

  /// Request a full sync from the server
  void requestFullSync() {
    _send(SyncMessage(event: SyncEvent.fullSync, data: {}));
  }

  /// Handle WebSocket disconnect
  void _handleDisconnect() {
    _isConnected = false;
    _statusController.add('offline');
    _socket = null;
    _notificationController.add('Disconnected from server');

    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  /// Schedule automatic reconnection with exponential backoff
  void _scheduleReconnect() {
    if (!_shouldReconnect || _reconnectAttempts >= _maxReconnectAttempts) return;

    _reconnectTimer?.cancel();

    // Exponential backoff: 2s, 4s, 8s, 16s, max 30s
    final delay = Duration(
      seconds: (2 * (1 << _reconnectAttempts.clamp(0, 4))).clamp(2, 30),
    );

    _reconnectTimer = Timer(delay, () async {
      _reconnectAttempts++;
      _statusController.add('reconnecting');
      _notificationController.add('Reconnecting... (attempt $_reconnectAttempts)');
      await _doConnect();
    });
  }

<<<<<<< HEAD
  /// Start heartbeat listener — detect if server stopped sending pings
  void _startHeartbeatListener() {
    _heartbeatTimer?.cancel();
    _lastPingReceived = DateTime.now();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!_isConnected) return;
      // The server sends pings every 15s. If we haven't received one in 45s,
      // the connection is likely dead.
      final elapsed = DateTime.now().difference(_lastPingReceived);
      if (elapsed.inSeconds > 45) {
        print('Heartbeat timeout - no ping from server in ${elapsed.inSeconds}s');
        _handleDisconnect();
      }
=======
  /// Start heartbeat listener
  void _startHeartbeatListener() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!_isConnected) return;
      // If we haven't received a ping in 30s, connection might be dead
      // The server sends pings every 15s, so this is a safety check
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    });
  }

  /// Send a message to the server
  void _send(SyncMessage message) {
    try {
      if (_socket != null && _socket!.readyState == WebSocket.open) {
        _socket!.add(message.toJson());
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  /// Store pending update for offline sync
  Future<void> addPendingUpdate(SyncMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final pending = prefs.getStringList(_keyPendingUpdates) ?? [];
    pending.add(message.toJson());
    await prefs.setStringList(_keyPendingUpdates, pending);
  }

  /// Sync pending updates after reconnection
  Future<void> _syncPendingUpdates() async {
    final prefs = await SharedPreferences.getInstance();
    final pending = prefs.getStringList(_keyPendingUpdates) ?? [];

    if (pending.isEmpty) return;

    // Request full sync to get latest state
    requestFullSync();

    // Clear pending updates
    await prefs.setStringList(_keyPendingUpdates, []);
    _notificationController.add('Synced ${pending.length} pending updates');
  }

  /// Disconnect from server
  Future<void> disconnect() async {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();

    try {
      await _socket?.close(1000, 'Client disconnecting');
    } catch (_) {}

    _socket = null;
    _isConnected = false;
    _statusController.add('offline');
  }

  void dispose() {
    disconnect();
    _statusController.close();
    _eventController.close();
    _notificationController.close();
  }
}
