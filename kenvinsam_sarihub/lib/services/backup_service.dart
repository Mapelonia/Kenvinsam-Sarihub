import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
<<<<<<< HEAD
import 'package:permission_handler/permission_handler.dart';
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/database/database_helper.dart';

/// Result object for backup/restore operations
class BackupResult {
  final bool success;
  final String message;
  final String? filePath;

  const BackupResult({
    required this.success,
    required this.message,
    this.filePath,
  });
}

class BackupService {
  static const String _backupVersion = '1.0';
  static const String _backupSignature = 'KENVINSAM_SARIHUB_BACKUP';

<<<<<<< HEAD
  /// Export all database tables to a JSON backup file (default app folder)
  Future<BackupResult> exportBackup() async {
    try {
      final dir = await _getBackupDirectory();
      return await _exportToDirectory(dir.path);
    } catch (e) {
      return BackupResult(success: false, message: 'Export failed: $e');
    }
  }

  /// Export backup to a user-selected folder
  Future<BackupResult> exportBackupToFolder() async {
    try {
      // Request storage permission for Android 11+ (API 30+)
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        return const BackupResult(
          success: false,
          message: 'Storage permission denied. Please grant "All files access" in Settings to save backups to a custom folder.',
        );
      }

      final selectedDir = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Choose backup folder',
      );

      if (selectedDir == null) {
        return const BackupResult(success: false, message: 'No folder selected');
      }

      return await _exportToDirectory(selectedDir);
    } catch (e) {
      return BackupResult(success: false, message: 'Export failed: $e');
    }
  }

  /// Request appropriate storage permission based on Android version
  Future<bool> _requestStoragePermission() async {
    // Android 11+ (API 30+): needs MANAGE_EXTERNAL_STORAGE
    if (Platform.isAndroid) {
      // Check if we already have manage external storage permission
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      // Try requesting MANAGE_EXTERNAL_STORAGE (opens system settings on Android 11+)
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      }

      // Fallback: try legacy storage permission (Android 10 and below)
      if (await Permission.storage.isGranted) {
        return true;
      }
      final storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }

    // Non-Android platforms don't need this
    return true;
  }

  /// Internal: export database to a given directory path
  Future<BackupResult> _exportToDirectory(String directoryPath) async {
    final db = await DatabaseHelper.instance.database;

    final data = {
      'signature': _backupSignature,
      'version': _backupVersion,
      'exported_at': DateTime.now().toIso8601String(),
      'tables': {
        'users': await db.query('users'),
        'products': await db.query('products'),
        'categories': await db.query('categories'),
        'price_history': await db.query('price_history'),
        'electric_units': await db.query('electric_units'),
        'electric_bill_history': await db.query('electric_bill_history'),
        'calc_history': await db.query('calc_history'),
        'connected_devices': await db.query('connected_devices'),
      },
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final timestamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-')
        .substring(0, 19);
    final fileName = 'kenvinsam_backup_$timestamp.json';
    final file = File('$directoryPath/$fileName');

    await file.writeAsString(jsonString, encoding: utf8);

    return BackupResult(
      success: true,
      message: 'Backup saved to:\n${file.path}',
      filePath: file.path,
    );
  }

  /// Let user pick a backup file and restore it
  Future<BackupResult> importBackup() async {
    try {
      // Use FileType.any because Android file picker doesn't reliably
      // filter .json files with FileType.custom on all devices.
      // withReadStream/withData ensures we can read the file content
      // even when only a content:// URI is returned.
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        dialogTitle: 'Select backup file (.json)',
        withData: true,
=======
  /// Export all database tables to a JSON backup file
  Future<BackupResult> exportBackup() async {
    try {
      final db = await DatabaseHelper.instance.database;

      // Export all relevant tables
      final data = {
        'signature': _backupSignature,
        'version': _backupVersion,
        'exported_at': DateTime.now().toIso8601String(),
        'tables': {
          'users': await db.query('users'),
          'products': await db.query('products'),
          'categories': await db.query('categories'),
          'price_history': await db.query('price_history'),
          'electric_units': await db.query('electric_units'),
          'electric_bill_history': await db.query('electric_bill_history'),
          'calc_history': await db.query('calc_history'),
          'connected_devices': await db.query('connected_devices'),
        },
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(data);

      // Save to downloads / documents directory
      final dir = await _getBackupDirectory();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-')
          .substring(0, 19);
      final fileName = 'kenvinsam_backup_$timestamp.json';
      final file = File('${dir.path}/$fileName');

      await file.writeAsString(jsonString, encoding: utf8);

      return BackupResult(
        success: true,
        message: 'Backup saved to:\n${file.path}',
        filePath: file.path,
      );
    } catch (e) {
      return BackupResult(
        success: false,
        message: 'Export failed: $e',
      );
    }
  }

  /// Let user pick a backup file and restore it
  Future<BackupResult> importBackup() async {
    try {
      // Let user pick a .json file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Select backup file',
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

      if (result == null || result.files.isEmpty) {
        return const BackupResult(success: false, message: 'No file selected');
      }

<<<<<<< HEAD
      final pickedFile = result.files.single;

      // Validate file extension
      final name = pickedFile.name.toLowerCase();
      if (!name.endsWith('.json')) {
        return const BackupResult(
          success: false,
          message: 'Please select a .json backup file',
        );
      }

      // Try reading from bytes first (works on all Android versions),
      // fall back to file path if bytes are unavailable.
      String jsonString;

      if (pickedFile.bytes != null) {
        jsonString = utf8.decode(pickedFile.bytes!);
      } else if (pickedFile.path != null) {
        final file = File(pickedFile.path!);
        if (!await file.exists()) {
          return const BackupResult(success: false, message: 'File not found');
        }
        jsonString = await file.readAsString(encoding: utf8);
      } else {
        return const BackupResult(
          success: false,
          message: 'Could not read the selected file. Try copying it to Downloads first.',
        );
      }

      // Parse JSON
      Map<String, dynamic> data;
      try {
        data = jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (_) {
        return const BackupResult(
          success: false,
          message: 'Invalid backup file: not a valid JSON file',
        );
      }

      // Validate
      final validation = _validateBackup(data);
      if (!validation.success) return validation;

      // Restore
      await _applyRestore(data);

      final exportedAt = data['exported_at'] as String?;
      return BackupResult(
        success: true,
        message: 'Restore complete!${exportedAt != null ? '\nBackup was from: ${_formatDate(exportedAt)}' : ''}',
      );
=======
      final filePath = result.files.single.path;
      if (filePath == null) {
        return const BackupResult(success: false, message: 'Invalid file path');
      }

      return await _restoreFromFile(filePath);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    } catch (e) {
      return BackupResult(success: false, message: 'Import failed: $e');
    }
  }

  /// Restore from a specific file path
<<<<<<< HEAD
  Future<BackupResult> restoreFromFile(String filePath) async {
=======
  Future<BackupResult> _restoreFromFile(String filePath) async {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return const BackupResult(success: false, message: 'File not found');
      }

      final jsonString = await file.readAsString(encoding: utf8);

      // Parse JSON
      Map<String, dynamic> data;
      try {
        data = jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (_) {
        return const BackupResult(
          success: false,
          message: 'Invalid backup file: not a valid JSON file',
        );
      }

      // Validate signature
      final validation = _validateBackup(data);
      if (!validation.success) return validation;

      // Restore data
      await _applyRestore(data);

      final exportedAt = data['exported_at'] as String?;
      return BackupResult(
        success: true,
        message: 'Restore complete!${exportedAt != null ? '\nBackup was from: ${_formatDate(exportedAt)}' : ''}',
        filePath: filePath,
      );
    } catch (e) {
      return BackupResult(success: false, message: 'Restore failed: $e');
    }
  }

  /// Validate that a parsed JSON map is a valid backup
  BackupResult _validateBackup(Map<String, dynamic> data) {
    // Check signature
    if (data['signature'] != _backupSignature) {
      return const BackupResult(
        success: false,
        message: 'Invalid backup file: This file was not created by Kenvinsam SariHub.',
      );
    }

    // Check version
    final version = data['version'] as String?;
    if (version == null) {
      return const BackupResult(
        success: false,
        message: 'Invalid backup file: Missing version information.',
      );
    }

    // Check tables key
    if (data['tables'] == null || data['tables'] is! Map) {
      return const BackupResult(
        success: false,
        message: 'Invalid backup file: Missing or malformed table data.',
      );
    }

    // Check required tables exist
    final tables = data['tables'] as Map;
    for (final required in ['products', 'categories', 'users']) {
      if (!tables.containsKey(required)) {
        return BackupResult(
          success: false,
          message: 'Invalid backup file: Missing required table "$required".',
        );
      }
    }

    return const BackupResult(success: true, message: 'Valid backup');
  }

  /// Apply the restore — wipe existing data and import backup
  Future<void> _applyRestore(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;
    final tables = data['tables'] as Map<String, dynamic>;

    await db.transaction((txn) async {
      // Restore in order (respecting foreign keys)
      final restoreOrder = [
        'users',
        'categories',
        'products',
        'price_history',
        'electric_units',
        'electric_bill_history',
        'calc_history',
        'connected_devices',
      ];

      for (final tableName in restoreOrder) {
        if (!tables.containsKey(tableName)) continue;
        final rows = tables[tableName] as List<dynamic>;

        // Clear existing rows
        await txn.delete(tableName);

        // Insert backup rows
        for (final row in rows) {
          await txn.insert(tableName, Map<String, dynamic>.from(row as Map));
        }
      }
    });
  }

  /// Get the count of records in each table for a preview
  Future<Map<String, int>> getBackupPreview(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString(encoding: utf8);
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final tables = data['tables'] as Map<String, dynamic>?;
      if (tables == null) return {};

      final counts = <String, int>{};
      for (final entry in tables.entries) {
        final rows = entry.value as List<dynamic>?;
        counts[entry.key] = rows?.length ?? 0;
      }
      return counts;
    } catch (_) {
      return {};
    }
  }

  /// Get the backup directory (app's documents folder)
  Future<Directory> _getBackupDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${dir.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  /// Get all existing backup files
  Future<List<FileSystemEntity>> getLocalBackups() async {
    try {
      final dir = await _getBackupDirectory();
      final files = await dir.list().toList();
      files.sort((a, b) => b.path.compareTo(a.path)); // newest first
      return files.where((f) => f.path.endsWith('.json')).toList();
    } catch (_) {
      return [];
    }
  }

  /// Delete a local backup file
  Future<void> deleteBackup(String filePath) async {
    try {
      await File(filePath).delete();
    } catch (_) {}
  }

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }
}
