import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Empty state placeholder widget.
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? action;
=======
/// A premium animated empty state placeholder.
class EmptyStateWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;
  final Color? color;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
<<<<<<< HEAD
    this.actionLabel,
    this.onAction,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.space2xl,
        vertical: AppTheme.space4xl,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : Colors.grey.shade100,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.lightGreen.withOpacity(0.08)
                  : AppTheme.primaryGreen.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: context.textMuted,
            ),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Text(
            title,
            style: AppTheme.headingSm.copyWith(
              color: context.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              subtitle!,
              style: AppTheme.bodySm.copyWith(
                color: context.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppTheme.spaceLg),
            TextButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(actionLabel!),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: AppTheme.spaceLg),
            action!,
          ],
        ],
=======
    this.action,
    this.color,
  });

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppTheme.primaryGreen;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.space2xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: child,
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.06),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(widget.icon, size: 40, color: color),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              widget.title,
              style: AppTheme.headingMd,
              textAlign: TextAlign.center,
            ),
            if (widget.subtitle != null) ...[
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                widget.subtitle!,
                style: AppTheme.bodySm.copyWith(
                  color: context.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (widget.action != null) ...[
              const SizedBox(height: AppTheme.space2xl),
              widget.action!,
            ],
          ],
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}
