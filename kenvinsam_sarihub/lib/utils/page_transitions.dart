import 'package:flutter/material.dart';

/// Custom page transitions for smooth navigation throughout the app.
class AppPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final TransitionType type;

  AppPageRoute({
    required this.page,
    this.type = TransitionType.slide,
  }) : super(
<<<<<<< HEAD
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, secondary, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeIn,
            );

            switch (type) {
              case TransitionType.fade:
                return FadeTransition(opacity: curved, child: child);
              case TransitionType.slide:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(curved),
                  child: FadeTransition(opacity: curved, child: child),
=======
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, secondary, child) {
            switch (type) {
              case TransitionType.fade:
                return FadeTransition(opacity: animation, child: child);
              case TransitionType.slide:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: FadeTransition(opacity: animation, child: child),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                );
              case TransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
<<<<<<< HEAD
                    begin: const Offset(0, 0.06),
                    end: Offset.zero,
                  ).animate(curved),
                  child: FadeTransition(opacity: curved, child: child),
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.94, end: 1.0).animate(curved),
                  child: FadeTransition(opacity: curved, child: child),
                );
              case TransitionType.sharedAxis:
                return FadeTransition(
                  opacity: curved,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.02, 0.02),
                      end: Offset.zero,
                    ).animate(curved),
                    child: child,
                  ),
=======
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: FadeTransition(opacity: animation, child: child),
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                  ),
                  child: FadeTransition(opacity: animation, child: child),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                );
            }
          },
        );
}

<<<<<<< HEAD
enum TransitionType { fade, slide, slideUp, scale, sharedAxis }
=======
enum TransitionType { fade, slide, slideUp, scale }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

/// Convenience extension on BuildContext.
extension NavigationExtension on BuildContext {
  Future<T?> pushPage<T>(Widget page,
      {TransitionType type = TransitionType.slide}) {
    return Navigator.of(this).push<T>(
      AppPageRoute<T>(page: page, type: type),
    );
  }
<<<<<<< HEAD

  Future<T?> pushPageUp<T>(Widget page) {
    return Navigator.of(this).push<T>(
      AppPageRoute<T>(page: page, type: TransitionType.slideUp),
    );
  }

  Future<T?> replacePage<T>(Widget page,
      {TransitionType type = TransitionType.fade}) {
    return Navigator.of(this).pushReplacement(
      AppPageRoute<T>(page: page, type: type),
    );
  }
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
