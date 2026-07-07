import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/connected_device.dart';

/// WebSocket event types for real-time sync
class SyncEvent {
  static const String productCreated = 'product_created';
  static const String productUpdated = 'product_updated';
  static const String productDeleted = 'product_deleted';
  static const String priceChanged = 'price_changed';
  static const String stockUpdated = 'stock_updated';
  static const String categoryUpdated = 'category_updated';
  static const String imageUpdated = 'image_updated';
  static const String fullSync = 'full_sync';
  // Electric bill sync events
  static const String electricBillsPush = 'electric_bills_push';   // Family → Admin
  static const String electricBillsSync = 'electric_bills_sync';   // Admin → Family
  static const String electricUnitsPush = 'electric_units_push';   // Family → Admin
  static const String ping = 'ping';
  static const String pong = 'pong';
  static const String connected = 'connected';
  static const String error = 'error';
}

/// A message sent over WebSocket
class SyncMessage {
  final String event;
  final Map<String, dynamic> data;
  final String timestamp;
  final String? senderId;

  SyncMessage({
    required this.event,
    required this.data,
    String? timestamp,
    this.senderId,
  }) : timestamp = timestamp ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() => {
        'event': event,
        'data': data,
        'timestamp': timestamp,
        'sender_id': senderId,
      };

  String toJson() => jsonEncode(toMap());

  factory SyncMessage.fromJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return SyncMessage(
      event: map['event'] as String,
      data: map['data'] as Map<String, dynamic>? ?? {},
      timestamp: map['timestamp'] as String?,
      senderId: map['sender_id'] as String?,
    );
  }
}

/// Real-time WebSocket server running on Admin device.
/// Broadcasts data changes to all connected Family clients.
class RealtimeSyncServer {
  static final RealtimeSyncServer instance = RealtimeSyncServer._();
  RealtimeSyncServer._();

  HttpServer? _httpServer;
  final List<_ClientConnection> _clients = [];
  bool _isRunning = false;
  int _wsPort = 8643; // WebSocket on separate port from HTTP
  Timer? _heartbeatTimer;

  // Stream controller for notifying UI about events
  final _eventController = StreamController<SyncMessage>.broadcast();
  Stream<SyncMessage> get eventStream => _eventController.stream;

  // Connected client count stream
  final _clientCountController = StreamController<int>.broadcast();
  Stream<int> get clientCountStream => _clientCountController.stream;

  bool get isRunning => _isRunning;
  int get wsPort => _wsPort;
  int get connectedClientCount => _clients.where((c) => c.isAlive).length;
  List<_ClientConnection> get clients => List.unmodifiable(_clients);

  /// Start the WebSocket server
  Future<bool> startServer() async {
    if (_isRunning) return true;

    try {
<<<<<<< HEAD
      _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, _wsPort, shared: true);
=======
      _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, _wsPort);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      _isRunning = true;

      _httpServer!.listen((HttpRequest request) {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          _handleWebSocketUpgrade(request);
        } else {
          request.response.statusCode = 400;
          request.response.write('WebSocket upgrade required');
          request.response.close();
        }
      });

      // Start heartbeat to detect dead connections
      _startHeartbeat();

      print('WebSocket server started on port $_wsPort');
      return true;
    } catch (e) {
      print('Failed to start WebSocket server: $e');
      _isRunning = false;
      return false;
    }
  }

  /// Stop the WebSocket server
  Future<void> stopServer() async {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;

    // Close all client connections
    for (final client in _clients) {
      try {
        client.socket.close(1001, 'Server shutting down');
      } catch (_) {}
    }
    _clients.clear();

    await _httpServer?.close(force: true);
    _httpServer = null;
    _isRunning = false;
    _clientCountController.add(0);
    print('WebSocket server stopped');
  }

  /// Handle WebSocket upgrade request
  Future<void> _handleWebSocketUpgrade(HttpRequest request) async {
    try {
      final socket = await WebSocketTransformer.upgrade(request);
      final clientIp = request.connectionInfo?.remoteAddress.address ?? 'unknown';

<<<<<<< HEAD
      // Verify device is approved (check by IP, or by device name if IP changed via DHCP)
      final db = await DatabaseHelper.instance.database;
      var results = await db.query(
=======
      // Verify device is approved
      final db = await DatabaseHelper.instance.database;
      final results = await db.query(
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        'connected_devices',
        where: 'device_ip = ? AND is_approved = 1',
        whereArgs: [clientIp],
      );

<<<<<<< HEAD
      // If not found by IP, the device may have gotten a new IP from DHCP.
      // Look for any approved device and update its IP (common on reconnect).
      if (results.isEmpty) {
        // Check if there's any approved device that we can match
        // This handles the case where a phone reconnects to Wi-Fi with a new IP
        final allApproved = await db.query(
          'connected_devices',
          where: 'is_approved = 1',
        );

        if (allApproved.isEmpty) {
          socket.close(4003, 'Device not approved');
          print('WebSocket rejected: no approved devices for IP $clientIp');
          return;
        }

        // Update the first approved device's IP (single-client scenario)
        // For multi-client, the pairing should be redone
        if (allApproved.length == 1) {
          await db.update(
            'connected_devices',
            {'device_ip': clientIp, 'status': 'connected'},
            where: 'id = ?',
            whereArgs: [allApproved.first['id']],
          );
          results = await db.query(
            'connected_devices',
            where: 'device_ip = ? AND is_approved = 1',
            whereArgs: [clientIp],
          );
        } else {
          socket.close(4003, 'Device not approved - IP changed, please re-pair');
          print('WebSocket rejected: IP $clientIp not found, multiple devices registered');
          return;
        }
      }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      if (results.isEmpty) {
        socket.close(4003, 'Device not approved');
        return;
      }

      final deviceName = results.first['device_name'] as String;
      final client = _ClientConnection(
        socket: socket,
        ip: clientIp,
        deviceName: deviceName,
        connectedAt: DateTime.now(),
      );

      _clients.add(client);
      _clientCountController.add(connectedClientCount);

      // Update device status in DB
      await db.update(
        'connected_devices',
        {'status': 'connected'},
        where: 'device_ip = ?',
        whereArgs: [clientIp],
      );

      // Send welcome message
      _sendToClient(client, SyncMessage(
        event: SyncEvent.connected,
        data: {'message': 'Connected to Kenvinsam SariHub', 'device': deviceName},
      ));

      _eventController.add(SyncMessage(
        event: SyncEvent.connected,
        data: {'device': deviceName, 'ip': clientIp},
      ));

      // Listen for messages from client
      socket.listen(
        (data) => _handleClientMessage(client, data as String),
        onDone: () => _handleClientDisconnect(client),
        onError: (_) => _handleClientDisconnect(client),
      );
    } catch (e) {
      print('WebSocket upgrade error: $e');
    }
  }

  /// Handle message from a client
  void _handleClientMessage(_ClientConnection client, String data) {
    try {
      final message = SyncMessage.fromJson(data);

      switch (message.event) {
        case SyncEvent.pong:
          client.isAlive = true;
          break;
        case SyncEvent.fullSync:
          _handleFullSyncRequest(client);
          break;
        case SyncEvent.electricBillsPush:
          _handleElectricBillsPush(client, message.data);
          break;
        case SyncEvent.electricUnitsPush:
          _handleElectricUnitsPush(client, message.data);
          break;
        default:
          break;
      }
    } catch (e) {
      print('Error handling client message: $e');
    }
  }

  /// Handle client disconnect
  Future<void> _handleClientDisconnect(_ClientConnection client) async {
    _clients.remove(client);
    _clientCountController.add(connectedClientCount);

    // Update device status
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'connected_devices',
        {'status': 'offline'},
        where: 'device_ip = ?',
        whereArgs: [client.ip],
      );
    } catch (_) {}

    _eventController.add(SyncMessage(
      event: 'disconnected',
      data: {'device': client.deviceName, 'ip': client.ip},
    ));
  }

  /// Handle full sync request from client — sends all data including electric bills
  Future<void> _handleFullSyncRequest(_ClientConnection client) async {
    final db = await DatabaseHelper.instance.database;
    final products = await db.query('products');
    final categories = await db.query('categories');
    final electricUnits = await db.query('electric_units');
    final electricBills = await db.query('electric_bill_history',
        orderBy: 'created_at DESC');

    _sendToClient(client, SyncMessage(
      event: SyncEvent.fullSync,
      data: {
        'products': products,
        'categories': categories,
        'electric_units': electricUnits,
        'electric_bills': electricBills,
        'total_items': products.length + categories.length +
            electricUnits.length + electricBills.length,
      },
    ));

    await _logSync(client.ip, client.deviceName, 'full_sync',
        products.length + categories.length +
            electricUnits.length + electricBills.length);
  }

  /// Handle electric bills pushed from Family device → save to Admin database
  Future<void> _handleElectricBillsPush(
      _ClientConnection client, Map<String, dynamic> data) async {
    final bills = data['bills'] as List<dynamic>?;
    if (bills == null || bills.isEmpty) return;

    final db = await DatabaseHelper.instance.database;
    int synced = 0;

    await db.transaction((txn) async {
      for (final bill in bills) {
        final billMap = Map<String, dynamic>.from(bill as Map);
        final billId = billMap['id'];

        // Check if already exists
        final existing = await txn.query(
          'electric_bill_history',
          where: 'id = ?',
          whereArgs: [billId],
        );

        if (existing.isEmpty) {
          await txn.insert('electric_bill_history', billMap);
          synced++;
        } else {
          // Update if newer
          final localDate = DateTime.parse(
              existing.first['created_at'] as String);
          final remoteDate =
              DateTime.parse(billMap['created_at'] as String);
          if (remoteDate.isAfter(localDate)) {
            await txn.update('electric_bill_history', billMap,
                where: 'id = ?', whereArgs: [billId]);
            synced++;
          }
        }
      }
    });

    _eventController.add(SyncMessage(
      event: SyncEvent.electricBillsPush,
      data: {'device': client.deviceName, 'synced': synced},
    ));

    await _logSync(client.ip, client.deviceName, 'electric_bills_push', synced);
    print('Received $synced electric bills from ${client.deviceName}');
  }

  /// Handle electric units pushed from Family device
  Future<void> _handleElectricUnitsPush(
      _ClientConnection client, Map<String, dynamic> data) async {
    final units = data['units'] as List<dynamic>?;
    if (units == null || units.isEmpty) return;

    final db = await DatabaseHelper.instance.database;

    await db.transaction((txn) async {
      for (final unit in units) {
        final unitMap = Map<String, dynamic>.from(unit as Map);
        final unitId = unitMap['id'];

        final existing = await txn.query(
          'electric_units',
          where: 'id = ?',
          whereArgs: [unitId],
        );

        if (existing.isEmpty) {
          await txn.insert('electric_units', unitMap);
        } else {
          await txn.update('electric_units', unitMap,
              where: 'id = ?', whereArgs: [unitId]);
        }
      }
    });
  }

  /// Broadcast a product creation to all connected clients
  Future<void> broadcastProductCreated(Map<String, dynamic> product) async {
    _broadcast(SyncMessage(
      event: SyncEvent.productCreated,
      data: {'product': product},
    ));
  }

  /// Broadcast a product update to all connected clients
  Future<void> broadcastProductUpdated(Map<String, dynamic> product) async {
    _broadcast(SyncMessage(
      event: SyncEvent.productUpdated,
      data: {'product': product},
    ));
  }

  /// Broadcast a product deletion to all connected clients
  Future<void> broadcastProductDeleted(int productId) async {
    _broadcast(SyncMessage(
      event: SyncEvent.productDeleted,
      data: {'product_id': productId},
    ));
  }

  /// Broadcast a price change to all connected clients
  Future<void> broadcastPriceChanged(Map<String, dynamic> product, Map<String, dynamic> priceHistory) async {
    _broadcast(SyncMessage(
      event: SyncEvent.priceChanged,
      data: {'product': product, 'price_history': priceHistory},
    ));
  }

  /// Broadcast a stock update to all connected clients
  Future<void> broadcastStockUpdated(int productId, int newStock) async {
    _broadcast(SyncMessage(
      event: SyncEvent.stockUpdated,
      data: {'product_id': productId, 'stock_quantity': newStock},
    ));
  }

  /// Broadcast a category update to all connected clients
  Future<void> broadcastCategoryUpdated(List<Map<String, dynamic>> categories) async {
    _broadcast(SyncMessage(
      event: SyncEvent.categoryUpdated,
      data: {'categories': categories},
    ));
  }

  /// Broadcast an image update
  Future<void> broadcastImageUpdated(int productId, String? imagePath) async {
    _broadcast(SyncMessage(
      event: SyncEvent.imageUpdated,
      data: {'product_id': productId, 'image_path': imagePath},
    ));
  }

  /// Send message to a specific client
  void _sendToClient(_ClientConnection client, SyncMessage message) {
    try {
      if (client.socket.readyState == WebSocket.open) {
        client.socket.add(message.toJson());
      }
    } catch (e) {
      print('Error sending to client ${client.deviceName}: $e');
    }
  }

  /// Broadcast message to all connected clients
  void _broadcast(SyncMessage message) {
    final deadClients = <_ClientConnection>[];

    for (final client in _clients) {
      try {
        if (client.socket.readyState == WebSocket.open) {
          client.socket.add(message.toJson());
        } else {
          deadClients.add(client);
        }
      } catch (e) {
        deadClients.add(client);
      }
    }

    // Clean up dead connections
    for (final dead in deadClients) {
      _handleClientDisconnect(dead);
    }

    _eventController.add(message);
  }

  /// Start heartbeat timer to detect dead connections
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      final deadClients = <_ClientConnection>[];

      for (final client in _clients) {
        if (!client.isAlive) {
          deadClients.add(client);
          continue;
        }
        client.isAlive = false;
        _sendToClient(client, SyncMessage(event: SyncEvent.ping, data: {}));
      }

      for (final dead in deadClients) {
        try {
          dead.socket.close(1001, 'Heartbeat timeout');
        } catch (_) {}
        _handleClientDisconnect(dead);
      }
    });
  }

  /// Log sync operation
  Future<void> _logSync(String ip, String deviceName, String syncType, int itemCount) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('sync_log', {
      'device_name': deviceName,
      'device_ip': ip,
      'sync_type': syncType,
      'items_synced': itemCount,
      'status': 'success',
      'synced_at': DateTime.now().toIso8601String(),
    });
  }

  void dispose() {
    _eventController.close();
    _clientCountController.close();
  }
}

/// Represents a connected WebSocket client
class _ClientConnection {
  final WebSocket socket;
  final String ip;
  final String deviceName;
  final DateTime connectedAt;
  bool isAlive;

  _ClientConnection({
    required this.socket,
    required this.ip,
    required this.deviceName,
    required this.connectedAt,
    this.isAlive = true,
  });
}
