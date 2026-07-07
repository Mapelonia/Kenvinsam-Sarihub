import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/providers/auth_provider.dart';
import 'package:kenvinsam_sarihub/screens/auth/login_screen.dart';
import 'package:kenvinsam_sarihub/screens/home/home_screen.dart';
import 'package:kenvinsam_sarihub/widgets/app_logo.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
<<<<<<< HEAD
  late AnimationController _contentController;
  late AnimationController _pulseController;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;
  late Animation<double> _pulseAnimation;
=======
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

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

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );
    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startAnimations();
    _checkSession();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _contentController.forward();
    _pulseController.repeat(reverse: true);
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(milliseconds: 2200));
=======
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _logoController.forward();
    _progressController.forward();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(milliseconds: 2000));
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final authService = ref.read(authServiceProvider);
    final user = await authService.restoreSession();
    if (!mounted) return;

    if (user != null) {
      ref.read(currentUserProvider.notifier).setUser(user);
      _navigate(const HomeScreen());
    } else {
      _navigate(const LoginScreen());
    }
  }

  void _navigate(Widget destination) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
<<<<<<< HEAD
        transitionDuration: const Duration(milliseconds: 600),
=======
        transitionDuration: const Duration(milliseconds: 500),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
<<<<<<< HEAD
    _contentController.dispose();
    _pulseController.dispose();
=======
    _progressController.dispose();
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
<<<<<<< HEAD
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: Stack(
          children: [
            // Ambient background shapes
            ..._buildBackgroundShapes(),

            // Main content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    _buildLogo(),
                    const SizedBox(height: AppTheme.space3xl),
                    _buildText(),
                    const Spacer(flex: 3),
                    _buildLoadingIndicator(),
                    const SizedBox(height: AppTheme.space4xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundShapes() {
    return [
      Positioned(
        top: -120,
        right: -80,
        child: Container(
          width: 300,
          height: 300,
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
        bottom: -150,
        left: -100,
        child: Container(
          width: 350,
          height: 350,
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
      Positioned(
        top: MediaQuery.of(context).size.height * 0.35,
        left: -50,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.03),
          ),
        ),
      ),
    ];
  }

  Widget _buildLogo() {
    return FadeTransition(
      opacity: _logoFade,
      child: ScaleTransition(
        scale: _logoScale,
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightGreen.withOpacity(0.15),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: AppLogo(size: 70, showBackground: false),
          ),
=======
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.darkGreen, AppTheme.primaryGreen, AppTheme.lightGreen],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -80,
                right: -50,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                left: -60,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppTheme.space2xl),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: const AppLogo(
                            size: 90,
                            showBackground: false,
                          ),
                        ),
                        const SizedBox(height: AppTheme.space2xl),
                        Text(
                          'Kenvinsam',
                          style: AppTheme.headingXl.copyWith(
                            color: Colors.white,
                            fontSize: 38,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'SariHub',
                          style: AppTheme.headingLg.copyWith(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(height: AppTheme.space2xl),
                        Text(
                          'Your Sari-Sari Store Manager',
                          style: AppTheme.bodySm.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom progress bar
              Positioned(
                bottom: 60,
                left: 60,
                right: 60,
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _progressAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceSm),
                        Text(
                          'Loading...',
                          style: AppTheme.caption.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildText() {
    return FadeTransition(
      opacity: _contentFade,
      child: SlideTransition(
        position: _contentSlide,
        child: Column(
          children: [
            Text(
              'Kenvinsam',
              style: AppTheme.headingXl.copyWith(
                color: Colors.white,
                fontSize: 34,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'SariHub',
              style: AppTheme.headingLg.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontSize: 24,
                fontWeight: FontWeight.w300,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceLg,
                vertical: AppTheme.spaceSm,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                'Smart Store Management',
                style: AppTheme.bodySm.copyWith(
                  color: Colors.white.withOpacity(0.75),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return FadeTransition(
      opacity: _contentFade,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _pulseAnimation.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      0.4 + (0.3 * ((index + _pulseController.value * 3).toInt() % 3 == 0 ? 1.0 : 0.0)),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
