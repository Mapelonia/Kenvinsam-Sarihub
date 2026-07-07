import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/screens/home/home_screen.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/widgets/app_logo.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
<<<<<<< HEAD
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  bool _isLoading = false;
  bool _obscurePassword = true;
  int _failedAttempts = 0;
  bool _isLocked = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
=======
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
<<<<<<< HEAD
    _usernameFocus.dispose();
    _passwordFocus.dispose();
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    _animController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLocked) {
      AppSnackbar.show(
        context,
        'Too many failed attempts. Please wait 30 seconds.',
        type: SnackbarType.error,
      );
      return;
    }

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      AppSnackbar.show(
        context,
        'Please enter username and password',
        type: SnackbarType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);
    final authService = ref.read(authServiceProvider);
    final user = await authService.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );
    setState(() => _isLoading = false);

    if (user != null) {
      _failedAttempts = 0;
      ref.read(currentUserProvider.notifier).setUser(user);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
<<<<<<< HEAD
            transitionDuration: const Duration(milliseconds: 500),
=======
            transitionDuration: const Duration(milliseconds: 400),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ),
        );
      }
    } else {
      _failedAttempts++;
      if (_failedAttempts >= 5) _lockLogin();
      if (mounted) {
        AppSnackbar.show(
          context,
          'Invalid username or password${_failedAttempts >= 3 ? ' ($_failedAttempts/5)' : ''}',
          type: SnackbarType.error,
        );
      }
    }
  }

  void _lockLogin() {
    setState(() => _isLocked = true);
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          _isLocked = false;
          _failedAttempts = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
<<<<<<< HEAD
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: Stack(
          children: [
            // Ambient shapes
            _buildBackgroundShapes(),
=======
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.darkGreen, AppTheme.primaryGreen, AppTheme.lightGreen],
          ),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -50,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
              ),
            ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
<<<<<<< HEAD
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.space2xl,
                    vertical: AppTheme.spaceLg,
                  ),
=======
                  padding: const EdgeInsets.all(AppTheme.space2xl),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBranding(),
<<<<<<< HEAD
                          const SizedBox(height: AppTheme.space4xl),
=======
                          const SizedBox(height: AppTheme.space3xl),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                          _buildLoginCard(),
                          const SizedBox(height: AppTheme.spaceLg),
                          _buildCredentialsHint(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildBackgroundShapes() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -60,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.lightGreen.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -130,
          left: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.accentGreen.withOpacity(0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Widget _buildBranding() {
    return Column(
      children: [
        Container(
<<<<<<< HEAD
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: const Center(
            child: AppLogo(size: 55, showBackground: false),
          ),
        ),
        const SizedBox(height: AppTheme.spaceLg),
        Text(
          'Kenvinsam SariHub',
          style: AppTheme.headingLg.copyWith(
            color: Colors.white,
            fontSize: 26,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        Text(
          'Smart Store Management',
          style: AppTheme.bodySm.copyWith(
            color: Colors.white.withOpacity(0.65),
            letterSpacing: 0.3,
          ),
        ),
=======
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
          ),
          child: const AppLogo(size: 70, showBackground: false),
        ),
        const SizedBox(height: AppTheme.spaceLg),
        Text(
          'Kenvinsam',
          style: AppTheme.headingXl.copyWith(
            color: Colors.white,
            fontSize: 32,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          'SariHub',
          style: AppTheme.headingLg.copyWith(
            color: Colors.white.withOpacity(0.85),
            fontWeight: FontWeight.w300,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          'Your Sari-Sari Store Manager',
          style: AppTheme.bodySm.copyWith(color: Colors.white.withOpacity(0.7)),
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [
          BoxShadow(
<<<<<<< HEAD
            color: Colors.black.withOpacity(0.12),
            blurRadius: 40,
            offset: const Offset(0, 16),
            spreadRadius: -8,
=======
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.space2xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
<<<<<<< HEAD
              style: AppTheme.headingMd.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sign in to manage your store',
              style: AppTheme.bodySm.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: AppTheme.space2xl),

            // Username
            _buildInputLabel('Username'),
            const SizedBox(height: AppTheme.spaceSm),
            TextField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                prefixIcon: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: AppTheme.textMuted,
                ),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _passwordFocus.requestFocus(),
              enabled: !_isLocked,
            ),
            const SizedBox(height: AppTheme.spaceLg),

            // Password
            _buildInputLabel('Password'),
            const SizedBox(height: AppTheme.spaceSm),
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 20,
                  color: AppTheme.textMuted,
                ),
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
=======
              style: AppTheme.headingLg.copyWith(letterSpacing: -0.3),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Sign in to continue',
              style: AppTheme.bodySm.copyWith(color: context.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.space2xl),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              textInputAction: TextInputAction.next,
              enabled: !_isLocked,
            ),
            const SizedBox(height: AppTheme.spaceMd),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  splashRadius: 20,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _login(),
              enabled: !_isLocked,
            ),
<<<<<<< HEAD

            // Lock warning
            if (_isLocked) ...[
              const SizedBox(height: AppTheme.spaceLg),
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: Border.all(
                    color: AppTheme.error.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_rounded,
=======
            if (_isLocked) ...[
              const SizedBox(height: AppTheme.spaceMd),
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_clock_rounded,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                        color: AppTheme.error, size: 18),
                    const SizedBox(width: AppTheme.spaceSm),
                    Expanded(
                      child: Text(
<<<<<<< HEAD
                        'Account locked. Try again in 30 seconds.',
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.error,
                          fontWeight: FontWeight.w500,
                        ),
=======
                        'Account locked. Please wait 30 seconds.',
                        style: AppTheme.caption.copyWith(color: AppTheme.error),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppTheme.space2xl),
<<<<<<< HEAD

            // Sign in button
            _buildSignInButton(),
            const SizedBox(height: AppTheme.spaceLg),

            // Security note
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield_rounded,
                    size: 13, color: AppTheme.textMuted),
                const SizedBox(width: 6),
                Text(
                  'Offline • Data stays on your device',
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.textMuted,
                  ),
=======
            ElevatedButton(
              onPressed: (_isLoading || _isLocked) ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                disabledBackgroundColor: Colors.grey.shade300,
                elevation: 4,
                shadowColor: AppTheme.primaryGreen.withOpacity(0.4),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Sign In'),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield_outlined,
                    size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Your session will be remembered',
                  style: AppTheme.caption.copyWith(color: Colors.grey),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: AppTheme.label.copyWith(
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        gradient: (_isLoading || _isLocked) ? null : AppTheme.primaryGradient,
        color: (_isLoading || _isLocked) ? Colors.grey.shade300 : null,
        boxShadow: (_isLoading || _isLocked) ? null : AppTheme.shadowGreen,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (_isLoading || _isLocked) ? null : _login,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Container(
            height: 52,
            alignment: Alignment.center,
            child: _isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign In',
                    style: AppTheme.bodyLg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialsHint() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceLg,
        vertical: AppTheme.spaceMd,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              size: 16, color: Colors.white.withOpacity(0.7)),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo Credentials',
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Admin: Kenvinsam / kenvinsam123',
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                Text(
                  'Family: Razo / razo123',
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
=======
  Widget _buildCredentialsHint() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.key_rounded, size: 12, color: Colors.white.withOpacity(0.9)),
              const SizedBox(width: 4),
              Text(
                'Default Credentials',
                style: AppTheme.label.copyWith(
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCredentialItem('Admin', 'Kenvinsam', 'kenvinsam123'),
              Container(
                width: 1,
                height: 30,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildCredentialItem('Family', 'Razo', 'razo123'),
            ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
=======

  Widget _buildCredentialItem(String role, String username, String password) {
    return Column(
      children: [
        Text(
          role,
          style: AppTheme.caption.copyWith(
            color: Colors.white.withOpacity(0.6),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$username / $password',
          style: AppTheme.caption.copyWith(
            color: Colors.white.withOpacity(0.9),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
