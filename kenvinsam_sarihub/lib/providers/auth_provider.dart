import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/user.dart';
import 'package:kenvinsam_sarihub/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((ref) {
  return CurrentUserNotifier(ref.read(authServiceProvider));
});

/// Provides the authentication state: loading, authenticated, or unauthenticated
final authStateProvider = FutureProvider<User?>((ref) async {
  final authService = ref.read(authServiceProvider);
  return await authService.restoreSession();
});

class CurrentUserNotifier extends StateNotifier<User?> {
  final AuthService _authService;

  CurrentUserNotifier(this._authService) : super(null);

  void setUser(User user) {
    state = user;
  }

  Future<void> logout() async {
    await _authService.logout();
    state = null;
  }

  bool get isAdmin => state?.isAdmin ?? false;
  bool get isLoggedIn => state != null;
  String get role => state?.role ?? '';
  String get displayName => state?.displayName ?? 'User';
}
