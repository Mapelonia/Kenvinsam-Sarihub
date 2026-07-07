import 'package:flutter/material.dart';

<<<<<<< HEAD
/// Adds a press-down scale animation to any child widget.
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;
=======
/// Wraps any widget to give it a subtle scale-down effect on press.
/// Provides tactile feedback that makes the UI feel premium.
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleAmount;
  final Duration duration;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
<<<<<<< HEAD
    this.scaleFactor = 0.96,
=======
    this.onLongPress,
    this.scaleAmount = 0.96,
    this.duration = const Duration(milliseconds: 100),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
<<<<<<< HEAD
  late Animation<double> _scale;
=======
  late Animation<double> _animation;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
<<<<<<< HEAD
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
=======
      duration: widget.duration,
      reverseDuration: const Duration(milliseconds: 150),
    );
    _animation = Tween<double>(begin: 1.0, end: widget.scaleAmount).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
=======
  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: widget.onTap != null ? _onTapDown : null,
      onTapUp: widget.onTap != null ? _onTapUp : null,
      onTapCancel: widget.onTap != null ? _onTapCancel : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.scale(
          scale: _animation.value,
          child: child,
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        child: widget.child,
      ),
    );
  }
}
