import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Modern dialog utility.
class AppDialog {
  /// Shows a confirmation dialog. Returns true if confirmed.
=======
/// Premium dialog helpers with consistent styling.
class AppDialog {
  /// A confirmation dialog with icon and color-coded action button.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
<<<<<<< HEAD
    IconData? icon,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final isDark = context.isDark;
        final actionColor = destructive ? AppTheme.error : AppTheme.primaryGreen;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          ),
          backgroundColor: isDark ? AppTheme.cardDark : Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: actionColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: actionColor, size: 26),
                ),
                const SizedBox(height: AppTheme.spaceLg),
              ],
              Text(
                title,
                style: AppTheme.headingMd.copyWith(
                  color: context.textPrimary,
                ),
=======
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    IconData icon = Icons.info_outline_rounded,
    Color? accentColor,
    bool destructive = false,
  }) async {
    final color = destructive
        ? AppTheme.error
        : (accentColor ?? AppTheme.primaryGreen);

    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              Text(
                title,
                style: AppTheme.headingMd,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                message,
<<<<<<< HEAD
                style: AppTheme.bodySm.copyWith(
                  color: context.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.space2xl),
=======
                style: AppTheme.bodySm
                    .copyWith(color: ctx.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceLg),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
<<<<<<< HEAD
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.borderColor),
                        foregroundColor: context.textPrimary,
                      ),
=======
                      onPressed: () => Navigator.pop(ctx, false),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      child: Text(cancelLabel),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    child: ElevatedButton(
<<<<<<< HEAD
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: actionColor,
                      ),
=======
                      style: ElevatedButton.styleFrom(backgroundColor: color),
                      onPressed: () => Navigator.pop(ctx, true),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      child: Text(confirmLabel),
                    ),
                  ),
                ],
              ),
            ],
          ),
<<<<<<< HEAD
        );
      },
    );
    return result ?? false;
  }

  /// Shows an info/alert dialog.
  static Future<void> info({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    String buttonLabel = 'OK',
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        final isDark = context.isDark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          ),
          backgroundColor: isDark ? AppTheme.cardDark : Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.info.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppTheme.info, size: 26),
                ),
                const SizedBox(height: AppTheme.spaceLg),
              ],
              Text(
                title,
                style: AppTheme.headingMd.copyWith(
                  color: context.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                message,
                style: AppTheme.bodySm.copyWith(
                  color: context.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.space2xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(buttonLabel),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
=======
        ),
      ),
    );
    return result ?? false;
  }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
