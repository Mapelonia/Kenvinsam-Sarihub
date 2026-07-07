import 'package:sqflite/sqflite.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/user.dart';
import 'package:kenvinsam_sarihub/services/session_service.dart';

class AuthService {
  final SessionService _sessionService = SessionService();

  /// Authenticate user with username and password
  Future<User?> login(String username, String password) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (results.isNotEmpty) {
      final user = User.fromMap(results.first);
      // Save session for persistence
      await _sessionService.saveSession(user);
      return user;
    }
    return null;
  }

  /// Logout current user and clear session
  Future<void> logout() async {
    await _sessionService.clearSession();
  }

  /// Check if there's an active session and restore user
  Future<User?> restoreSession() async {
    return await _sessionService.restoreSession();
  }

  /// Check if session exists
  Future<bool> hasActiveSession() async {
    return await _sessionService.hasActiveSession();
  }

  /// Get all users (admin only)
  Future<List<User>> getAllUsers() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('users', orderBy: 'role ASC, username ASC');
    return results.map((map) => User.fromMap(map)).toList();
  }

  /// Create a new user (admin only)
  Future<int> createUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  /// Update user details (admin only)
  Future<int> updateUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Change password for a user
  Future<bool> changePassword(int userId, String oldPassword, String newPassword) async {
    final db = await DatabaseHelper.instance.database;

    // Verify old password
    final results = await db.query(
      'users',
      where: 'id = ? AND password = ?',
      whereArgs: [userId, oldPassword],
    );

    if (results.isEmpty) return false;

    // Update password
    await db.update(
      'users',
      {'password': newPassword},
      where: 'id = ?',
      whereArgs: [userId],
    );
    return true;
  }

  /// Admin reset password (no old password needed)
  Future<int> resetPassword(int userId, String newPassword) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'users',
      {'password': newPassword},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  /// Delete user (admin only, cannot delete self)
  Future<int> deleteUser(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  /// Check if username already exists
  Future<bool> usernameExists(String username) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return results.isNotEmpty;
  }

  /// Get login session history (admin only)
  Future<List<Map<String, dynamic>>> getSessionHistory() async {
    return await _sessionService.getSessionHistory();
  }
}
