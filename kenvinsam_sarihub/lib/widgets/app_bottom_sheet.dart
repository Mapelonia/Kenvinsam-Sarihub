import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Modern bottom sheet utility.
class AppBottomSheet {
  /// Shows a bottom sheet with custom content.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool isScrollControlled = true,
    double maxHeightFactor = 0.85,
=======
/// Helper for showing premium bottom sheets with consistent styling.
class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget content,
    bool isScrollControlled = true,
    double? maxHeight,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
<<<<<<< HEAD
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * maxHeightFactor,
      ),
      builder: (context) {
        final isDark = context.isDark;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cardDark : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.radius2xl),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.spaceMd),
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.15)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppTheme.space2xl,
                    AppTheme.spaceLg,
                    AppTheme.space2xl,
                    AppTheme.spaceSm,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTheme.headingMd.copyWith(
                            color: context.textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.06)
                                : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: context.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: context.borderColor,
                  height: 1,
                ),
              ],
              Flexible(child: child),
            ],
          ),
        );
      },
=======
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) => _SheetWrapper(
        title: title,
        subtitle: subtitle,
        maxHeight: maxHeight,
        child: content,
      ),
    );
  }
}

class _SheetWrapper extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final double? maxHeight;

  const _SheetWrapper({
    required this.title,
    required this.child,
    this.subtitle,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final maxH = maxHeight ?? mediaQuery.size.height * 0.85;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxH),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusXl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spaceLg,
                AppTheme.spaceSm,
                AppTheme.spaceLg,
                AppTheme.spaceMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.headingMd),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppTheme.bodySm.copyWith(
                        color: context.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppTheme.spaceLg,
                  0,
                  AppTheme.spaceLg,
                  mediaQuery.viewInsets.bottom + AppTheme.spaceLg,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
  }
}
