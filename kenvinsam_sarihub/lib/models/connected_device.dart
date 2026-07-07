class ConnectedDevice {
  final int? id;
  final String deviceName;
  final String deviceIp;
  final String pairingCode;
  final bool isApproved;
  final DateTime? lastSynced;
  final DateTime connectedAt;
  final String status; // 'connected', 'syncing', 'offline'

  ConnectedDevice({
    this.id,
    required this.deviceName,
    required this.deviceIp,
    required this.pairingCode,
    this.isApproved = false,
    this.lastSynced,
    DateTime? connectedAt,
    this.status = 'offline',
  }) : connectedAt = connectedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'device_name': deviceName,
      'device_ip': deviceIp,
      'pairing_code': pairingCode,
      'is_approved': isApproved ? 1 : 0,
      'last_synced': lastSynced?.toIso8601String(),
      'connected_at': connectedAt.toIso8601String(),
      'status': status,
    };
  }

  factory ConnectedDevice.fromMap(Map<String, dynamic> map) {
    return ConnectedDevice(
      id: map['id'] as int?,
      deviceName: map['device_name'] as String,
      deviceIp: map['device_ip'] as String,
      pairingCode: map['pairing_code'] as String,
      isApproved: (map['is_approved'] as int) == 1,
      lastSynced: map['last_synced'] != null
          ? DateTime.parse(map['last_synced'] as String)
          : null,
      connectedAt: DateTime.parse(map['connected_at'] as String),
      status: map['status'] as String? ?? 'offline',
    );
  }

  ConnectedDevice copyWith({
    int? id,
    String? deviceName,
    String? deviceIp,
    String? pairingCode,
    bool? isApproved,
    DateTime? lastSynced,
    DateTime? connectedAt,
    String? status,
  }) {
    return ConnectedDevice(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      deviceIp: deviceIp ?? this.deviceIp,
      pairingCode: pairingCode ?? this.pairingCode,
      isApproved: isApproved ?? this.isApproved,
      lastSynced: lastSynced ?? this.lastSynced,
      connectedAt: connectedAt ?? this.connectedAt,
      status: status ?? this.status,
    );
  }
}

class SyncLog {
  final int? id;
  final String deviceName;
  final String deviceIp;
  final String syncType;
  final int itemsSynced;
  final String status;
  final DateTime syncedAt;

  SyncLog({
    this.id,
    required this.deviceName,
    required this.deviceIp,
    required this.syncType,
    required this.itemsSynced,
    required this.status,
    DateTime? syncedAt,
  }) : syncedAt = syncedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'device_name': deviceName,
      'device_ip': deviceIp,
      'sync_type': syncType,
      'items_synced': itemsSynced,
      'status': status,
      'synced_at': syncedAt.toIso8601String(),
    };
  }

  factory SyncLog.fromMap(Map<String, dynamic> map) {
    return SyncLog(
      id: map['id'] as int?,
      deviceName: map['device_name'] as String,
      deviceIp: map['device_ip'] as String,
      syncType: map['sync_type'] as String,
      itemsSynced: map['items_synced'] as int,
      status: map['status'] as String,
      syncedAt: DateTime.parse(map['synced_at'] as String),
    );
  }
}
