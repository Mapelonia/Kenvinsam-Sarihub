import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final authService = ref.read(authServiceProvider);
    final success = await authService.changePassword(
      user.id!,
      _currentPasswordController.text,
      _newPasswordController.text,
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        AppSnackbar.show(
          context,
          'Password changed successfully',
          type: SnackbarType.success,
        );
        Navigator.pop(context);
      } else {
        AppSnackbar.show(
          context,
          'Current password is incorrect',
          type: SnackbarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space2xl),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spaceLg),
                  decoration: BoxDecoration(
                    color: AppTheme.paleGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.security_rounded,
                    size: 44,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spaceLg),
              Text(
                'Update Your Password',
                style: AppTheme.headingLg,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'Choose a strong password to keep your account secure',
                style: AppTheme.bodySm.copyWith(color: context.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.space3xl),

              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrent,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureCurrent ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                    onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                    splashRadius: 20,
                  ),
                ),
                validator: (v) => v?.isEmpty == true ? 'Enter current password' : null,
              ),
              const SizedBox(height: AppTheme.spaceMd),

              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNew,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNew ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                    splashRadius: 20,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter new password';
                  if (v.length < 4) return 'At least 4 characters';
                  if (v == _currentPasswordController.text) return 'Must be different';
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spaceMd),

              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: const Icon(Icons.lock_reset_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    splashRadius: 20,
                  ),
                ),
                validator: (v) => v != _newPasswordController.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: AppTheme.space3xl),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _changePassword,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check_rounded),
                label: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
