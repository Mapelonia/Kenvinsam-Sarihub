import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/user.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  List<User> _users = [];
  List<Map<String, dynamic>> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final authService = ref.read(authServiceProvider);
    _users = await authService.getAllUsers();
    _sessions = await authService.getSessionHistory();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Management'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Users', icon: Icon(Icons.people)),
              Tab(text: 'Login History', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildUsersTab(currentUser),
                  _buildSessionsTab(),
                ],
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddUserDialog(context),
          icon: const Icon(Icons.person_add),
          label: const Text('Add User'),
        ),
      ),
    );
  }

  Widget _buildUsersTab(User? currentUser) {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          final isCurrentUser = user.id == currentUser?.id;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: user.isAdmin
                    ? AppTheme.primaryGreen.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                child: Icon(
                  user.isAdmin ? Icons.admin_panel_settings : Icons.person,
                  color: user.isAdmin ? AppTheme.primaryGreen : Colors.blue,
                ),
              ),
              title: Row(
                children: [
                  Text(
                    user.displayName ?? user.username,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (isCurrentUser) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'YOU',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@${user.username}'),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: user.isAdmin
                          ? AppTheme.primaryGreen.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      user.role.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: user.isAdmin ? AppTheme.primaryGreen : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: isCurrentUser
                  ? null
                  : PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'reset_password':
                            _showResetPasswordDialog(context, user);
                            break;
                          case 'change_role':
                            _showChangeRoleDialog(context, user);
                            break;
                          case 'delete':
                            _confirmDeleteUser(context, user);
                            break;
                        }
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'reset_password',
                          child: Row(
                            children: [
                              Icon(Icons.key, size: 18),
                              SizedBox(width: 8),
                              Text('Reset Password'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'change_role',
                          child: Row(
                            children: [
                              Icon(Icons.swap_horiz, size: 18),
                              SizedBox(width: 8),
                              Text('Change Role'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSessionsTab() {
    if (_sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No login history yet',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sessions.length,
      itemBuilder: (context, index) {
        final session = _sessions[index];
        final isActive = session['is_active'] == 1;
        final loginTime = DateTime.parse(session['login_time'] as String);

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isActive
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              child: Icon(
                isActive ? Icons.circle : Icons.circle_outlined,
                color: isActive ? Colors.green : Colors.grey,
                size: 16,
              ),
            ),
            title: Text(
              session['username'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${Helpers.formatDateTime(loginTime)} • ${session['role']}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? 'Active' : 'Ended',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final displayNameController = TextEditingController();
    String selectedRole = AppConstants.roleFamily;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username *',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(Icons.shield),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'family', child: Text('Family')),
                  ],
                  onChanged: (v) => setDialogState(() => selectedRole = v!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Username and password are required')),
                  );
                  return;
                }

                final authService = ref.read(authServiceProvider);
                final exists = await authService.usernameExists(usernameController.text.trim());
                if (exists) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Username already exists')),
                    );
                  }
                  return;
                }

                final newUser = User(
                  username: usernameController.text.trim(),
                  password: passwordController.text.trim(),
                  role: selectedRole,
                  displayName: displayNameController.text.trim().isEmpty
                      ? usernameController.text.trim()
                      : displayNameController.text.trim(),
                );

                await authService.createUser(newUser);
                await _loadData();
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetPasswordDialog(BuildContext context, User user) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reset Password for ${user.displayName ?? user.username}'),
        content: TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'New Password',
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (passwordController.text.isEmpty) return;
              final authService = ref.read(authServiceProvider);
              await authService.resetPassword(user.id!, passwordController.text.trim());
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset successfully')),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showChangeRoleDialog(BuildContext context, User user) {
    final newRole = user.isAdmin ? AppConstants.roleFamily : AppConstants.roleAdmin;
    final newRoleLabel = user.isAdmin ? 'Family' : 'Admin';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Role'),
        content: Text(
          'Change ${user.displayName ?? user.username}\'s role from '
          '${user.role.toUpperCase()} to ${newRoleLabel.toUpperCase()}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final authService = ref.read(authServiceProvider);
              final updatedUser = user.copyWith(role: newRole);
              await authService.updateUser(updatedUser);
              await _loadData();
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Role changed to $newRoleLabel')),
                );
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete "${user.displayName ?? user.username}"? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final authService = ref.read(authServiceProvider);
              await authService.deleteUser(user.id!);
              await _loadData();
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User deleted')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
