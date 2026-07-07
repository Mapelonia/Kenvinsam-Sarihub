import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/user.dart';

class SessionService {
  static const String _keyUserId = 'session_user_id';
  static const String _keyUsername = 'session_username';
  static const String _keyRole = 'session_role';
  static const String _keyIsLoggedIn = 'session_is_logged_in';
  static const String _keyLoginTime = 'session_login_time';

  /// Save session to SharedPreferences and database
  Future<void> saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setInt(_keyUserId, user.id!);
    await prefs.setString(_keyUsername, user.username);
    await prefs.setString(_keyRole, user.role);
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());

    // Save session to database
    final db = await DatabaseHelper.instance.database;
    await db.insert('sessions', {
      'user_id': user.id,
      'username': user.username,
      'role': user.role,
      'login_time': DateTime.now().toIso8601String(),
      'is_active': 1,
    });
  }

  /// Check if a session exists (user is remembered)
  Future<bool> hasActiveSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Restore the logged-in user from session
  Future<User?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;

    if (!isLoggedIn) return null;

    final userId = prefs.getInt(_keyUserId);
    if (userId == null) return null;

    // Verify user still exists in database
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    }

    // User no longer exists, clear session
    await clearSession();
    return null;
  }

  /// Clear session (logout)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_keyUserId);

    // Deactivate session in database
    if (userId != null) {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'sessions',
        {'is_active': 0, 'logout_time': DateTime.now().toIso8601String()},
        where: 'user_id = ? AND is_active = 1',
        whereArgs: [userId],
      );
    }

    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyRole);
    await prefs.remove(_keyLoginTime);
  }

  /// Get session login history for admin
  Future<List<Map<String, dynamic>>> getSessionHistory() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('sessions', orderBy: 'login_time DESC', limit: 50);
  }
}
